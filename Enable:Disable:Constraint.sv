class generator;

  randc bit [3:0] raddr,waddr;
  rand bit wr; // write to mem
  rand bit oe; // output enable
 
  constraint wr_c {
    wr dist {0 := 50, 1 := 50};
                   }

  constraint oe_c {
    oe dist {1 := 50, 0 := 50};
                  }

  constraint wr_oe_c {
    ( wr == 1) -> ( oe == 0 ) ;
                      }
  /*
  constraint write { 
    if(wr == 1)
    {
      waddr inside {[11:15]};
      raddr == 0;
     }
    else
    {
      waddr == 0;
      raddr inside {[11:15]};
     }
 
                   } */

endclass



module tb;
  
  generator g;
  
  initial begin
    g = new();
    
    g.wr_oe_c.constraint_mode(0); // 1 -> Constraint is on
                                 // 0 -> Constraint is off

    $display ("Constraint Status oe_c: %0d", g.oe_c.constraint_mode()); // This function also returns a value

    for (int i = 0; i<20 ; i++) begin
      assert(g.randomize()) else $display("Randomization Failed");
      $display("Value of wr : %0b | Value of oe : %0b |", g.wr, g.oe);
    end
    
  end
 
  
endmodule
