module bcdto7seg (bcd, sevenseg, dot, set);
   input [3:0]      bcd;
   input            dot;
   input            set;
   output reg [7:0] sevenseg;

   always @(posedge set)
     begin
        case(bcd)
          4'h0: sevenseg <= 8'b11111100 | dot;
          4'h1: sevenseg <= 8'b01100000 | dot;
          4'h2: sevenseg <= 8'b11011010 | dot;
          4'h3: sevenseg <= 8'b11110010 | dot;
          4'h4: sevenseg <= 8'b01100110 | dot;
          4'h5: sevenseg <= 8'b10110110 | dot;
          4'h6: sevenseg <= 8'b00111110 | dot;
          4'h7: sevenseg <= 8'b11100000 | dot;
          4'h8: sevenseg <= 8'b11111110 | dot;
          4'h9: sevenseg <= 8'b11100110 | dot;
          4'ha: sevenseg <= 8'b11111010 | dot;
          4'hb: sevenseg <= 8'b00111110 | dot;
          4'hc: sevenseg <= 8'b00011010 | dot;
          4'hd: sevenseg <= 8'b01111010 | dot;
          4'he: sevenseg <= 8'b10011010 | dot;
          4'hf: sevenseg <= 8'b10001010 | dot;
        endcase // case (bcd)
     end // always @ (posedge set)
endmodule // sevensegdrv
