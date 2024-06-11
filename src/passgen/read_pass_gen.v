`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2022 10:23:18 AM
// Design Name: 
// Module Name: read_pass_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module read_pass_gen(
    input wire          i_read_pass_gen_clk,
    input wire          i_read_pass_gen_rst,
    input wire          i_read_pass_gen_restart,
    input wire          i_read_pass_gen_check_valid,
    input wire          i_read_pass_gen_pause,
    input wire  [7:0]   i_read_pass_gen_valid,
    input wire  [199:0] i_read_pass_gen_data,
    input wire          i_read_pass_gen_fifo_empty,
    output wire         o_read_pass_gen_fifo_rd_en,
    output wire [191:0] o_read_pass_gen_pw,
    output wire [31:0]  o_read_pass_gen_length,
    output wire         o_read_pass_gen_valid,
    output wire [31:0]  o_read_pass_gen_counter
    );
    
    reg [2:0]   read_pass_gen_state;
    localparam  IDLE_1ST    = 3'd0;
    localparam  RD_EN_1ST   = 3'd1;
    localparam  IDLE_NXT    = 3'd2;
    localparam  RD_EN_NXT   = 3'd3;
    reg         rd_en_fifo;
    reg [191:0] password;
    reg [31:0]  length_pass;
    reg         pass_valid;
    reg [7:0]   valid;
    reg [31:0]  counter_reg;
    assign o_read_pass_gen_counter = counter_reg;
    
    always @(posedge i_read_pass_gen_clk)
    begin
        if(!i_read_pass_gen_rst)
        begin
            length_pass         <= 8'd0;
            password            <= 192'd0;
            pass_valid          <= 1'b0;
            rd_en_fifo          <= 1'b0;
            valid                <= 8'h00;
            read_pass_gen_state <= IDLE_1ST;
        end
        else
        begin
            if((i_read_pass_gen_check_valid == 1'b1) || (i_read_pass_gen_restart == 1'b0))
            begin
                length_pass         <= 8'd0;
                password            <= 192'd0;
                pass_valid          <= 1'b0;
                rd_en_fifo          <= 1'b0;
                valid               <= 8'h00;
                counter_reg         <= 32'd0;
                read_pass_gen_state <= IDLE_1ST;                
            end
            else if ( i_read_pass_gen_pause == 1'b1) begin
                length_pass         <= 8'd0;
                password            <= 192'd0;
                pass_valid          <= 1'b0;
                rd_en_fifo          <= 1'b0;
                valid               <= 8'h00;
                read_pass_gen_state <= IDLE_1ST;
            end
            else 
            begin
                pass_valid  <= 1'b0;
                rd_en_fifo  <= 1'b0;
                if(i_read_pass_gen_valid == 8'h01)
                begin
                    valid   <= i_read_pass_gen_valid;
                end
                case(read_pass_gen_state)
                    IDLE_1ST: begin
                        if(i_read_pass_gen_fifo_empty == 1'b0)
                        begin
                            rd_en_fifo  <= 1'b1;
                            counter_reg <= 32'd1;
                            read_pass_gen_state <= RD_EN_1ST;
                        end
                        else
                        begin  
                            read_pass_gen_state <= IDLE_1ST;
                        end
                    end
                    RD_EN_1ST: begin
                        password    <= i_read_pass_gen_data[199:8];
                        length_pass <= i_read_pass_gen_data[7:0];    
                        pass_valid  <= 1'b1; 
                        read_pass_gen_state <= IDLE_NXT;                   
                    end
                    
                    IDLE_NXT: begin
                        if((i_read_pass_gen_fifo_empty == 1'b0) && (valid == 8'h01))
                        begin
                            valid       <= 8'h00;
                            rd_en_fifo  <= 1'b1;
                            counter_reg <= counter_reg + 1'b1;
                            read_pass_gen_state <= RD_EN_NXT;
                        end
                        else
                        begin  
                            read_pass_gen_state <= IDLE_NXT;
                        end                    
                    end
                    
                    RD_EN_NXT: begin
                        password    <= i_read_pass_gen_data[199:8];
                        length_pass <= i_read_pass_gen_data[7:0];    
                        pass_valid  <= 1'b1; 
                        read_pass_gen_state <= IDLE_NXT;                        
                    end
                endcase
            end
        end
    end
    
    assign o_read_pass_gen_fifo_rd_en = rd_en_fifo;
    assign o_read_pass_gen_pw = password;
    assign o_read_pass_gen_length = length_pass;
    assign o_read_pass_gen_valid = pass_valid;
    
    reg [12*8:0]display_state;
    always @(*)
    begin
        case(read_pass_gen_state)
            IDLE_1ST: display_state = "IDLE_1ST";
            RD_EN_1ST: display_state = "RD_EN_1ST";
            IDLE_NXT: display_state = "IDLE_NXT";
            RD_EN_NXT: display_state = "RD_EN_NXT";            
        endcase
    end
    
endmodule
