module Instruction_memory(A, rst, RD);

  input [31:0] A;
  input rst;

  output [31:0] RD;

// creation of memory
  reg [31:0] Mem [1023:0];

  assign RD = (rst == 1'b0) ? 32'h00000000 : Mem[A[31:2]];
  
   initial begin
       
       Mem[0] = 32'hFFC4A303;
   end
 
endmodule