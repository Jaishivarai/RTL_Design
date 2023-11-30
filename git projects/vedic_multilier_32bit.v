// 2 bit vedic multiplier
/*module ha(a,b,s,c);
input a,b;
output s,c;
assign s=a^b;
assign c=a&b;
endmodule */


module vedic_2(a,b,y);
input[1:0]a,b;
output[3:0]y;
wire[3:0]x;
///wire z;
//reg p;

assign x[1:0]=a[0]?b:0;
assign x[3:2]=(a[1]?b<<1:0)+x[1:0];
assign y=x[3:2];
/*assign y[0]=x[0];
ha a1(x[1],x[2],y[1],z);
ha a2(x[3],z,y[2],y[3]);
*/
endmodule

module tb;
reg[1:0]a,b;
wire[3:0]y;

vedic_2 s1(a,b,y);
initial begin
$monitor("a=%d  b=%d  y=%d",a,b,y);
a=2'd1;b=2'd1;#5;
a=2'd0;b=2'd1;#5;
a=2'd3;b=2'd3;#5;
a=2'd2;b=2'd3;#5;
end 
endmodule
