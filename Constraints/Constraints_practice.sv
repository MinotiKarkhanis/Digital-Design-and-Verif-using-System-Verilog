//Constraint for generating unique elements

class c1;
 rand bit[4:0]A[];
 constraint c1{
 A.size inside {[8:10]};} //need to constraint the size of dynamic array
 
constraint unique_elements{
foreach(A[i]){   //2 foreach loops to iterate over the array
   foreach(A[j]{
      if(i!=j)    //both indexes should not be same
	    A[i]!=A[j]; //condition to check each element is unique
   }
   }
}
endclass

//Constraint for generating unique elements in 2D array

class c2;
   rand bit[4:0]A[][];
   
    constraint c1{
       A.size inside {[8:10]};} //need to constraint the size of dynamic array
 
   constraint unique_elements{
   foreach(A[i,j]   //2 foreach loops to iterate over the 2D array
     foreach(A[a,b]
	  ((a!=i)&&(b!=j))->A[i][j]!=A[a][b]; //making sure that both the indexes of the array are different. Used implication operator.
   }
endclass

//Constraint to sort elements of an array in ascending order

class c3;

  rand bit[4:0]A[];
  
  constraint c1{
  A.size inside{[8:10]};
  }
  
  constraint ascending_order{
  foreach(A[i])
  (i>0)->A[i]>A[i-1];  //ascending order means 1,2,3,4. Used the implication operator.
  }
endclass

//Constraint to randomize no. of ones in a variable without using count ones

class c1;
 rand bit[7:0]w;
 int length;
 
 constraint c1{
   count_ones(w)==length; 
 }
 
 constraint c2{
   length==3;      //no. of ones in a variable
 }
 
 function int count_ones(bit[7:0]data_in);
   for(;data_in!=0;data_in=data_in>>1)begin // for loop to get rid of the LSB digit 
   count_ones+=data_in&1'b1; //ANDing data_in with 1'b1 gives the output as no. of ones 
   end
 endfunction
 
endclass

//Constraint to implement randc without using randc variables    https://testbench4u.com/2018/10/10/implement-randc-function-using-rand-in-system-verilog/!

class c1;
  bit[1:0]q[$];
  rand bit[1:0]y; 
  
  constraint c{
  !(y inside {q}); //the value of y should not be there already in the queue
  }
  
  function void post_randomize();
    q.push_front(y);
	
	if(q.size()==4) //if the size of the queue is equal to all the possible combinations, then delete the queue
	  q.delete();
  endfunction
  
endclass

//Constraint the array such that consecutive locations do not have value of 1

class c1;

rand int sdarr[];

constraint c1{
  sdarr.size==10; //constraint the no. of elements in the array
  
  foreach(sdarr[i]){
    sdarr[i] inside {[0:3]}; 
	
  if(sdarr[i]==1) //if the element of array is 1, next element should not be 1
    sdarr[i]!=sdarr[i-1];
}
}
endclass

//Constraint for odd numbers

class c1;
rand bit[5:0]A[];

constraint c1{
A.size==20; }

constraint c{
A inside {[10:30]};
}
constraint c2{
foreach(A[i]){
    A%2!=0; //condition for odd number
   if(i>0)
     A[i]>A[i-1];
}
}
endclass

//Constraint for divisible by 5

constraint c1{
rand bit[7:0]A[];

constraint c1{A.size inside {[0:100]}; }

constraint c2{
  foreach(A[i]){
  A[i]%5==0;
  if(i>0)
     A[i]>A[i-1];
  }
}
}



//Constraint Randomization of an Array : No consecutive bits should be one and No of ones should be 12

class packet;
  rand bit [31:0] addr;
 
  constraint addr_range { $countones(addr) == 12;
                         foreach(addr[i]) { 
                           if(i!=31 ) 
                           {
                             (addr[i] && addr[i+1])==0; 
                           }  
                         }}
endclass
 
module soft_constr;
  initial begin
    packet pkt;
    pkt = new();
    repeat(2) begin
      pkt.randomize();
      $display("\taddr = %0d",pkt.addr);
    end
  end
endmodule