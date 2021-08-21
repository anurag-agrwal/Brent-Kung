// 4-bit Brent Kung

module Bruent (A,B,Cin,Sum);

parameter N = 4;

input [N-1:0] A, B;
input Cin;

output [N:0] Sum;
//output Cout;

wire  P[3:1][N-1:0];  // [no of stages]  [no of bits]
wire	G[3:1][N-1:0];

wire	[N:0] C;
wire	[N-1:0] S;




genvar i;

generate
	for(i=0; i<N; i=i+1) begin : stage1
		PG I1 (A[i], B[i], P[1][i],G[1][i]);
	end
endgenerate


//PG I0 (A[0], B[0], P[1][0],G[1][0]);
//PG I1 (A[1], B[1], P[1][1],G[1][1]);
//PG I2 (A[2], B[2], P[1][2],G[1][2]);
//PG I3 (A[3], B[3], P[1][3],G[1][3]);



// Stage 2

genvar j;

generate
	for(j=0; j<(N/2); j=j+1) begin : stage2
		PG_Nx I2 (G[1][2*j+1], P[1][2*j+1], G[1][2*j], P[1][2*j], G[2][j], P[2][j]);
	end
endgenerate


//PG_Nx I4 (G[1][1], P[1][1], G[1][0], P[1][0], G[2][0], P[2][0]);
//PG_Nx I5 (G[1][3], P[1][3], G[1][2], P[1][2], G[2][1], P[2][1]);


// Stage 3

genvar k;

generate
	for(k=0; k<(N/4); k=k+1) begin : stage3
		PG_Nx I3 (G[2][2*k+1], P[2][2*k+1], G[2][2*k], P[2][2*k], G[3][k], P[3][k]);
	end
endgenerate


//PG_Nx I6 (G[2][1], P[2][1], G[2][0], P[2][0], G[3][0], P[3][0]);




// Carry Calculation

assign C[0] = Cin;
assign C[1] = G[1][0] | (P[1][0] & C[0]);
assign C[2] = G[2][0] | (P[2][0] & C[0]);
assign C[4] = G[3][0] | (P[3][0] & C[0]);

assign C[3] = G[1][2] | (P[1][2] & C[2]);



// Sum Calculation

//assign S[] = P[1][] ^ C[];



genvar n;

generate
	for(n=0; n<N; n=n+1) begin : sum
		assign S[n] = P[1][n] ^ C[n];
	end
endgenerate


assign Sum = {C[N],S};
//assign Cout = C[4];

endmodule




module PG_Nx (G, P, G_1, P_1, G_Nx, P_Nx);	// G_i, P_i, G_{i-1}, P_{i-1}, G_{i}{i-1}, P_{i}{i-1}
input G, P, G_1, P_1;
output reg G_Nx, P_Nx;

always @(*)
begin

	G_Nx = G | (P & G_1);
	P_Nx = P & P_1;
end

endmodule



module PG (A, B, P, G);
input A, B;
output reg P, G;

always @(*)
begin

	P = A ^ B;
	G = A & B;
end

endmodule















// Original

//
//
//
// 4-bit Brent Kung
//
//module Bruent (A,B,Cin,Sum);
//
//input [3:0] A, B;
//input Cin;
//
//output [4:0] Sum;
//output Cout;
//
//wire  P[3:1][3:0];  // [no of stages]  [no of bits]
//wire	G[3:1][3:0];
//
//wire	[4:0] C;
//wire	[3:0] S;
//
// Stage 1
//
//PG I0 (A[0], B[0], P[1][0],G[1][0]);
//PG I1 (A[1], B[1], P[1][1],G[1][1]);
//PG I2 (A[2], B[2], P[1][2],G[1][2]);
//PG I3 (A[3], B[3], P[1][3],G[1][3]);
//
//
//
// Stage 2
//
//PG_Nx I4 (G[1][1], P[1][1], G[1][0], P[1][0], G[2][0], P[2][0]);
//PG_Nx I5 (G[1][3], P[1][3], G[1][2], P[1][2], G[2][1], P[2][1]);
//
//
//
// Stage 3
//
//PG_Nx I6 (G[2][1], P[2][1], G[2][0], P[2][0], G[3][0], P[3][0]);
//
//
//
// Carry Calculation
//
//assign C[0] = Cin;
//assign C[1] = G[1][0] | (P[1][0] & C[0]);
//assign C[2] = G[2][0] | (P[2][0] & C[0]);
//assign C[4] = G[3][0] | (P[3][0] & C[0]);
//
//assign C[3] = G[1][2] | (P[1][2] & C[2]);
//
//
//
// Sum Calculation
//
//assign S[] = P[1][] ^ C[];
//
//
//
//genvar i;
//
//generate
//	for(i=0; i<4; i=i+1) begin : sum
//		assign S[i] = P[1][i] ^ C[i];
//	end
//endgenerate
//
//
//assign Sum = {C[4],S};
//assign Cout = C[4];
//
//endmodule
//
//
//
//
//module PG_Nx (G, P, G_1, P_1, G_Nx, P_Nx);	// G_i, P_i, G_{i-1}, P_{i-1}, G_{i}{i-1}, P_{i}{i-1}
//input G, P, G_1, P_1;
//output reg G_Nx, P_Nx;
//
//always @(*)
//begin
//
//	G_Nx = G | (P & G_1);
//	P_Nx = P & P_1;
//end
//
//endmodule
//
//
//
//module PG (A, B, P, G);
//input A, B;
//output reg P, G;
//
//always @(*)
//begin
//
//	P = A ^ B;
//	G = A & B;
//end
//
//endmodule
