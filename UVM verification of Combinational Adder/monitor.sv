class monitor extends uvm_monitor;
  `uvm_component_utils(monitor);
  
  uvm_analysis_port #(transaction)send; //Constructor for analysis port
  
  function new(input string inst="monitor",uvm_component parent=null);
    super.new(path,parent);
	send_new("send",this);
  endfunction
  
  transaction t;//storing data that we receive from DUT
  virtual add_if aif;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	t=transaction::type_id::create("t");
	if(!uvm_config_db #(virtual add_if)::get(this,"",aif,aif))
	  `uvm_error("MON","Unable to access uvm_config_db",  );
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
	  #10; //waiting for delay applied at the driver
	  t.a=aif.a;
	  t.b=aif.b;
	  t.y=aif.y;
	  `uvm_info("MON",$sformat("Data sent to scoreboard a:%0d,b:%0d,y:%0d",t.a,t.b,t.y));
	  send.write(t); //send data to scoreboard
	end
  endtask

endclass