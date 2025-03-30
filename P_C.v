module P_C(Pc_Next, PC, rst,clk);
  
   input [31:0] Pc_Next;
   input rst,clk;

   output reg [31:0] PC;

   always @( posedge clk )
   begin
     if(rst==1'b0)     // by default we will take active low reset
     begin
        PC <= 32'h00000000;
     end
     else
     begin 
        PC <= Pc_Next;
     end

   end


endmodule