class driver;
  //used to count the number of transactions
  int no_transactions;

  //creating virtual interface handle
  virtual intf vif;

  //creating mailbox handle
  mailbox gen2driv;
  mailbox driv2scb;

  //constructor
  function new(virtual intf vif, mailbox gen2driv, driv2scb);
    //getting the interface
    this.vif = vif;
    //getting the mailbox handles from  environment
    this.gen2driv = gen2driv;
    this.driv2scb = driv2scb;
  endfunction

  //drivers the transaction items to interface signals
  task main;
    forever 
      begin
        @(posedge vif.clock)
        begin
          transaction trans;
          gen2driv.get(trans);
          driv2scb.put(trans);
          vif.anyEdge=trans.anyEdge;
          no_transactions++;
          $display("DRIVER anyedge = %0b, rising = %0b, falling = %0b",trans.anyEdge,trans.risingEdge,trans.fallingEdge);
        end
      end
  endtask

endclass
