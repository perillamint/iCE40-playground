module hd44780(
               input        clk, // 1MHz clock only
               input        rst_n,
               output       lcd_rs,
               output       lcd_rw,
               output       lcd_clk,
               output [7:0] lcd_data
               );
   reg                      lcd_rs;
   reg                      lcd_rw;
   reg                      lcd_clk;
   reg [7:0]                lcd_data;

   reg [15:0]               count;
   reg [7:0]                state;

   reg [7:0]                lcd_command_seq;
   wire [7:0]               lcd_command;
   wire [15:0]              lcd_command_cycles;

   reg [6:0]                lcd_data_seq;
   wire [7:0]               lcd_character;

   reg                      row;
   reg [4:0]                col;

   localparam maxcol = 16;

   hd44780_init hd44780_seq (.address(lcd_command_seq),
                             .data(lcd_command),
                             .cycles(lcd_command_cycles));

   hd44780_data textrom (.address(lcd_data_seq),
                         .data(lcd_character));

   always @ (negedge clk, negedge rst_n)
     begin
        if (!rst_n)
          begin
             count <= 0;
             state <= 0;
             lcd_rs <= 0;
             lcd_rw <= 0;
             lcd_clk <= 1;
             lcd_data <= 8'h00;
             lcd_command_seq <= 0;
             lcd_data_seq <= 0;
             row <= 0;
             col <= 0;
          end
        else
          begin
             case(state)
               8'h00:
                 begin
                    if (count > 16'd15000) // 15ms
                      begin
                         count <= 16'h0000;
                         state <= state + 1;
                      end
                    else
                      begin
                         lcd_rs <= 0;
                         lcd_rw <= 0;
                         lcd_clk <= 1;
                         lcd_data <= 8'h00;
                         count <= count + 1;
                      end
                 end // case: 8'h00
               8'h01: // Phase 1 -- Write command
                 begin
                    if (lcd_command == 8'h00)
                      begin
                         // TODO: Exit init seq
                         state <= 8'h04;
                      end
                    else
                      begin
                         lcd_data <= lcd_command;
                         state <= state + 1;
                      end
                 end // case: 8'h01
               8'h02: // Phase 2 -- Generate clock
                 begin
                    if (count > 16'd1)
                      begin
                         count <= 0;
                         state <= state + 1;
                         lcd_clk <= 1;
                      end
                    else
                      begin
                         lcd_clk <= 0;
                         count <= count + 1;
                      end
                 end // case: 8'h02
               8'h03: // Phase 3 -- wait for command completion
                 begin
                    if (count > lcd_command_cycles)
                      begin
                         // GOTO Phase 1
                         state <= 8'h01;
                         count <= 0;
                         lcd_command_seq <= lcd_command_seq + 1;
                      end
                    else
                      begin
                         count <= count + 1;
                      end
                 end // case: 8'h03
               8'h04:
                 begin
                    lcd_rs <= 0;
                    lcd_data <= 8'h80 | lcd_data_seq;
                    state <= state + 1;
                 end
               8'h05:
                 begin
                    if (count > 16'd1)
                      begin
                         count <= 0;
                         state <= state + 1;
                         lcd_clk <= 1;
                      end
                    else
                      begin
                         lcd_clk <= 0;
                         count <= count + 1;
                      end
                 end
               8'h06:
                 begin
                    if (count > 16'd160)
                      begin
                         count <= 0;
                         state <= state + 1;
                      end
                    else
                      begin
                         count <= count + 1;
                      end
                 end // case: 8'h06
               8'h07:
                 begin
                    if (col > (maxcol))
                      begin
                         row <= row + 1;
                         col <= 0;
                      end
                    else
                      begin
                         lcd_rs <= 0;
                         lcd_data <= 8'h80 | (row << 6) | col;
                         lcd_data_seq <= (row << 6) | col;
                         col <= col + 1;
                         state <= state + 1;
                      end
                 end
               8'h08:
                 begin
                    if (count > 16'd1)
                      begin
                         count <= 0;
                         state <= state + 1;
                         lcd_clk <= 1;
                      end
                    else
                      begin
                         lcd_clk <= 0;
                         count <= count + 1;
                      end
                 end
               8'h09:
                 begin
                    if (count > 16'd160)
                      begin
                         count <= 0;
                         state <= state + 1;
                      end
                    else
                      begin
                         count <= count + 1;
                      end
                 end // case: 8'h09
               8'h0a:
                 begin
                    lcd_rs <= 1;
                    lcd_data <= lcd_character;
                    state <= state + 1;
                 end
               8'h0b:
                 begin
                    if (count > 16'd1)
                      begin
                         count <= 0;
                         state <= state + 1;
                         lcd_clk <= 1;
                      end
                    else
                      begin
                         lcd_clk <= 0;
                         count <= count + 1;
                      end
                 end // case: 8'h0b
               8'h0c:
                 begin
                    if (count > 16'd160)
                      begin
                         count <= 0;
                         state <= 8'h07; // Ad Infinitum
                      end
                    else
                      begin
                         count <= count + 1;
                      end
                 end // case: 8'h0c
               default:
                 begin
                    lcd_clk <= 1;
                 end
             endcase // case (state)
          end
     end
endmodule // hd44780
