class scoreboard;

  virtual intf vif;

  //creating mailbox handle
  mailbox mon2scb;
  mailbox driv2scb;

  //used to count the number of transactions
  int no_transactions;
  //logic exp_risingEdge,exp_fallingEdge,exp_lastEdge;

  //constructor

  function new(virtual intf vif,mailbox driv2scb,mon2scb);
    //getting the mailbox handles from  environment
    this.mon2scb = mon2scb;
    this.driv2scb = driv2scb;
    this.vif = vif;
  endfunction

  //Compares the Actual result with the expected result
  task main;
    begin
      transaction trans_a,trans_b;
      //@(posedge vif.clock)
      forever
      begin
        driv2scb.get(trans_a);
        mon2scb.get(trans_b);
        $display("SCOREBOARD: ANYEDGE = %0b, RISING EDGE = %0b, FALLING EDGE = %0b", trans_a.anyEdge, trans_b.risingEdge,trans_b.fallingEdge);
        no_transactions++;
        $display("number of transactions = %0d", no_transactions);
      end
    end
  endtask
endclass