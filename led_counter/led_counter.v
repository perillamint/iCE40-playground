module top (
	input  clk,
  input  rst,
	output LED0,
	output LED1,
	output LED2,
	output LED3,
	output LED4,
	output LED5,
	output LED6,
	output LED7
);

   localparam CLKDIV = 21;

   reg [CLKDIV:0] clkdiv;
   wire [7:0]     led;

   always@(posedge clk)
     begin
        clkdiv <= clkdiv + 1;
     end

   counter counter1 (clkdiv[CLKDIV], rst, led);

   assign {LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7} = led;
endmodule
