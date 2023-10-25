`include "interface.sv"
`include "test.sv"
`include "assertions.sv"
module testbench;
  bit clock;
  bit reset;

  always #5 clock = ~clock;
  //creatinng instance of interface, inorder to connect DUT and testcase
  intf i_intf(clock,reset);
  test testTB(i_intf.TB);

  edgeDetect uut(
    .clock(clock),
    .reset(reset),
    .anyEdge(i_intf.anyEdge),
    .risingEdge(i_intf.risingEdge),
    .fallingEdge(i_intf.fallingEdge)
  );

  bind edgeDetect assertion dut(
    .clock(clock), 
    .reset(reset),
    .anyEdge(i_intf.anyEdge),   
    .risingEdge(i_intf.risingEdge),
    .fallingEdge(i_intf.fallingEdge)
  );


  initial begin
    reset = 1'b1; #5
    reset =1'b0;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #500 
    $finish;
  end
endmodule