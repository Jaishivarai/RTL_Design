module ha(a,b,s,c);
input a,b;
output s,c;
assign s=a^b;
assign c=a&b;
endmodule

module fa(a,b,c,s,co);
input a,b,c;
output s,co;
assign s=a^b^c;
assign co=a&b|b&c|c&a;
endmodule

module wallace(a,b,s);
input [3:0]a,b;
output [7:0]s;

wire [15:0]p;
wire [10:0]c;
wire [5:0]x;
//integer i;
//always@(*)begin
genvar i;
generate
for(i=0;i<4;i=i+1) begin
assign p[(4*(i+1))-1:4*i]=a[i]?b:0;
end
endgenerate
//end

assign s[0]=p[0];
ha a1(p[1],p[4],s[1],c[0]);
fa a2(p[2],p[5],p[8],x[0],c[1]);
fa a3(p[3],p[6],p[9],x[1],c[2]);
ha a4(p[7],p[10],x[2],c[3]);

ha a5(c[0],x[0],s[2],c[4]);
fa a6(c[1],p[12],x[1],x[3],c[5]);
fa a7(c[2],p[13],x[2],x[4],c[6]);
fa a8(c[3],p[14],p[11],x[5],c[7]);

ha a9(c[4],x[3],s[3],c[8]);
fa a10(c[5],x[4],c[8],s[4],c[9]);
fa a11(c[6],x[5],c[9],s[5],c[10]);
fa a12(c[7],p[15],c[10],s[6],s[7]);
endmodule


module tb;  // testbench
reg[3:0]a,b;
wire[7:0]s;

wallace s1(a,b,s);

initial begin
$monitor("a=%d  b=%d  product=%d ",a,b,s);
a=4'd0;b=4'd0;#5;
a=4'd15;b=4'd15;#5;
a=4'd4;b=4'd3;#5;
a=4'd3;b=4'd4;#5;
a=4'd5;b=4'd9;#5;
end
endmodule








