// Code for detecting rising and falling edge

module edgeDetect(clock,reset,anyEdge,risingEdge,fallingEdge);
  input logic clock,reset,anyEdge;
  output logic risingEdge,fallingEdge;
  logic lastEdge;

  always_ff @(posedge clock)
    begin
      if(reset)
        begin
          lastEdge<=1'b0;
        end
      else 
        begin
          lastEdge<=anyEdge;
        end
    end
  
  assign risingEdge =(anyEdge)&(~lastEdge);
  assign fallingEdge=(~anyEdge)&(lastEdge);
  
endmodule