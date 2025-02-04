module fifo # (
  parameter int DEPTH = 16,
  parameter int WIDTH = 8)
  (
    input logic clk,
    input logic rst,
    input logic wr_en,
    input logic rd_en,
    input logic [WIDTH-1:0] din,
    output logic [WIDTH-1:0] dout,
    output logic full,
    output logic empty );
  
  logic [WIDTH-1:0] mem [0:DEPTH-1];
  logic [$clog2(DEPTH):0] wr_ptr, rd_ptr;
  logic [$clog2(DEPTH):0] count;
  
  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      wr_ptr <= 0;
      rd_ptr <= 0;
      count <= 0;
    end else begin
      //write
      if (wr_en && !full) begin
        mem[wr_ptr] <= din;
        wr_ptr <= (wr_ptr + 1) % DEPTH;
        count <= count + 1;
      end
      // read
      if(rd_en && !empty) begin
        dout <= mem[rd_ptr];
        rd_ptr <= (rd_ptr + 1) % DEPTH;
        count <= count - 1;
      end
    end
  end
  
  assign full = (count == DEPTH);
  assign empty = (count == 0);
endmodule

        
  
