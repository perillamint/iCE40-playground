module hd44780_data(input [6:0] address,
                    output [7:0] data);
   reg [7:0]                     data;

   always @ (address)
     begin
        case (address)
          7'h00: data <= "H";
          7'h01: data <= "e";
          7'h02: data <= "l";
          7'h03: data <= "l";
          7'h04: data <= "o";
          7'h05: data <= ",";
          7'h06: data <= " ";
          7'h07: data <= "w";
          7'h08: data <= "o";
          7'h09: data <= "r";
          7'h0a: data <= "l";
          7'h0b: data <= "d";
          7'h0c: data <= ".";
          7'h40: data <= "P";
          7'h41: data <= "r";
          7'h42: data <= "j";
          7'h43: data <= "I";
          7'h44: data <= "c";
          7'h45: data <= "e";
          7'h46: data <= "s";
          7'h47: data <= "t";
          7'h48: data <= "o";
          7'h49: data <= "r";
          7'h4a: data <= "m";
          7'h4b: data <= " ";
          7'h4c: data <= "F";
          7'h4d: data <= "T";
          7'h4e: data <= "W";
          7'h4f: data <= "!";
          default: data <= 8'h20;
        endcase // case (address)
     end
endmodule // hd44780_data
