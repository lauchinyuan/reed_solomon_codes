`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: lauchinyuan
// Email:lauchinyuan@yeah.net
// Create Date: 2023/05/30 22:13:42
// Design Name: reed_solomon_top
// Module Name: reed_solomon_top
// Description: 顶层模块
//////////////////////////////////////////////////////////////////////////////////
module reed_solomon_top(
        input wire          clk     ,
        input wire          rst_n   ,
        input wire [7:0]    data_in ,
        
        output wire[7:0]    code_out
    );
    
    //暂时只实现Reed-solomon编码
    reed_solomon_decoder reed_solomon_decoder_inst(
        .clk         (clk       ), //时钟信号
        .rst_n       (rst_n     ), //复位信号
        .data_in     (data_in   ), //一个clk周期输入一个Symbol,本设计中假设一个Symbol = 8bit
                      
        .encode_out  (code_out  )  //输出的RS编码数据,一个clk周期输出一个Symbol
    );
    
endmodule
