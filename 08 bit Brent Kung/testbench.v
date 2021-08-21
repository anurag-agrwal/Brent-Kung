`timescale 1ns/1ps
module testbench();

parameter N = 8;

reg [N-1:0] A, B;
reg Cin;

wire [N:0] Sum;
//wire Cout;
//reg [4:0] expected;
// wire [8:0] y_tb;

Brent dut_instance (.A(A), .B(B), .Cin(Cin), .Sum(Sum));

integer i;

initial begin

	for (i=0; i<2**(2*N+1); i=i+1)
		begin
			{Cin, B, A} = i;
			#10;
			if (Sum !== A + B + Cin)
				begin
					$display("Error: Sum is wrong");
					$stop;
					
				end
		end
end

endmodule
