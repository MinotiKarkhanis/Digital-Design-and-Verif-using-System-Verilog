module assertion(input clock,reset,anyEdge,risingEdge,fallingEdge);

  riseDetect:assert property(@(posedge clock) disable iff (reset) $rose(anyEdge)|->risingEdge);

    fallDetect:assert property(@(posedge clock) disable iff (reset) $fell(anyEdge)|->fallingEdge);

endmodule 