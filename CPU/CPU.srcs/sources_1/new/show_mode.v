
module show_mode(
    input clk,//·ÖÆµÇ°
    input [2:0] mode,
    input [31:0] pc,
    input [31:0] pc_next,
    input [4:0] rs_ad,
    input [31:0] rs_data,
    input [4:0] rt_ad,
    input [31:0] rt_data,
    input [31:0] alu_result,
    input [31:0] db,
    input [2:0] state,
    output reg [7:0] output1,
    output reg [7:0] output2
    );
    always@(negedge clk)
    begin
        case(mode)
        3'b000:
        begin
            output1[7:0] = pc[7:0];
            output2[7:0] = pc_next[7:0];
        end
        
        3'b001:
        begin
            output1[7:5] = 3'b000;
            output1[4:0] = rs_ad[4:0];
            output2[7:0] = rs_data[7:0];
        end
        
        3'b010:
        begin
            output1[7:5] = 3'b000;
            output1[4:0] = rt_ad[4:0];
            output2[7:0] = rt_data[7:0];
        end
            
        3'b011:
        begin
            output1[7:0] = alu_result[7:0];
            output2[7:0] = db[7:0];
        end
        
        3'b100:
        begin
            output1[7:0]=0;
            output2[2:0]=state[2:0]; 
        end
        
        default
        begin
            output1 = 0;
            output2 = 0;
        end
        
        endcase
    end
endmodule
