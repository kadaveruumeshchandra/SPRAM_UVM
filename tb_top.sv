`include "interface.sv"
`include "tb_pkg.sv"
`include "design.v"
module tb_top;
  import uvm_pkg::*;
  import tb_pkg::*;

  bit clk,reset;

  spram_if vif(.clk(clk),.reset(reset),.enable(vif.enable),.we_en(vif.we_en),.addr(vif.addr),.data_in(vif.data_in),.data_out(vif.data_out));

  initial begin
    uvm_config_db#(virtual spram_if)::set(uvm_root::get(),"*","vif",vif);
  end

  initial begin
    reset=1;
    clk=0;
    #10 reset=0;
  end

  always #5 clk=~clk;

  initial begin
    run_test("base_test");
  end
endmodule
