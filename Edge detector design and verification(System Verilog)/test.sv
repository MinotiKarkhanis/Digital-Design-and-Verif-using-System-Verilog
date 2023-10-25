`include "environment.sv"

program test(intf.TB i_intf);

  //declaring environment instance
  environment env;

  initial begin
    //creating environment construct
    env = new(i_intf);

    //calling run of env
    //for (int i=0; i<=100; i=i+1)
      env.run();
  end
endprogram
