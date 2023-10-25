class monitor;

  //creating virtual interface handle
  virtual intf vif;

  //creating mailbox handle
  mailbox mon2scb;

  //constructor
  function new(virtual intf vif);
    //getting the interface
    this.vif = vif;
    //getting the mailbox handles from  environment
    this.mon2scb = mon2scb;
  endfunction

  task main;
    forever begin
      transaction trans;
      @(posedge vif.clock)
      begin
        trans = new();
        trans.risingEdge = vif.risingEdge;
        trans.fallingEdge = vif.fallingEdge;
        mon2scb.put(trans);
        //$display("MONITOR anyedge = %0b, rising = %0b, falling = %0b",trans.anyEdge,trans.risingEdge,trans.fallingEdge);
      end
    end
  endtask

endclass