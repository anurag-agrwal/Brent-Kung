`timescale 1ns/1ps
module testbench();

parameter N = 16;

reg [N-1:0] A, B;
reg Cin;

wire [N:0] Sum;
//wire Cout;
//reg [4:0] expected;
// wire [8:0] y_tb;

Brent dut_instance (.A(A), .B(B), .Cin(Cin), .Sum(Sum));

integer i,j,k;

initial begin

	for (i=0; i<100001; i=i+1)
		begin
		A <= $random;
		B <= $random;
		if (i<50) Cin <= 1'b0;
		else Cin <= 1'b1;
				
		//			{Cin, B, A} = i;
					#10;
					if (Sum !== A + B + Cin)
						begin
							$display("Error: Sum is wrong");
							$stop;
							
						end
		end
end

endmodule
