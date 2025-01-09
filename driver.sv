`define DRV_IF vif.drv_mod.DRV
class my_driver extends uvm_driver#(my_transaction);
  `uvm_component_utils(my_sequencer)

  virtual spram_if vif;
  my_transaction req;

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual spram_if)::get(this,"","vif")) begin
      `uvm_fatal(get_type_name(),"VIF is not set")
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      drive();
    end
  endtask

  task drive();
    @(`DRV_IF);
    seq_item_port.get_next_item(req);
    `DRV_IF.enable=req.enable;
    `DRV_IF.we_en=req.we_en;
    `DRV_IF.addr=req.addr;
    `DRV_IF.data_in=req.data_in;
    seq_item_port.item_done(req);
  endtask
endclass
