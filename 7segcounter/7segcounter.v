module top (
	input  clk,
    input  RESET,
	output LED0,
	output LED1,
	output LED2,
	output LED3,
	output LED4,
	output LED5,
	output LED6,
	output LED7,
    output A,
    output B,
    output C,
    output D,
    output E,
    output F,
    output G,
    output DP,
    output C0,
    output C1,
    output C2,
);

   localparam CLKDIV = 21;
   localparam REFCLK = 16;

   reg [CLKDIV:0] clkdiv;
   reg [REFCLK:0] refclk;
   reg [1:0]      state;
   reg [2:0]      com_driv;
   reg [11:0]     counter;
   reg            dot;
   reg [7:0]      sevenseg;
   wire [7:0]     bcdwire1;
   wire [7:0]     bcdwire2;
   wire [7:0]     bcdwire3;

   bcdto7seg dec1 (counter[3:0], bcdwire1, dot, clk);
   bcdto7seg dec2 (counter[7:4], bcdwire2, dot, clk);
   bcdto7seg dec3 (counter[11:8], bcdwire3, dot, clk);
   
   always@(posedge clk)
     begin
        clkdiv <= clkdiv + 1;
        refclk <= refclk + 1;

        if (RESET == 0)
          begin
             counter <= 0;
             clkdiv <= 0;
          end

        if (clkdiv[CLKDIV])
          begin
             clkdiv <= 0;
	         counter <= counter + 1;
             dot <= 0;
          end

        if (refclk[REFCLK])
          begin
             refclk <= 0;
             state <= state + 1;

             if(state == 3)
               state <= 0;

             case (state)
               0:
                 begin
                    com_driv <= 3'b100;
                    sevenseg <= bcdwire1;
                 end
               1:
                 begin
                    com_driv <= 3'b010;
                    sevenseg <= bcdwire2;
                 end
               2:
                 begin
                    com_driv <= 3'b001;
                    sevenseg <= bcdwire3;
                 end
             endcase // case (state)
          end // if (refclk[REFCLK])
     end // always@ (posedge clk)

   assign {LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7} = sevenseg;
   assign {A, B, C, D, E, F, G, DP} = ~sevenseg;
   assign {C2, C1, C0} = com_driv;
endmodule
