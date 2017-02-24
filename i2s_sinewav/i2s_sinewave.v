module top (
	input  refclk,
    input  RST,
	output LED0,
	output LED1,
	output LED2,
	output LED3,
	output LED4,
	output LED5,
	output LED6,
	output LED7,
);

   wire    clk;
   localparam CLKDIV = 21;

   reg [CLKDIV:0] clkdiv;
   reg [7:0]     counter;

   pll pll_module(refclk, clk, 
                  , 
                  RST,);
   
   always@(posedge clk)
     begin
        clkdiv <= clkdiv + 1;

        if (clkdiv[CLKDIV])
          begin
             clkdiv <= 0;
	         counter <= counter + 1;
          end

     end // always@ (posedge clk)

   assign {LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7} = counter;
endmodule
