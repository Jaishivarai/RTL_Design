module rom(input en,clk,input[2:0]address,output reg[7:0]data_out);
reg [7:0] store[6:0];
//reg [2:0] mem[7:0];
initial begin
store[0]=8'd10;
store[1]=8'd13;
store[2]=8'd40;
store[3]=8'd50;
store[4]=8'd20;
store[5]=8'd100;
store[6]=8'd130;
end
always@(posedge clk)
begin
if(en)
data_out<=store[address];
else
data_out<= 8'bx;
end
endmodule


module tb;
reg en,clk;
reg[2:0] address;
wire[7:0] data_out;

always #2 clk=~clk;
rom a1(en,clk,address,data_out);

initial begin
$monitor("adress=%b  data_out=%d",address,data_out);
clk=1;
en=0; address=3'd3; #4;
en=1; address=3'd4; #4;
en=1; address=3'd5; #4;
en=1; address=3'd6; #4;
en=1; address=3'd1; #4;
en=1; address=3'd2; #4;
en=0;#8;
en=1; address=3'd5; #4;
en=1; address=3'd6; #4;
en=1; address=3'd1; #4;
en=1; address=3'd3; #4;
#100 $finish;

end
endmodule

