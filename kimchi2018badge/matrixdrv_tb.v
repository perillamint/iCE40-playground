`timescale 1ns/10ps

module testbench;
   reg clk;
   reg rst;
   wire [1:0] mat_r;
   wire [1:0] mat_g;
   wire [1:0] mat_b;
   wire [3:0] mat_row;
   wire mat_clk;
   wire mat_lat;
   wire mat_oe;

   integer i;

   matrixdrv drvblk (clk, rst, mat_r, mat_g, mat_b, mat_row, mat_clk, mat_lat, mat_oe);

   initial begin
      $dumpfile("dotmatrix_wave.vcd");
      $dumpvars(0, testbench);

      clk <= 0;
      rst <= 0;
      #250;
      clk <= 1;
      #250;
      clk <= 0;
      rst <= 1;
      #250;
      for (i = 0; i < 30; i++)
        begin
           clk <= 1;
           #250;
           clk <= 0;
           #250;
        end
   end
endmodule // testbench
