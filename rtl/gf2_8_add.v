`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: lauchinyuan
// Email: lauchinyuan@yeah.net
// Create Date: 2023/05/31 08:25:42
// Design Name: reed_solomon_top
// Module Name: gf2_8_add
// Description: 伽罗华域GF(2^8)的加法器,实际上就是8bit按位异或操作
//              模块的输入输出对应了伽罗华域中的多项式
//              输入、输出多项式的最高幂次均为8-1=7
//////////////////////////////////////////////////////////////////////////////////
module gf2_8_add(
        input wire [7:0]    A   ,  //被加数
        input wire [7:0]    B   ,  //加数
        
        output wire[7:0]    S      //和
    );
    
    //在伽罗华域GF(2^w)中,加法就是按位异或操作
    assign S = A ^ B;
    
endmodule
