module top (
            input  clk,
            input  rst,
            output mat_r0,
            output mat_g0,
            output mat_b0,
            output mat_r1,
            output mat_g1,
            output mat_b1,
            output mat_row0,
            output mat_row1,
            output mat_row2,
            output mat_row3,
            output mat_clk,
            output mat_lat,
            output mat_oe
);
   wire            clkline;
   wire [2:0]      pixelbitoff;

   wire [1:0]      mat_r;
   wire [1:0]      mat_g;
   wire [1:0]      mat_b;
   wire [3:0]      mat_row;

   // TODO: PLL
   assign clkline = clk;

   matrixdrv matdrv (clkline, rst, mat_r, mat_g, mat_b, mat_row, mat_clk, mat_lat, mat_oe);

   assign {mat_r0, mat_r1} = mat_r;
   assign {mat_g0, mat_g1} = mat_g;
   assign {mat_b0, mat_b1} = mat_b;
   assign {mat_row0, mat_row1, mat_row2, mat_row3} = mat_row;
endmodule
