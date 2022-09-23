#define patA0 10
#define patA1 11
#define patA2 12
#define patA3 13

#define patB0 14
#define patB1 15
#define patB2 16
#define patB3 17

#define SEL0 18
#define SEL1 19
#define SEL2 20
#define SEL3 21
#define SEL4 22
#define SEL5 23

#define RESULT0 24
#define RESULT1 25
#define RESULT2 26
#define RESULT3 27

void setup() {

  Serial.begin(9600);
  pinMode(patA0, OUTPUT);
  pinMode(patA1, OUTPUT);
  pinMode(patA2, OUTPUT);
  pinMode(patA3, OUTPUT);

  pinMode(patB0, OUTPUT);
  pinMode(patB1, OUTPUT);
  pinMode(patB2, OUTPUT);
  pinMode(patB3, OUTPUT);

  pinMode(SEL0, OUTPUT);
  pinMode(SEL1, OUTPUT);
  pinMode(SEL2, OUTPUT);
  pinMode(SEL3, OUTPUT);
  pinMode(SEL4, OUTPUT);
  pinMode(SEL5, OUTPUT);

  pinMode(RESULT0, INPUT);
  pinMode(RESULT1, INPUT);
  pinMode(RESULT2, INPUT);
  pinMode(RESULT3, INPUT);
  
}

void loop() {
  int ans = 0;
  int result = 0;
  for (int sel = 0; sel < 64; sel++) {
    bool zx = sel & 0x1;
    bool nx = sel & 0x2;
    bool zy = sel & 0x4;
    bool ny = sel & 0x8;
    bool f = sel & 0x16;
    bool no = sel & 0x32;
    for (int pat_a = 0; pat_a < 16; pat_a++) {
      for (int pat_b = 0; pat_b < 16; pat_b++) {
        Output_Pattern(pat_a, pat_b, zx, nx, zy, ny, f, no);
        ans = Calculate_Golden(pat_a, pat_b, zx, nx, zy, ny, f, no);
        result = Get_Result();
        if (ans != result) {
          Serial.print ("Pattern: ");
          Serial.print (sel*64+pat_a*16+pat_b*16);
          Serial.print (", ");
          Serial.print ("Pat_a: ");
          Serial.print (pat_a, BIN);
          Serial.print (", ");
          Serial.print ("Pat_b: ");
          Serial.print (pat_b, BIN);
          Serial.print (", ");
          Serial.print ("sel: ");
          Serial.print (zx);
          Serial.print (',');
          Serial.print (nx);
          Serial.print (',');
          Serial.print (zy);
          Serial.print (',');
          Serial.print (ny);
          Serial.print (',');
          Serial.print (f);
          Serial.print (',');
          Serial.print (no);
          Serial.print (", ");
          Serial.print ("Expect output: ");
          Serial.print (ans, BIN);
          Serial.print (", ");
          Serial.print ("Your output: ");
          Serial.println (result, BIN);
          return;
        }
        //delay(30);
      }
    }
  }
}

void Output_Pattern(int pat_a, int pat_b, bool zx, bool nx, bool zy, bool ny, bool f, bool no){
  //////////////////////////  pat_a
  if (pat_a & 0x8)
    digitalWrite(patA3, HIGH);
  else
    digitalWrite(patA3, LOW);
  if (pat_a & 0x4)
    digitalWrite(patA2, HIGH);
  else
    digitalWrite(patA2, LOW);
  if (pat_a & 0x2)
    digitalWrite(patA1, HIGH);
  else
    digitalWrite(patA1, LOW);
  if (pat_a & 0x1)
    digitalWrite(patA0, HIGH);
  else
    digitalWrite(patA0, LOW);
  //////////////////////////  pat_b
  if (pat_b & 0x8)
    digitalWrite(patB3, HIGH);
  else
    digitalWrite(patB3, LOW);
  if (pat_b & 0x4)
    digitalWrite(patB2, HIGH);
  else
    digitalWrite(patB2, LOW);
  if (pat_b & 0x2)
    digitalWrite(patB1, HIGH);
  else
    digitalWrite(patB1, LOW);
  if (pat_b & 0x1)
    digitalWrite(patB0, HIGH);
  else
    digitalWrite(patB0, LOW);
  //////////////////////////  pat_sel
  if (zx)
    digitalWrite(SEL0, HIGH);
  else
    digitalWrite(SEL0, LOW);
  if (nx)
    digitalWrite(SEL1, HIGH);
  else
    digitalWrite(SEL1, LOW);
  if (zy)
    digitalWrite(SEL2, HIGH);
  else
    digitalWrite(SEL2, LOW);
  if (ny)
    digitalWrite(SEL3, HIGH);
  else
    digitalWrite(SEL3, LOW);
  if (f)
    digitalWrite(SEL4, HIGH);
  else
    digitalWrite(SEL4, LOW);
  if (no)
    digitalWrite(SEL5, HIGH);
  else
    digitalWrite(SEL5, LOW);
  delay(2);
}

int Calculate_Golden(int pat_a, int pat_b, bool zx, bool nx, bool zy, bool ny, bool f, bool no){

  int nxA = nx ? 15 : 0;
  int x1 = pat_a ^ nxA;
  int nzx = zx ? 0 : 15;
  int x2 = nzx & x1;
  int nxandzx = (nx & zx) ? 15 : 0;
  int x3 = x2 | nxandzx;
  
  
  return x3;
}

int Get_Result() {
  int result = 0;
  
  result = (digitalRead(RESULT3)==HIGH) ? result | 0x8 : result;
  result = (digitalRead(RESULT2)==HIGH) ? result | 0x4 : result;
  result = (digitalRead(RESULT1)==HIGH) ? result | 0x2 : result;
  result = (digitalRead(RESULT0)==HIGH) ? result | 0x1 : result;
  
  return result & 0xf;
}
