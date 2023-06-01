`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: lauchinyuan
// Email: lauchinyuan@yeah.net
// Create Date: 2023/05/31 12:18:58
// Design Name: reed_solomon_top
// Module Name: tb_reed_solomon_decoder
// Description: testbench for reed_solomon_decoder module
//////////////////////////////////////////////////////////////////////////////////

module tb_reed_solomon_decoder(

    );
    reg         clk     ;
    reg         rst_n   ;
    reg  [7:0]  data_in ;
    wire [7:0]  encode_out;
    
    integer i;
    initial begin
        clk = 1'b1;
        rst_n <= 1'b0;
        data_in <= 8'b0;
    #20
        rst_n <= 1'b1;
        for(i=0;i<=289;i=i+1) begin
            #20
                data_in <= data_in + 8'd1;  //输入数据自增,作测试
        end
    end
    
    always #10 clk = ~clk;
    
    reed_solomon_decoder reed_solomon_decoder_inst(
        .clk         (clk       ), //时钟信号
        .rst_n       (rst_n     ), //复位信号
        .data_in     (data_in   ), //一个clk周期输入一个Symbol,本设计中假设一个Symbol = 8bit
                      
        .encode_out  (encode_out)  //输出的RS编码数据,一个clk周期输出一个Symbol
    );
endmodule
