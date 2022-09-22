module ALU_tb();
    reg         zx, zy, nx, ny, f, no;
    reg [15:0]  x;
    reg [15:0]  y;
    reg [15:0]  exp_out;

    reg         exp_zr, exp_ng;

    wire [15:0] out;
    wire        zr, ng;

    ALU UUT(
        .x(x),
        .y(y),
        .zx(zx),
        .nx(nx),
        .zy(zy),
        .ny(ny),
        .f(f),
        .no(no),
        .out(out),
        .zr(zr),
        .ng(ng)
    );

    task assert_else_error;
        input reg [15:0] exp_out;
        input reg exp_zr;
        input reg exp_ng;
        if (out == exp_out && zr == exp_zr && exp_ng == ng) 
            begin
            end
            
        else
            begin
            $error("alu %b %b %b %b %b %b %b %b (%b %b) (%b %b) (%b %b)",
                x, y, zx, nx, zy, ny, f, no, out, exp_out, zr, exp_zr, ng, exp_ng);
            //$finish;
            end
    endtask

    initial
        begin
            x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 1;
            nx = 0;
            zy = 1;
            ny = 0;
            f = 1;
            no = 0;
            #1 assert_else_error(16'b0000000000000000, 16'b1, 16'b0);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 1;
            nx = 1;
            zy = 1;
            ny = 1;
            f = 1;
            no = 1;
            #1 assert_else_error(16'b0000000000000001, 16'b0, 16'b0);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 1;
            nx = 1;
            zy = 1;
            ny = 0;
            f = 1;
            no = 0;
            #1 assert_else_error(16'b1111111111111111, 16'b0, 16'b1);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 0;
            nx = 0;
            zy = 1;
            ny = 1;
            f = 0;
            no = 0;
            #1 assert_else_error(16'b0000000000000000, 16'b1, 16'b0);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 1;
            nx = 1;
            zy = 0;
            ny = 0;
            f = 0;
            no = 0;
            #1 assert_else_error(16'b1111111111111111, 16'b0, 16'b1);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 0;
            nx = 0;
            zy = 1;
            ny = 1;
            f = 0;
            no = 1;
            #1 assert_else_error(16'b1111111111111111, 16'b0, 16'b1);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 1;
            nx = 1;
            zy = 0;
            ny = 0;
            f = 0;
            no = 1;
            #1 assert_else_error(16'b0000000000000000, 16'b1, 16'b0);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 0;
            nx = 0;
            zy = 1;
            ny = 1;
            f = 1;
            no = 1;
            #1 assert_else_error(16'b0000000000000000, 16'b1, 16'b0);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 1;
            nx = 1;
            zy = 0;
            ny = 0;
            f = 1;
            no = 1;
            #1 assert_else_error(16'b0000000000000001, 16'b0, 16'b0);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 0;
            nx = 1;
            zy = 1;
            ny = 1;
            f = 1;
            no = 1;
            #1 assert_else_error(16'b0000000000000001, 16'b0, 16'b0);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 1;
            nx = 1;
            zy = 0;
            ny = 1;
            f = 1;
            no = 1;
            #1 assert_else_error(16'b0000000000000000, 16'b1, 16'b0);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 0;
            nx = 0;
            zy = 1;
            ny = 1;
            f = 1;
            no = 0;
            #1 assert_else_error(16'b1111111111111111, 16'b0, 16'b1);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 1;
            nx = 1;
            zy = 0;
            ny = 0;
            f = 1;
            no = 0;
            #1 assert_else_error(16'b1111111111111110, 16'b0, 16'b1);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 0;
            nx = 0;
            zy = 0;
            ny = 0;
            f = 1;
            no = 0;
            #1 assert_else_error(16'b1111111111111111, 16'b0, 16'b1);


            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 0;
            nx = 1;
            zy = 0;
            ny = 0;
            f = 1;
            no = 1;
            #1 assert_else_error(16'b0000000000000001, 16'b0, 16'b0);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 0;
            nx = 0;
            zy = 0;
            ny = 1;
            f = 1;
            no = 1;
            #1 assert_else_error(16'b1111111111111111, 16'b0, 16'b1);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 0;
            nx = 0;
            zy = 0;
            ny = 0;
            f = 0;
            no = 0;
            #1 assert_else_error(16'b0000000000000000, 16'b1, 16'b0);

            #1 x = 16'b0000000000000000;
            y = 16'b1111111111111111;
            zx = 0;
            nx = 1;
            zy = 0;
            ny = 1;
            f = 0;
            no = 1;
            #1 assert_else_error(16'b1111111111111111, 16'b0, 16'b1);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 1;
            nx = 0;
            zy = 1;
            ny = 0;
            f = 1;
            no = 0;
            #1 assert_else_error(16'b0000000000000000, 16'b1, 16'b0);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 1;
            nx = 1;
            zy = 1;
            ny = 1;
            f = 1;
            no = 1;
            #1 assert_else_error(16'b0000000000000001, 16'b0, 16'b0);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 1;
            nx = 1;
            zy = 1;
            ny = 0;
            f = 1;
            no = 0;
            #1 assert_else_error(16'b1111111111111111, 16'b0, 16'b1);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 0;
            nx = 0;
            zy = 1;
            ny = 1;
            f = 0;
            no = 0;
            #1 assert_else_error(16'b0000000000010001, 16'b0, 16'b0);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 1;
            nx = 1;
            zy = 0;
            ny = 0;
            f = 0;
            no = 0;
            #1 assert_else_error(16'b0000000000000011, 16'b0, 16'b0);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 0;
            nx = 0;
            zy = 1;
            ny = 1;
            f = 0;
            no = 1;
            #1 assert_else_error(16'b1111111111101110, 16'b0, 16'b1);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 1;
            nx = 1;
            zy = 0;
            ny = 0;
            f = 0;
            no = 1;
            #1 assert_else_error(16'b1111111111111100, 16'b0, 16'b1);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 0;
            nx = 0;
            zy = 1;
            ny = 1;
            f = 1;
            no = 1;
            #1 assert_else_error(16'b1111111111101111, 16'b0, 16'b1);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 1;
            nx = 1;
            zy = 0;
            ny = 0;
            f = 1;
            no = 1;
            #1 assert_else_error(16'b1111111111111101, 16'b0, 16'b1);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 0;
            nx = 1;
            zy = 1;
            ny = 1;
            f = 1;
            no = 1;
            #1 assert_else_error(16'b0000000000010010, 16'b0, 16'b0);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 1;
            nx = 1;
            zy = 0;
            ny = 1;
            f = 1;
            no = 1;
            #1 assert_else_error(16'b0000000000000100, 16'b0, 16'b0);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 0;
            nx = 0;
            zy = 1;
            ny = 1;
            f = 1;
            no = 0;
            #1 assert_else_error(16'b0000000000010000, 16'b0, 16'b0);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 1;
            nx = 1;
            zy = 0;
            ny = 0;
            f = 1;
            no = 0;
            #1 assert_else_error(16'b0000000000000010, 16'b0, 16'b0);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 0;
            nx = 0;
            zy = 0;
            ny = 0;
            f = 1;
            no = 0;
            #1 assert_else_error(16'b0000000000010100, 16'b0, 16'b0);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 0;
            nx = 1;
            zy = 0;
            ny = 0;
            f = 1;
            no = 1;
            #1 assert_else_error(16'b0000000000001110, 16'b0, 16'b0);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 0;
            nx = 0;
            zy = 0;
            ny = 1;
            f = 1;
            no = 1;
            #1 assert_else_error(16'b1111111111110010, 16'b0, 16'b1);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 0;
            nx = 0;
            zy = 0;
            ny = 0;
            f = 0;
            no = 0;
            #1 assert_else_error(16'b0000000000000001, 16'b0, 16'b0);

            #1 x = 16'b0000000000010001;
            y = 16'b0000000000000011;
            zx = 0;
            nx = 1;
            zy = 0;
            ny = 1;
            f = 0;
            no = 1;
            #1 assert_else_error(16'b0000000000010011, 16'b0, 16'b0);
        end

endmodule