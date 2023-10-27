class driver extends uvm_driver #(transaction);
  `uvm_component_utils(driver)

  function new(input string path="driver",uvm_component parent=null); //Standard constructor for an uvm_component
     super.new(path,parent);
  endfunction

  transaction tc; //Data container to store the data that is received from sequencer
  virtual add_if aif;

  virtual function void build_phase(uvm_phase phase)
    super.build_phase(phase)
    tc=transaction::type_id::create("tc");//Object of data container
  
    if(!uvm_config_db #(virtual add_if)::get(this,"""aif",aif))
    `uvm_error("DRV",unable to access uvm_config_db");
  
  endfunction
  
  virtual task run_phase(uvm_phase phase)
    forever begin
      seq_item_port.get_next_item(tc); //Port to communicate with sequencer. Send request to sequencer that driver is ready to receive new data
	  aif.a<=tc.a; //using non-blocking to give true results. Will give results on correct posedge of clock
	  aif.b<=tc.b;
	
	  `uvm_info("DRV",$sformat("Trigger DUT a:%0d, b:%0d",tc.a,tc.b),UVM_NONE);
	  seq_item_port.item_done();//send acknowledgement to sequencer and finally to a sequence
	  #10; //each new sequence is applied at an interval of 10ns
    end
  endtask
  
endclass
  
  
  
  
