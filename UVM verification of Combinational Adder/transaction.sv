//Transaction-Variable or a data member for the input and output port present in the DUT

`include "uvm_macros.svh"  //Mandatory file required to compile uvm code
import uvm_pkg::*;   //Mandatory file required to compile uvm code


class transaction extends uvm_sequence_item;
	rand bit[3:0]a;
	rand bit[3:0]b;
	bit[4:0]y;
	
	function new(input string path="transaction"); //Standard constructor for uvm_object
	  super.new(path);
	endfunction
	
	`uvm_object_utils_begin(transaction)  //Adding field macros to the data members
	`uvm_field_int(a,UVM_DEFAULT)
	`uvm_field_int(b,UVM_DEFAULT)
	`uvm_field_int(y,UVM_DEFAULT)
	`uvm_object_utils_end
endclass
