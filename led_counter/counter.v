module counter (
                input        clk,
                input        rst,
                output [7:0] led
                );

   reg [7:0]                 counter;

   always@(posedge clk)
     begin
        if (!rst)
          begin
             counter <= 0;
          end
        counter <= counter + 1;
     end // always@ (posedge clk)

   assign led = counter;
endmodule // counter
