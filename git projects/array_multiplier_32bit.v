module array_multiplier(a,b,y);
input[31:0]a,b;
output[63:0]y;
parameter size=32;  //32-bit multiplier
wire [(size*size)-1:0] inter;


assign inter[size-1:0]=a[0]?b:0 ;
genvar i;
generate 
for(i=1;i<size;i=i+1)
//begin :gen
assign inter[size*(i+1)-1:size*i]=(a[i]?b<<i:0)+inter[(size*i)-1:size*(i-1)];
//end
endgenerate

assign y=inter[(size*size)-1:size*(size-1)];
endmodule




module tb;
reg [31:0]a,b;
wire[63:0]y;
array_multiplier a1(a,b,y);

initial begin
$monitor("a=%d  b=%d  y=%d",a,b,y);
a=32'd1232;b=32'd46647;#50;
a=32'd32;b=32'd47;#50;
a=32'd23;b=32'd46;#50;
a=32'd100;b=32'd100;#50;
a=32'd570;b=32'd540;#50;
end
endmodule

