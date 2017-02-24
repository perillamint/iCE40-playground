module pll(refclk, plloutcore, plloutglobal, reset);
   input refclk;
   input reset;
   output plloutcore;
   output plloutglobal;

   SB_PLL40_CORE pll_inst(.REFERENCECLK(refclk),
                          .PLLOUTCORE(plloutcore),
                          .PLLOUTGLOBAL(plloutglobal),
                          .EXTFEEDBACK(),
                          .DYNAMICDELAY(),
                          .RESETB(reset),
                          .BYPASS(1'b0),
                          .LATCHINPUTVALUE(),
                          .LOCK(),
                          .SDI(),
                          .SDO(),
                          .SCLK());

   defparam pll_inst.DIVR = 4'b0000;
   defparam pll_inst.DIVF = 7'b1111111;
   defparam pll_inst.DIVQ = 3'b011;
   defparam pll_inst.FILTER_RANGE = 3'b001;
   defparam pll_inst.FEEDBACK_PATH = "SIMPLE";
   defparam pll_inst.DELAY_ADJUSTMENT_MODE_FEEDBACK = "FIXED";
   defparam pll_inst.FDA_FEEDBACK = 4'b0000;
   defparam pll_inst.DELAY_ADJUSTMENT_MODE_RELATIVE = "FIXED";
   defparam pll_inst.FDA_RELATIVE = 4'b0000;
   defparam pll_inst.SHIFTREG_DIV_MODE = 2'b00;
   defparam pll_inst.PLLOUT_SELECT = "GENCLK";
   defparam pll_inst.ENABLE_ICEGATE = 1'b0;
endmodule // pll
