module spram(
  input clk,
  input enable,
  input we_en, //write enable
  input [3:0] addr,
  input [7:0] data_in,
  output reg [7:0] data_out
);
  reg [7:0] mem [15:0];

  always@(posedge clk) begin
    if(reset) begin
      data_out=8'b0000_0000;
    end
    else begin
      if(enable) begin
        if(we_en) begin
          mem[addr]<=data_in;
        end
        else begin
          data_out<=mem[addr];
        end
      end
    end
  end
endmodule
