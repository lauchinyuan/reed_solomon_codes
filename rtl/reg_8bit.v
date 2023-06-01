`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: lauchinyuan
// Email: lauchinyuan@yeah.net
// Create Date: 2023/05/31 08:53:30
// Design Name: reed_solomon_top
// Module Name: reg_8bit
// Description: 8bit寄存器,用于除法器电路中寄存"余数"
//////////////////////////////////////////////////////////////////////////////////
module reg_8bit(
        input   wire        clk     ,
        input   wire        rst_n   ,
        input   wire [7:0]  d_in    ,  //寄存器输入
        
        output  reg  [7:0]  q_out      //寄存器输出
    );
    
    
    //8bit寄存器
    always @ (posedge clk or negedge rst_n) begin
        if(rst_n == 1'b0) begin
            q_out <= 8'b0;
        end else begin
            q_out <= d_in;
        end
    end
    
endmodule
