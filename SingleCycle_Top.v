`include "P_C.v"
`include "Instruction_memory.v"
`include "Register_files.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Control_Unit_Top.v"
`include "Data_Mem.v"
`include "PC_Adder.v"

module SingleCycle_Top(clk, rst);

   input clk, rst;

   wire [31:0] PC_Top, RD_Instr, RD1_Top, Imm_Extend_Top,ALUResult, ReadData, PCplus4;
   wire RegWrite;
   wire [ 2:0] ALUControl_Top;

   P_C P_C(
     .clk(clk),
     .rst(rst),
     .PC(PC_Top),
     .Pc_Next(PCplus4)

   );

   PC_Adder PC_Adder(
            .a(PC_Top),
            .b(32'd4),
            .c(PCplus4)

   );

   Instruction_memory Instruction_memory(
            .rst(rst),
            .A(PC_Top),
            .RD(RD_Instr)
   );

   Register_files Register_files(
             .clk(clk),
             .rst(rst),
             .WE3(RegWrite),
             .WD3(ReadData),
             .A1(RD_Instr[19:15]),
             .A2(),
             .A3(RD_Instr[11:7]),
             .RD1(RD1_Top),
             .RD2()


   );

   Sign_Extend Sign_Extend(
              .In(RD_Instr),
              .Imm_Extend(Imm_Extend_Top)

   );

   ALU ALU (
          .A(RD1_Top),
          .B(Imm_Extend_Top),
          .ALUControl(ALUControl_Top),
          .Result(ALUResult),
          .Z(),
          .N(),
          .C(),
          .V()
   );

   Control_Unit_Top Control_Unit_Top(
                           .op(RD_Instr[6:0]),
                           .RegWrite(RegWrite),
                           .ImmSrc(),
                           .ALUSrc(),
                           .MemWrite(),
                           .ResultSrc(),
                           .Branch(),
                           .funct3(RD_Instr[14:12]),
                           .funct7(),
                           .ALUControl(ALUControl_Top)
    
   );

   Data_Mem Data_Mem(
                 .A(ALUResult), 
                 .WD(), 
                 .clk(clk), 
                 .rst(rst), 
                 .WE(), 
                 .RD(ReadData)
    );

 

endmodule