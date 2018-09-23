`timescale 1ns/10ps

module testbench;
   reg clk;
   reg rst;
   wire [4:0] led;

   integer    i;

   counter counter1 (clk, rst, led);

   initial
     begin
        $dumpfile("counter_wave.vcd");
        $dumpvars(0, testbench);

        clk <= 0;
        rst <= 0;

        #500;
        clk <= 1;

        #500;

        rst <= 1;
        clk <= 0;

        #500;

        for (i = 0; i < 30; i++)
          begin
             clk <= 1;
             #500;
             clk <= 0;
             #500;
          end
     end // initial begin
endmodule // testbench
