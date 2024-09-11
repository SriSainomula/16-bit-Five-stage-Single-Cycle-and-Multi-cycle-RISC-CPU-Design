`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.09.2024 23:01:18
// Design Name: 
// Module Name: Data_Path
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


module Data_Path(
    input clk, rst, PCSrc, PC_write, IPR_enable, IR_enable, IM_sel, RegWrite, z, g, ALUSrcA, MemtoReg, MemWrite,  
    input [1:0] ALUSrcB, ALUControl,
    output [7:0] PC, datamem_addr,
    output [15:0] Instr, Instruction, IPR_out,
    output PCEn,
    output [15:0] out,
    output zout, gout
    );
    
    wire [15:0]ref_out;
    wire PC_enable;
    wire zero, greater_than;
    wire[7:0] Addr;
    wire [15:0] PCNext, IPR_in;
    wire [15:0] rega_in, regb_in, reg_wdata, rega_out, regb_out, WD, datamem_out;
    wire [15:0] SrcA, SrcB, ALUResult, ALUOut;
    
    
    //Additional Gates we have used in DataPath
    assign zout=(z && zero);
    assign gout=(g && greater_than);
    assign PC_enable=(PC_write || zout || gout); 
    assign datamem_addr= ALUOut[7:0];
    assign WD= regb_out;
    assign PCEn = PC_enable;
    assign out = (rst == 1'b1) ? 16'b0 : ref_out;
    
    
    //Connecting the Various Blocks in Data Path
    
    //PC MUX
    mux2_16 PC_mux(
        .I0(ALUResult), 
        .I1({9'b000000000,Instruction[15:12],Instruction[5:3]}),
        .sel(PCSrc),
        .out(PCNext)
    );    

    //PC REGISTER 
    flipflops_8 PCreg(
        .clk(clk),
        .rst(rst),
        .en(PC_enable),
        .D(PCNext[7:0]),
        .Q(PC)
    );  
         
    //IM MUX
    mux2_8 IM_mux(
        .I0(PC),
        .I1(ALUResult),
        .sel(IM_sel),
        .out(Addr)
    );
    
    //INSTRUCTION MEMORY
    Instruction_Memory instrmem (
        .a(Addr),      // input wire [7 : 0] a
        .spo(Instr)  // output wire [15 : 0] spo
    );
    
    //INSTRUCTION PREFETCH REGISTER
    flipflops_16 IPR(
        .clk(clk),
        .rst(rst),
        .en(IPR_enable),
        .D(Instr),
        .Q(IPR_out)
     );  
         
    //INSTRUCTION REGISTER
    flipflops_16 IR(
        .clk(clk),
        .rst(rst),
        .en(IR_enable),
        .D(IPR_out),
        .Q(Instruction));   
        
    //REGISTER FILE
    Register_File reg_file(
        .clk(clk),
        .rst(rst),
        .write_en(RegWrite),
        .A1(Instruction[8:6]),
        .A2(Instruction[11:9]),
        .A3(Instruction[5:3]),
        .RD1(rega_in),
        .RD2(regb_in),
        .WD3(reg_wdata),
        .ref_out(ref_out)
     );
     
     //REGISTER A
     flipflops_16 regA(
        .clk(clk),
        .rst(rst),
        .en(1'b1),
        .D(rega_in),
        .Q(rega_out)
     );
         
    //REGISTER B
    flipflops_16 regB(
        .clk(clk),
        .rst(rst),
        .en(1'b1),
        .D(regb_in),
        .Q(regb_out)
    );
    
    //MUX A
    mux2_16 muxA(
        .I0({8'b0,PC}), 
        .I1(rega_out),
        .sel(ALUSrcA),
        .out(SrcA)
    ); 
          
    //MUX B
    mux4_16 muxB(
        .I0(regb_out), 
        .I1(16'h0001),
        .I2({9'b000000000,Instruction[15:9]}),
        .I3({9'b000000000,Instruction[15:12],Instruction[5:3]}),
        .sel(ALUSrcB),
        .out(SrcB)
    ); 
    
    //ALU
    ALU ALU(
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .zero_flag(zero),
        .greater_flag(greater_than),
        .ALUResult(ALUResult)
    );
    
    //ALU REGISTER
    flipflops_16 ALU_reg(
        .clk(clk),
        .rst(rst),
        .en(1'b1),
        .D(ALUResult),
        .Q(ALUOut)
    );
    
    //DATA MEMORY
    Data_Memory datamem (
        .a(datamem_addr),      // input wire [7 : 0] a
        .d(WD),      // input wire [15 : 0] d
        .clk(clk),  // input wire clk
        .we(MemWrite),    // input wire we
        .spo(datamem_out)  // output wire [15 : 0] spo
    );
    
    //REGISTER FILE WRITE MUX
    mux2_16 reg_mux(
        .I0(ALUOut), 
        .I1(datamem_out),
        .sel(MemtoReg),
        .out(reg_wdata));  
    
endmodule
