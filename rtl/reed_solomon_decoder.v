`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: lauchinyuan
// Email: lauchinyuan@yeah.net
// Create Date: 2023/05/31 08:30:12
// Design Name: reed_solomon_top
// Module Name: reed_solomon_decoder
// Description: RS(255,223)编码器,核心是由寄存器、乘法器、加法器构成的"除法电路"
//////////////////////////////////////////////////////////////////////////////////
module reed_solomon_decoder(
        input wire          clk         , //时钟信号
        input wire          rst_n       , //复位信号
        input wire  [7:0]   data_in     , //一个clk周期输入一个Symbol,本设计中假设一个Symbol = 8bit
        
        output wire [7:0]   encode_out    //输出的RS编码数据,一个clk周期输出一个Symbol
    );
    
    //反馈数据,当feedback选择为0时,“余数”不再变化,除法器输出余数
    //当feedback选择为data_in+r_q[31]时,继续进行求余运算
    wire [7:0] feedback     ;
    
    //32个乘法单元的输出
    wire [7:0] g  [31:0]    ;
    
    //32个加法单元的输出
    wire [7:0] s  [31:0]    ;
    
    //寄存器单元的输出
    wire [7:0] r_q [31:0]   ;
    
    //计数器,用于MUX数据源选择,计数值为0-255
    reg [7:0] cnt          ;
    
    //定义乘法器用到的生成多项式g(x)的根的二进制表达,可以通过查找GF(2^8)的元素表得到
    parameter ALPHA_18  =   8'h2d,
              ALPHA_251 =   8'hd8,
              ALPHA_215 =   8'hef,
              ALPHA_28  =   8'h18,
              ALPHA_80  =   8'hfd,
              
              ALPHA_107 =   8'h68,
              ALPHA_248 =   8'h1b,
              ALPHA_53  =   8'h28,
              ALPHA_84  =   8'h6b,
              ALPHA_194 =   8'h32,
              
              ALPHA_91  =   8'ha3,
              ALPHA_59  =   8'hd2,
              ALPHA_176 =   8'he3,
              ALPHA_99  =   8'h86,
              ALPHA_203 =   8'he0,
              
              ALPHA_137 =   8'h9e,
              ALPHA_43  =   8'h77,
              ALPHA_104 =   8'h0d,
              //ALPHA_137 =   8'h9e,
              ALPHA_0   =   8'h01,
              
              ALPHA_44  =   8'hee,
              ALPHA_149 =   8'ha4,
              ALPHA_148 =   8'h52,
              ALPHA_218 =   8'h2b,
              ALPHA_75  =   8'h0f,
              
              ALPHA_11  =   8'he8,
              ALPHA_173 =   8'hf6,
              ALPHA_254 =   8'h8e,
              //ALPHA_194 =   8'h32;
              
              ALPHA_109 =   8'hbd,
              ALPHA_8   =   8'h1d;
              //ALPHA_11  =   8'he8;
              
    //计数器
    always @ (posedge clk or negedge rst_n) begin
        if(rst_n == 1'b0) begin
            cnt <= 8'b0;
        end else if(cnt == 8'd255) begin
            cnt <= 8'b0;
        end else begin
            cnt <= cnt + 8'd1;
        end
    
    end
    
      
    //构建伽罗华乘法器阵列,一共需要32个伽罗华域乘法器
    gf2_8_mul gf2_8_mul_0(
        .A   (feedback),  
        .B   (ALPHA_18),  

        .P   (g[0])   
    );

    gf2_8_mul gf2_8_mul_1(
        .A   (feedback),  
        .B   (ALPHA_251),  

        .P   (g[1])   
    );

    gf2_8_mul gf2_8_mul_2(
        .A   (feedback),  
        .B   (ALPHA_215),  

        .P   (g[2])   
    );

    gf2_8_mul gf2_8_mul_3(
        .A   (feedback),  
        .B   (ALPHA_28),  

        .P   (g[3])   
    );

    gf2_8_mul gf2_8_mul_4(
        .A   (feedback),  
        .B   (ALPHA_80),  

        .P   (g[4])   
    );

    gf2_8_mul gf2_8_mul_5(
        .A   (feedback),  
        .B   (ALPHA_107),  

        .P   (g[5])   
    );

    gf2_8_mul gf2_8_mul_6(
        .A   (feedback),  
        .B   (ALPHA_248),  

        .P   (g[6])   
    );

    gf2_8_mul gf2_8_mul_7(
        .A   (feedback),  
        .B   (ALPHA_53),  

        .P   (g[7])   
    );

    gf2_8_mul gf2_8_mul_8(
        .A   (feedback),  
        .B   (ALPHA_84),  

        .P   (g[8])   
    );

    gf2_8_mul gf2_8_mul_9(
        .A   (feedback),  
        .B   (ALPHA_194),  

        .P   (g[9])   
    );

    gf2_8_mul gf2_8_mul_10(
        .A   (feedback),  
        .B   (ALPHA_91),  

        .P   (g[10])   
    );

    gf2_8_mul gf2_8_mul_11(
        .A   (feedback),  
        .B   (ALPHA_59),  

        .P   (g[11])   
    );

    gf2_8_mul gf2_8_mul_12(
        .A   (feedback),  
        .B   (ALPHA_176),  

        .P   (g[12])   
    );

    gf2_8_mul gf2_8_mul_13(
        .A   (feedback),  
        .B   (ALPHA_99),  

        .P   (g[13])   
    );

    gf2_8_mul gf2_8_mul_14(
        .A   (feedback),  
        .B   (ALPHA_203),  

        .P   (g[14])   
    );

    gf2_8_mul gf2_8_mul_15(
        .A   (feedback),  
        .B   (ALPHA_137),  

        .P   (g[15])   
    );

    gf2_8_mul gf2_8_mul_16(
        .A   (feedback),  
        .B   (ALPHA_43),  

        .P   (g[16])   
    );

    gf2_8_mul gf2_8_mul_17(
        .A   (feedback),  
        .B   (ALPHA_104),  

        .P   (g[17])   
    );

    gf2_8_mul gf2_8_mul_18(
        .A   (feedback),  
        .B   (ALPHA_137),  

        .P   (g[18])   
    );

    gf2_8_mul gf2_8_mul_19(
        .A   (feedback),  
        .B   (ALPHA_0),  

        .P   (g[19])   
    );

    gf2_8_mul gf2_8_mul_20(
        .A   (feedback),  
        .B   (ALPHA_44),  

        .P   (g[20])   
    );

    gf2_8_mul gf2_8_mul_21(
        .A   (feedback),  
        .B   (ALPHA_149),  

        .P   (g[21])   
    );

    gf2_8_mul gf2_8_mul_22(
        .A   (feedback),  
        .B   (ALPHA_148),  

        .P   (g[22])   
    );

    gf2_8_mul gf2_8_mul_23(
        .A   (feedback),  
        .B   (ALPHA_218),  

        .P   (g[23])   
    );


    gf2_8_mul gf2_8_mul_24(
        .A   (feedback),  
        .B   (ALPHA_75),  

        .P   (g[24])   
    );

    gf2_8_mul gf2_8_mul_25(
        .A   (feedback),  
        .B   (ALPHA_11),  

        .P   (g[25])   
    );

    gf2_8_mul gf2_8_mul_26(
        .A   (feedback),  
        .B   (ALPHA_173),  

        .P   (g[26])   
    );

    gf2_8_mul gf2_8_mul_27(
        .A   (feedback),  
        .B   (ALPHA_254),  

        .P   (g[27])   
    );

    gf2_8_mul gf2_8_mul_28(
        .A   (feedback),  
        .B   (ALPHA_194),  

        .P   (g[28])   
    );


    gf2_8_mul gf2_8_mul_29(
        .A   (feedback),  
        .B   (ALPHA_109),  

        .P   (g[29])   
    );

    gf2_8_mul gf2_8_mul_30(
        .A   (feedback),  
        .B   (ALPHA_8),  

        .P   (g[30])   
    );

    gf2_8_mul gf2_8_mul_31(
        .A   (feedback),  
        .B   (ALPHA_11),  

        .P   (g[31])   
    );

    //构建伽罗华域加法器阵列,先构建输出数据输入到寄存器的31个加法器
    //使用generate语句进行例化
    genvar i;
    generate
        for(i=0;i<=30;i=i+1) begin: adder_inst
            gf2_8_add gf2_8_add_inst_i(
                .A   (g[i+1]),  //被加数,来自乘法器
                .B   (r_q[i]),  //加数,来自上一级寄存器

                .S   (s[i])     //和,输出给下一级寄存器
            );
        end
    endgenerate
    
    
    //例化生成feedback非零数据的加法器
    gf2_8_add gf2_8_add_feedback_gen(
        .A   (r_q[31]),  //被加数,来自最后一级寄存器
        .B   (data_in),  //加数,输入数据

        .S   (s[31]  )   //和,作为feedback MUX输入数据的一端
    );
    
    
    
    //除法器电路需要 (255-223)=32个寄存器来寄存"余数"
    //多项式系数最低部分的电路无需加法器,单独例化
    reg_8bit r0(
        .clk     (clk),
        .rst_n   (rst_n),
        .d_in    (g[0]),  //寄存器输入,来自乘法器

        .q_out   (r_q[0]) //寄存器输出,给加法器
    );
    
    //其他的寄存器的外围结构一样,使用generate语句进行例化
    generate
        for(i=1;i<=31;i=i+1) begin: reg_inst
            reg_8bit regi_inst(
                .clk     (clk),
                .rst_n   (rst_n),
                .d_in    (s[i-1]),  //寄存器输入,来自加法器
        
                .q_out   (r_q[i])   //寄存器输出,给加法器
            );
        end
    endgenerate  

    //feedback,前k个周期输入数据,后(n-k)个周期输入0
    assign feedback = (cnt <= 223)? data_in : 8'b0;
    
    //RS码输出,前k个周期输出符号就是输入符号,后(n-k)个周期输出求余后的结果
    assign encode_out = (cnt <= 223)? data_in: r_q[31];
    
endmodule
