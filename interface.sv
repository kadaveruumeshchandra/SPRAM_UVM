interface spram_if(input clk,reset);
  logic we_en;
  logic enable;
  logic [3:0] addr;
  logic [7:0] data_in;
  logic [7:0] data_out;

  clocking DRV@(posedge clk);
    default input #1 output #1;
    input data_out;
    output we_en;
    output enable;
    output addr;
    output data_in;
  endclocking

  clocking MON@(posedge clk);
    default input #1 output #1;
    input data_in;
    input reset;
    input we_en;
    input enable;
    input addr;
    input data_out;
  endclocking

  modport drv_mod(clocking DRV,input clk,reset);
  modport mon_mod(clocking MON,input clk);
endinterface
