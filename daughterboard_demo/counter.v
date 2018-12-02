module counter (
                input        clk,
                input        rst,
                output [3:0] cnt,
                output       carry
                );

   reg [4:0]                 counter;
   reg                       carry;

   always@(posedge clk, negedge rst)
     begin
        if (!rst)
          begin
             counter <= 0;
             carry <= 0;
          end
        else
          begin
             if (counter == 4'b1001)
               begin
                  counter <= 0;
                  carry <= 1;
               end
             else
               begin
                  counter <= counter + 1;
                  carry <= 0;
               end
          end
     end // always@ (posedge clk)

   assign cnt = counter;
endmodule // counter
