//Sequence - Send random stimulus to DUT and analyze

class generator extends uvm_sequence #(transaction);//operating on transaction parameter
	`uvm_object_utils(generator) //register class to a factory
	transaction t;  //object of transaction class to use start item and finish item
	integer i;
	
	function new(input string path="generator"); //Standard constructor for uvm_object(Dynamic component)
		super.new(path)
	endfunction
	
	virtual task body();
		t=transaction::type_id::create("t");
		repeat(10)//send 10 random stimulus
		begin
			start_item(t);
			t.randomize();
			`uvm_info("GEN",$sformat("Data send to Driver a:%0d, b:%0d",t.a,t.b)UVM_NONE); //reporting macros
			finish_item(t);
		end
	endtask
endclass