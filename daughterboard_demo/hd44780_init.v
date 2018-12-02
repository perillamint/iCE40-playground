module hd44780_init(input [7:0] address,
                    output [7:0]  data,
                    output [15:0] cycles);
   reg [7:0]                     data;
   reg [15:0]                    cycles;

   always @ (address)
     begin
        case(address)
          8'h00:
            begin
               data <= 8'h30;
               cycles <= 16'd15000;
            end
          8'h01:
            begin
               data <= 8'h30;
               cycles <= 16'd5000;
            end
          8'h02:
            begin
               data <= 8'h30;
               cycles <= 16'd10000;
            end
          8'h03:
            begin
               data <= 8'h02;
               cycles <= 16'd2000;
            end
          8'h04:
            begin
               data <= 8'h38;
               cycles <= 16'd160;
            end
          8'h05:
            begin
               data <= 8'h0e;
               cycles <= 16'd160;
            end
          8'h06:
            begin
               data <= 8'h01;
               cycles <= 16'd160;
            end
          8'h07:
            begin
               data <= 8'h06;
               cycles <= 16'd160;
            end
          default:
            begin
               data <= 8'h00;
               cycles <= 16'h0000;
            end
        endcase // case (address)
     end
endmodule // hd44780_init
