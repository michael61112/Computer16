`define PATH_IC /home/rduser08/project/Computer16/IC
//`include "./Mux16/Mux16.v"
`include "./ALU/ALU.v"
`include "./Register16/Register16.v"
`include "./PC/PC.v"

module CPU(
    input   [15:0] inM,         // M value input  (M = contents of RAM[A])
    input   [15:0] instruction, // Instruction for execution
    input   reset,           // Signals whether to re-start the current program
    input   clk,             // (reset == 1) or continue executing the current
    input   rst_n,           // program (reset == 0).

    output  [15:0] outM,        // M value output
    output  writeM,          // Write into M? 
    output  [14:0] addressM,    // RAM address (of M)
    output  [14:0] pc ,         // ROM address (of next instruction)
    output z,
    output n
);
    wire [15:0] ALUout, Aregin, Aout, Dout, AMout;
    wire ALUtoA, loadA, selM, loadD;
    wire ZRout, NGout, PCload, PCinc;
    wire zx, nx, zy, ny, f, no;
    wire [15:0] pc_temp;
    wire tt;
    assign z = loadA;
    assign n = ALUtoA;
    InstructionHandling IH(
        .instruction(instruction),
        .ALUtoA(ALUtoA),
        .loadA(loadA),
        .selM(selM),
        .loadD(loadD),
        .writeM(writeM)
    );

    Control ctl(
        .ZRout(ZRout),
        .NGout(NGout),
        .clk(clk),
        .instruction(instruction),
        .PCload(PCload),
        .PCinc(PCinc)
    );
    assign zx = instruction[11];
    assign nx = instruction[10];
    assign zy = instruction[9];
    assign ny = instruction[8];
    assign f = instruction[7];
    assign no = instruction[6];
    
    Mux16 mux0(instruction, ALUout, ALUtoA, Aregin);
    Register16 Areg(.in(Aregin), .clock(clk), .load(loadA), .rst_n(rst_n), .out(Aout));
    Mux16 mux1(.a(Aout), .b(inM), .sel(selM), .out(AMout));
    Register16 Dreg(.in(ALUout), .clock(clk), .load(loadD), .rst_n(rst_n), .out(Dout));
    ALU alu(
        .x (Dout),
        .y (AMout),
        .zx (zx),
        .nx (nx),
        .zy (zy),
        .ny (ny),
        .f (f),
        .no (no),
        .out (ALUout),
        .zr (ZRout),
        .ng (NGout)
    );
    
    assign addressM = Aout[14:0];
    assign outM = ALUout;
    PC pc0(
        .in(Aout),
        .clock(clk),
        .load(PCload),
        .inc(PCinc),
        .reset(reset),
        .out(pc_temp) , //[14:0]
        .t(tt)
    );
    assign pc = pc_temp[14:0];
endmodule;

        
module InstructionHandling(
    input[15:0] instruction,
    output ALUtoA, loadA, selM, loadD, writeM
);
    wire Ainstruction, Cinstruction;
    assign Ainstruction = !instruction[15];
    assign Cinstruction = instruction[15];
    assign ALUtoA = Cinstruction  & instruction[5];
    assign loadA = Ainstruction | ALUtoA;
    assign selM = instruction[12];
    assign loadD = Cinstruction & instruction[4];
    assign writeM = Cinstruction & instruction[3];

endmodule;
    
module Control(
    input ZRout, NGout, clk,
    input [15:0] instruction,
    output PCload, PCinc
);
//    reg jeq, jlt, jgt, jumpToA;
//    always@(posedge clk) begin
//        jeq <= ZRout & instruction[1];
//        jlt <= NGout & instruction[2];
//        jgt <= !(ZRout | NGout) & instruction[0];
//        jumpToA <= jeq | jlt | jgt;
//        PCload <= instruction[15] & jumpToA;
//        PCinc <= !PCload;
//    end
    assign jeq = ZRout & instruction[1];
    assign jlt = NGout & instruction[2];
    assign jgt = !(ZRout | NGout) & instruction[0];
    assign jumpToA = jeq | jlt | jgt;
    assign PCload = instruction[15] & jumpToA;
    assign PCinc = !PCload;
endmodule;