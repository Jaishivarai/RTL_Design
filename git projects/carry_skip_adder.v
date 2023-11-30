module CSA(a,b,cin,sum,cout);
input[31:0]a,b;
input cin;
output[31:0]sum;
output cout;
wire sel;
wire[31:0]p;
wire[8:1]c;

//ripple carry adder

rca m1(sum[3:0],c[1],a[3:0],b[3:0],cin);
rca m2(sum[7:4],c[2],a[7:4],b[7:4],c[1]);
rca m3(sum[11:8],c[3],a[11:8],b[11:8],c[2]);
rca m4(sum[15:12],c[4],a[15:12],b[15:12],c[3]);
rca m5(sum[19:16],c[5],a[19:16],b[19:16],c[4]);
rca m6(sum[23:20],c[6],a[23:20],b[23:20],c[5]);
rca m7(sum[27:24],c[7],a[27:24],b[27:24],c[6]);
rca m8(sum[31:28],c[8],a[31:28],b[31:28],c[7]);

//propogation
propogate p1(p,sel,a,b);

//2*1 mux

assign cout=sel?cin:c[8];

endmodule

//propogation module
module propogate(p,sel,a,b);
input[31:0]a,b;
output[31:0]p;
output sel;
assign p=a^b;
assign sel= &p;
endmodule

//Ripple carry adder
module rca(s,c,a,b,cin);
input[3:0]a,b;
input cin;
output[3:0]s;
output c;
wire [2:0]x;
FA a1(s[0],x[0],a[0],b[0],cin);
FA a2(s[1],x[1],a[1],b[1],x[0]);
FA a3(s[2],x[2],a[2],b[2],x[1]);
FA a4(s[3],c,a[3],b[3],x[2]);
endmodule

//full adder
module FA(s,co,a,b,cin);
input a,b,cin;
output s,co;
assign s=a^b^cin;
assign co=a&b|b&cin|cin&a;
endmodule

//test bench 
module tb;
reg [31:0] a,b;
reg cin;
wire[31:0]sum;
wire cout;

CSA m1(a,b,cin,sum,cout);
initial begin
$monitor($time  , "a=%d  b=%d cin=%d sum=%d  carry=%d ",a,b,cin,sum,cout);
a=32'b11101;b=32'b01010;cin=1;
#50;
a=32'b11111;b=32'b00000;cin=0;
#50;
a=32'd2147483647;b=32'd2147483647;cin=0;
#50;
a=32'd2147483647;b=32'd2147483647;cin=1;
#50;
a=32'd21;b=32'd7;cin=1;
#50;
a=32'd39;b=32'd29;cin=0;
#50;
a=32'd20;b=32'd11;cin=1;
#50;
a=32'd28;b=32'd12;cin=0;
#50;
a=32'd9;b=32'd11;cin=0;
#50;
end
endmodule





















