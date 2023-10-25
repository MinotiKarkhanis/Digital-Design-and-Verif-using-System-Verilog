//interface to group the signals

interface intf(input logic clock,reset);
  logic anyEdge;
  logic risingEdge,fallingEdge;

  modport TB(
    input clock,
    input reset,
    input anyEdge,
    output risingEdge,
    output fallingEdge);
  
endinterface