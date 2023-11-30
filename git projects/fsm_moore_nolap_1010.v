module seq_detector_11011(input clk, rst, x, output reg z);
  parameter S0 = 0;
  parameter S1 = 1;
  parameter S2 = 2;
  parameter S3 = 3;
  parameter S4 = 4;
  
  reg[2:0] ps,ns;
  always @(posedge clk )
 begin
    if(rst) begin 
      ps<= 0;
    end
    else ps<=ns;
  end
  
  always @(ps,x) begin
    case(ps)
      S0: begin
        ns=x?S1:S0;
        z=x?0:0;
      end
       
       S1: begin
        ns=x?S2:S0;
        z=x?0:0;
      end
       S2: begin
        ns=x?S2:S3;
        z=x?0:0;
      end
       S3: begin
        ns=x?S4:S0;
        z=x?0:0;
      end
       S4: begin
        ns=x?S2:S0;
        z=x?1:0;
      end
      
      default: begin ns <= S0;
        z=1'b0;
      end
    endcase
  end
endmodule


// Code your testbench here
// or browse Examples
module TB;
  reg clk, rst_n, x;
  wire z;
  
  seq_detector_11011 d(clk, rst_n, x, z);
  initial clk = 0;   
  always #2 clk = ~clk;
    
  initial begin
    $monitor("%0t: x = %0b, z = %0b", $time, x, z);
    x = 0;
    #1 rst_n = 1;
    #2 rst_n = 0;
    
    #3 x = 1;
    #4 x = 1;
    #4 x = 0;
    #4 x = 1;
    #4 x = 1;
    #4 x = 0;
    #4 x = 1;
    #4 x = 1;
    #4 x = 0;
    #4 x = 1;
    #4 x = 1;
    #4 x = 0;
    #4 x = 1;
    #4 x = 1;
    #4 x = 0;
    #4 x = 1;
    #4 x = 1;
    #4 x = 0;
    #4 x = 1;
    #4 x = 1;
    #10;
    $finish;
  end
  
  /*initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end*/
 
endmodule
