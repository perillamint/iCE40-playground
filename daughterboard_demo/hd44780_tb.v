`timescale 1ns/10ps

module hd44780_tb;
   reg clk;
   reg rst_n;
   wire lcd_rs;
   wire lcd_rw;
   wire lcd_clk;
   wire [7:0] lcd_data;

   integer    i;

   hd44780 hd44780_drv (.clk(clk),
                        .rst_n(rst_n),
                        .lcd_rs(lcd_rs),
                        .lcd_rw(lcd_rw),
                        .lcd_clk(lcd_clk),
                        .lcd_data(lcd_data));
   initial begin
      $dumpfile("hd44780_wave.vcd");
      $dumpvars(0, hd44780_drv);
      clk <= 0;
      rst_n <= 1;
      #500;
      rst_n <= 0;
      #500;
      rst_n <= 1;
      #500;
      for (i = 0; i < 60000; i++)
        begin
           clk <= 1;
           #500;
           clk <= 0;
           #500;
        end
      $finish;
   end
endmodule // hd44780_tb
