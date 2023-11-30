module ram(input clk,en,rw,input[7:0]data_in,input[2:0]address,output reg [7:0]data_out);
reg[7:0] mem[7:0];
always@(posedge clk)
begin
if(en) begin
if(!rw)
mem[address] <= data_in;
else 
data_out <=mem[address];
end
end
endmodule


module tb;
reg clk,en,rw;
reg[7:0] data_in;
reg[2:0] address;
wire[7:0] data_out;

ram a1( clk,en,rw,data_in,address,data_out);
initial begin
clk=0;
address=0;
data_in=0;
en=0;
# 20;
en=1;
rw=0;
@(posedge clk) data_in=20;address=01;
@(posedge clk) data_in=21;address=02;
@(posedge clk) data_in=22;address=03;
@(posedge clk) data_in=23;address=04;
@(posedge clk) data_in=24;address=05;
@(posedge clk) data_in=25;address=06;
@(posedge clk) data_in=26;address=07;


rw=1;
@(posedge clk) address=01;
@(posedge clk) address=02;
@(posedge clk) address=03;
@(posedge clk) address=04;en=0;
@(posedge clk) address=05;
@(posedge clk) address=06;
@(posedge clk) address=07;
end

always #5 clk =~clk;

endmodule
