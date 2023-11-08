class agent extends uvm_agent;
  `uvm_component_utils(agent);
  
  function new(input string inst="AGENT",uvm_component);
    super.new(inst,c);
  endfunction
  
  monitor m; //instance of monitor
  driver d; //instance of driver
  uvm_sequencer #(transaction)seqr; //instance of sequencer
  
  virtual function void build_phase(uvm_phase phase);  //creating objects of all the components
    super.build_phase(phase);
	m=monitor::type_id::create("m",this);
	d=driver::type_id::create("d",this);
	seq=uvm_sequncer #(transaction::type_id::create("seqr",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase); //connecting driver and sequencer
   super.connect_phase(phase);    //On a driver we have seq item port and on a sequencer we have seq item export
   d.seq_item_port_connect(seqr.seq_item_export);
  endfunction
endclass