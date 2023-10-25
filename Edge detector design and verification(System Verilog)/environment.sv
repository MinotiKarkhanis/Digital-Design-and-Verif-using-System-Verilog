//To share the mailbox handle across the generator and the driver

`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "scoreboard.sv"
`include "monitor.sv"

class environment;
  generator gen;
  driver    driv;
  monitor montr;
  scoreboard scrbrd;

  mailbox gen2driv;
  mailbox mon2scb;
  mailbox driv2scb;

  virtual intf vif;

  function new(virtual intf vif);
    this.vif=vif;
    gen2driv=new();
    mon2scb=new();
    //gen=new();
    //driv=new();
    //montr=new();
    //scrbrd=new();

    gen = new(gen2driv); //calling the function
    driv = new(vif,gen2driv,driv2scb);
    montr  = new(vif);
    scrbrd = new(vif,driv2scb,mon2scb);
  endfunction


  task run();
    //repeat(1000)
    //begin
    fork
      gen.main();
      driv.main();
      scrbrd.main();
      montr.main();
    join
    //end
  endtask

endclass