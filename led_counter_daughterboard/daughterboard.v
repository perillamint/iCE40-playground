module top (
            input         clk,
            input         rst,
            input [15:0]  switch,
            output [15:0] led,
            output        A,
            output        B,
            output        C,
            output        D,
            output        E,
            output        F,
            output        G,
            output        DP,
            output [7:0]  fnd_row
            );

   localparam CLKDIV = 19;
   localparam FNDCLKDIV = 10;

   reg [CLKDIV:0] clkdiv;
   reg [2:0]      bcdoff;

   wire [7:0]     cntcarry;
   wire [3:0]     bcdcnt [7:0];
   reg [3:0]      bcddigit;
   reg [7:0]      fnd_rowsel;
   wire [7:0]     sevenseg;

   always@(posedge clk)
     begin
        clkdiv <= clkdiv + 1;
     end

   always@(posedge clkdiv[FNDCLKDIV])
     begin
        bcdoff <= bcdoff + 1;
        bcddigit <= bcdcnt[bcdoff + 1];
     end

   always @ (bcdoff)
     begin
        case(bcdoff)
          3'h0: fnd_rowsel <= 8'b00000001;
          3'h1: fnd_rowsel <= 8'b00000010;
          3'h2: fnd_rowsel <= 8'b00000100;
          3'h3: fnd_rowsel <= 8'b00001000;
          3'h4: fnd_rowsel <= 8'b00010000;
          3'h5: fnd_rowsel <= 8'b00100000;
          3'h6: fnd_rowsel <= 8'b01000000;
          3'h7: fnd_rowsel <= 8'b10000000;
        endcase // case (bcdoff)
     end

   assign cntcarry[0] = clkdiv[CLKDIV];

   counter counter1 (cntcarry[0], rst, bcdcnt[0], cntcarry[1]);
   counter counter2 (cntcarry[1], rst, bcdcnt[1], cntcarry[2]);
   counter counter3 (cntcarry[2], rst, bcdcnt[2], cntcarry[3]);
   counter counter4 (cntcarry[3], rst, bcdcnt[3], cntcarry[4]);
   counter counter5 (cntcarry[4], rst, bcdcnt[4], cntcarry[5]);
   counter counter6 (cntcarry[5], rst, bcdcnt[5], cntcarry[6]);
   counter counter7 (cntcarry[6], rst, bcdcnt[6], cntcarry[7]);
   counter counter8 (cntcarry[7], rst, bcdcnt[7]);
   bcdto7seg bcdconv1 (bcddigit, sevenseg, swbuf[0]);

   //assign led = swbuf;
   assign led[3:0] = bcdcnt[0] & switch[3:0];
   assign led[7:4] = bcdcnt[1] & switch[7:4];
   assign led[11:8] = bcdcnt[2] & switch[11:8];
   assign led[15:12] = bcdcnt[3] & switch[15:12];
   assign fnd_row = fnd_rowsel;
   assign {A, B, C, D, E, F, G, DP} = sevenseg;
endmodule
