module matrixdrv (
                  input clk,
                  input rst,
                  output [1:0] mat_r,
                  output [1:0] mat_g,
                  output [1:0] mat_b,
                  output [3:0] mat_row,
                  output mat_clk,
                  output mat_lat,
                  output mat_oe
);
   reg [1:0]       r;
   reg [1:0]       g;
   reg [1:0]       b;
   reg [5:0]       clkcnt;
   reg [3:0]       address;
   reg             matclk;
   reg             latch;
   reg             outputen;
   wire [4:0]      pixelbitoff;

   assign pixelbitoff = clkcnt >> 1;

   always@(posedge clk)
     begin
        if (!rst)
          begin
             r <= 3;
             g <= 3;
             b <= 3;
             clkcnt <= 0;
             address <= 0;
             matclk <= 0;
             latch <= 0;
             outputen <= 0;
          end // if (!rst)

        if (clkcnt < 10)
          begin
             latch <= 0;
             outputen <= 0;

             matclk <= clkcnt[0];
             //if (!matclk)
             //  begin
             //     // Set pixel
             //  end
             //else
             //  begin
             //     // Set clock line to high
             //  end
          end
        else
          begin
             r <= 0;
             g <= 0;
             b <= 0;
             matclk <= 0;
             if (clkcnt[0])
               begin
                  latch <= 1;
                  outputen <= 1;
               end
             else
               begin
                  latch <= 0;
                  outputen <= 0;
               end
          end // else: !if(clkcnt < 10)

        if (clkcnt <= 12)
          begin
             clkcnt <= clkcnt + 1;
          end
        else
          begin
             clkcnt <= 0;
          end
     end // always@ (posedge clk)

   always @ (negedge clk)
     begin
        if (clkcnt == 5'b01101)
          begin
             address <= address + 1;
          end
     end

   assign mat_r = r;
   assign mat_g = g;
   assign mat_b = b;
   assign mat_row = address;
   assign mat_clk = matclk;
   assign mat_lat = latch;
   assign mat_oe = outputen;
endmodule // matrixdrv
