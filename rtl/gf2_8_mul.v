`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: lauchinyuan
// Email: lauchinyuan@yeah.net
// Create Date: 2023/05/30 22:15:32
// Design Name: reed_solomon_top
// Module Name: gf2_8_mul
// Description: 伽罗华域GF(2^8)的乘法器
//              模块的输入输出对应了伽罗华域中的多项式
//              输入、输出多项式的最高幂次均为8-1=7
//////////////////////////////////////////////////////////////////////////////////
module gf2_8_mul(
        input wire [7:0]    A   ,  //被乘数
        input wire [7:0]    B   ,  //乘数
        
        output wire[7:0]    P      //积
    );
    
    //多项式幂次为7的两个数相乘展开后最高幂次为14,对应15bit二进制数
    //超出GF(2^8)表示范围,先暂存,后续进行处理
    wire [14:0]  t_reg       ;   
    
    //依据伽罗华域GF(2^8)中的运算规则,预处理多项式的每一位
    assign t_reg[0]  = (A[0] & B[0]); 
    assign t_reg[1]  = (A[0] & B[1]) ^ (A[1] & B[0]);
    assign t_reg[2]  = (A[0] & B[2]) ^ (A[1] & B[1]) ^ (A[2] & B[0]);
    assign t_reg[3]  = (A[0] & B[3]) ^ (A[1] & B[2]) ^ (A[2] & B[1]) ^ (A[3] & B[0]);
    assign t_reg[4]  = (A[0] & B[4]) ^ (A[1] & B[3]) ^ (A[2] & B[2]) ^ (A[3] & B[1]) ^ (A[4] & B[0]);
    assign t_reg[5]  = (A[0] & B[5]) ^ (A[1] & B[4]) ^ (A[2] & B[3]) ^ (A[3] & B[2]) ^ (A[4] & B[1]) ^ (A[5] & B[0]); 
    assign t_reg[6]  = (A[0] & B[6]) ^ (A[1] & B[5]) ^ (A[2] & B[4]) ^ (A[3] & B[3]) ^ (A[4] & B[2]) ^ (A[5] & B[1]) ^ (A[6] & B[0]);
    assign t_reg[7]  = (A[0] & B[7]) ^ (A[1] & B[6]) ^ (A[2] & B[5]) ^ (A[3] & B[4]) ^ (A[4] & B[3]) ^ (A[5] & B[2]) ^ (A[6] & B[1]) ^ (A[7] & B[0]);
    assign t_reg[8]  = (A[1] & B[7]) ^ (A[2] & B[6]) ^ (A[3] & B[5]) ^ (A[4] & B[4]) ^ (A[5] & B[3]) ^ (A[6] & B[2]) ^ (A[7] & B[1]);
    assign t_reg[9]  = (A[2] & B[7]) ^ (A[3] & B[6]) ^ (A[4] & B[5]) ^ (A[5] & B[4]) ^ (A[6] & B[3]) ^ (A[7] & B[2]);
    assign t_reg[10] = (A[3] & B[7]) ^ (A[4] & B[6]) ^ (A[5] & B[5]) ^ (A[6] & B[4]) ^ (A[7] & B[3]);
    assign t_reg[11] = (A[4] & B[7]) ^ (A[5] & B[6]) ^ (A[6] & B[5]) ^ (A[7] & B[4]);
    assign t_reg[12] = (A[5] & B[7]) ^ (A[6] & B[6]) ^ (A[7] & B[5]);
    assign t_reg[13] = (A[6] & B[7]) ^ (A[7] & B[6]);
    assign t_reg[14] = (A[7] & B[7]);
    
    
    assign P[0] = t_reg[0] ^ t_reg[8]  ^ t_reg[12] ^ t_reg[13] ^ t_reg[14];
    assign P[1] = t_reg[1] ^ t_reg[9]  ^ t_reg[13] ^ t_reg[14]            ;
    assign P[2] = t_reg[2] ^ t_reg[8]  ^ t_reg[10] ^ t_reg[12] ^ t_reg[13];
    assign P[3] = t_reg[3] ^ t_reg[8]  ^ t_reg[9]  ^ t_reg[11] ^ t_reg[12];
    assign P[4] = t_reg[4] ^ t_reg[8]  ^ t_reg[9]  ^ t_reg[10] ^ t_reg[14];
    assign P[5] = t_reg[5] ^ t_reg[9]  ^ t_reg[10] ^ t_reg[11]            ;
    assign P[6] = t_reg[6] ^ t_reg[10] ^ t_reg[11] ^ t_reg[12]            ;
    assign P[7] = t_reg[7] ^ t_reg[11] ^ t_reg[12] ^ t_reg[13]            ;
    
endmodule
