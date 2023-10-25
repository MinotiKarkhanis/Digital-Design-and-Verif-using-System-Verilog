//Generating stimulus: Randomizing the transaction class and sending the randomized class to the driver

class generator;
  rand transaction trans; //declaring transaction class
  mailbox gen2driv;       //declaring mailbox


  //constructor
  function new(mailbox gen2driv);
    //getting the mailbox handle from env
    this.gen2driv = gen2driv;
  endfunction

  task main();
    repeat(100)
      begin
        trans = new();
        if( !trans.randomize() ) $fatal("Gen:: trans randomization failed");
        //$display("GENERATOR anyedge = %0b, rising = %0b, falling = %0b",this.trans.anyEdge,this.trans.risingEdge,this.trans.fallingEdge);
        gen2driv.put(trans);
      end
  endtask

endclass