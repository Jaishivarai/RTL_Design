module syn_fifo1(input w_en,r_en,r_clk,w_clk,rst,input[7:0]d_in,output reg[7:0] d_out,output reg full,empty);
parameter width=8;
parameter depth=8;
parameter b_size=5;
reg[depth-1:0] w_ptr,r_ptr;
reg[width-1:0] mem[depth-1:0];

always@(posedge r_clk or posedge w_clk) begin           ////reset condition
if(rst)begin
w_ptr<=0;r_ptr<=0;full<=0;empty<=0;d_out<=0;
end
else
begin
assign full=(w_ptr==b_size);
assign empty=(w_ptr==r_ptr);
end
end

always@(posedge w_clk)
begin                            /////writing into fifo
  if(!rst & w_en & !full & (w_ptr<=b_size))
   begin
    mem[w_ptr]<=d_in;
    w_ptr <= w_ptr+1;
  end
end

always@(posedge r_clk)               /////reading into fifo
begin                 
  if(!rst & r_en & !empty & (r_ptr<=w_ptr))
  begin 
    d_out<=mem[r_ptr];
   r_ptr = r_ptr+1;
  end
end

//assign empty=(b_size==r_ptr);
//assign full=((w_ptr==b_size);




endmodule



//testbench
module tb;
reg w_en,r_en,w_clk,r_clk,rst;
reg[7:0] d_in;
wire full,empty;
wire [7:0] d_out;

always #1 w_clk=~w_clk;
always #3 r_clk=~r_clk;

syn_fifo1  a1(w_en,r_en,r_clk,w_clk,rst,d_in,d_out,full,empty);


initial begin
$monitor("rst=%b  w_en=%b  r_en=%b   full=%b  empty=%b d_in=%d  d_out=%d",rst,w_en,r_en,full,empty,d_in,d_out);
r_clk=0;w_clk=0;
rst=1;#4;
rst=0;w_en=1;r_en=0;
d_in=8'd22;#2;
d_in=8'd2;#2;
d_in=8'd32;#2;
d_in=8'd29;#2;
d_in=8'd57;#2;
d_in=8'd48;#2;
d_in=8'd120;#2;
d_in=8'd200;#2;
d_in=8'd32;#2;
d_in=8'd29;#2;
d_in=8'd57;#2;

rst=1;#4;

rst=0;w_en=1;r_en=0;
d_in=8'd232;#2;
d_in=8'd2;#2;
d_in=8'd32;#2;
d_in=8'd29;#2;
d_in=8'd57;#2;
d_in=8'd48;#2;
d_in=8'd120;#2;
d_in=8'd200;#2;
d_in=8'd57;#2;

w_en=0;r_en=1;#100;

$finish;

end
endmodule
















