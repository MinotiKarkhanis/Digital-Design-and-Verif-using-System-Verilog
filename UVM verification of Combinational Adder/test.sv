class test extends uvm_test
  `uvm_component_utils(test);
  
  function new(input string inst="TEST",uvm_component c);
    super.new(inst,c);
  endfunction
  
  generator gen;
  env e;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	gen=generator::type_id::create("gen");
	e=env::type_id::create("e",this);
  endfunction
  
  virtual task run_phase(uvm_phase phase); //run phase in env for running sequence
    phase.raise_objection(this);
	gen.start(e.a.seq);                    //start the sequence
	phase.drop_objection(this);
  endtask
endclass