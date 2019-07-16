module Traffic (input logic clk,rst);

logic[3:0]count;
typedef enum logic[2:0]{R,Y,G}ROAD;
ROAD NS,EW; 

typedef enum logic[2:0]{S0,S1,S2,S3,S4,S5}statetype;
statetype state;

always_ff@(posedge clk, posedge rst)
if(rst)
	begin
	state<=S0;
	count<=0;end	
else
begin
case(state)
		S0:if(count<4'd5) begin
				state<=S0;
					NS<=G;	
					EW<=R;
				count<=count+1; end
			else begin
				state<=S1;		
				count<=0; end
		
		S1:if(count<4'd1) begin
				state<=S1;
				NS<=Y;
	       	EW<=R;
			   count<=count+1; end
			else begin
				state<=S2;
				count<=0;end
		
		S2:if(count<4'd1) begin
				state<=S2;
				NS<=R;
				EW<=R;
				count<=count+1;end
			else begin
				state<=S3;
				count<=0;end
				
		S3:if(count<4'd5) begin
				state<=S3;
				NS<=R;
				EW<=G;				
				count<=count+1;end
			else begin
				state<=S4;
				count<=0;end
		
		S4:if(count<4'd1) begin
				state<=S4;
				 NS<=R;
		       EW<=Y;
				count<=count+1;end
			else begin
				state<=S5;
				count<=0; end
		
		S5:if(count<4'd1) begin
				state<=S5;
				NS<=R;
	      	EW<=R;
				count<=count+1;end
			else begin
				state<=S0;
				count<=0;end
    default:state<=S0;	
	
	endcase
end
endmodule
	
module testbench();
logic clk,rst;


Traffic dut(clk,rst);

always
begin
	clk=1; #5 clk=0; #5;
	end

initial
begin
		rst=1; #10;
		rst=0;
	end
endmodule
