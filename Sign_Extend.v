module Sign_Extend(In, Imm_Extend);
   input [31:0]In;
   output [ 31:0] Imm_Extend;

   assign Imm_Extend = (In[31]) ? {{20{1'b1}},In[31:20]} :
                                  {{20{1'b0}},In[31:20]};

endmodule