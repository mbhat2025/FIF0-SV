module fifo_tb;
  parameter DEPTH = 16;
  parameter WIDTH = 8;
  
  logic clk, rst, wr_en, rd_en;
  logic [WIDTH - 1:0] din, dout;
  
  logic full, empty;
  
  fifo #(DEPTH, WIDTH) dut(
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .din(din),
    .dout(dout),
    .full(full),
    .empty(empty));
  
  always #5 clk = ~clk;
  
  initial begin
    $dumpfile("fifo_tb.vcd");
    $dumpvars(0, fifo_tb);
    clk = 0; rst = 1; wr_en = 0; rd_en = 0; din = 0;
    #10 rst = 0;
    
    //Write data into FIFO
    
    for(int i =0; i < DEPTH; i++) begin
      #10 wr_en = 1; din = i;
    end
    
    #10 wr_en = 0;
    
    //Read data into FIFO
    
    for(int i = 0; i < DEPTH; i++) begin
      #10 rd_en = 1;
    end
    #10 rd_en = 0;
    
    #20 $finish;
  end
endmodule
  
  
