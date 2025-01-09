class my_transaction extends uvm_sequence_item;
  `uvm_object_utils(my_transaction)
  rand bit enable;
  rand bit we_en;
  rand bit [3:0] addr;
  rand bit [7:0] data_in;
  bit reset;
  bit [7:0] data_out;
  int count;

  constraint c1{enable==1;}
  constraint c2{
    if(count<15)
    {we_en==1};
    else
    {we==0};
  }

  function new(string name="my_transaction");
    super.new(name);
  endfunction

  function void post_randomize();
    count++;
    if(count==20) begin
      count=0;
    end
  endfunction

  function void do_copy(uvm_object rhs);
    my_transaction tr;
    $cast(tr,rhs);
    super.do_copy(rhs);
    addr=tr.addr;
    we_en=tr.we_en;
    enable=tr.enable;
    reset=tr.reset;
    data_in=tr.data_in;
    data_out=tr.data_out;
  endfunction

  function string convert2string;
    string s;
    s=$sformatf("enable:%0b we_en:%0b addr:%0d data_in:%0d data_out:%0d",enable,we_en,addr,data_in,data_out);
    return s;
  endfunction

  virtual function bit do_compare(uvm_object rhs,uvm_comparer comparer);
    bit res;
    my_transaction _pkt;
    $cast(_pkt,rhs);
    super.do_comparer(_pkt,comparer);
    res=super.do_compare(_pkt,comparer)&(we_en==_pkt.we_en)&(enable==_pkt.enable)&(addr==_pkt.addr)&(data_in==_pkt.data_in)&(data_out==_pkt.data_out);
    return res;
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_int("enable",enable,$bits(enable),UVM_HEX);
    printer.print_int("we_en",we_en,$bits(we_en),UVM_HEX);
    printer.print_int("addr",addr,$bits(addr),UVM_HEX);
    printer.print_int("data_in",data_in,$bits(data_in),UVM_HEX);
    printer.print_int("data_out",data_out,$bits(data_out),UVM_HEX);
  endfunction
endclass
    
