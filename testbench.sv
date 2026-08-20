`timescale 1ns / 1ps

module vending_fsm_tb;

  // 1. Declare Testbench Signals
  reg clk;
  reg rst;
  reg [1:0] coin;
  wire pr;
  wire change;

  // 2. Instantiate the Design Under Test (DUT)
  vending_fsm uut (
    .clk(clk), 
    .rst(rst), 
    .coin(coin), 
    .pr(pr), 
    .change(change)
  );

  // 3. Generate Clock Signal (10ns period)
  always #5 clk = ~clk;

  // 4. Stimulus Generation
  initial begin
    // Initialize Inputs
    clk = 0;
    rst = 1;
    coin = 0;
    
    // Hold reset for 2 clock cycles
    #20;
    rst = 0;
    #10;
    
    // --- SCENARIO 1: Exact Amount (1 + 2 = 3) ---
    $display("[TIME %0t] Starting Scenario 1: Exact Amount", $time);
    coin = 2'b01; #10; // Insert 1 Rupee
    coin = 2'b00; #10; // Wait 1 cycle
    coin = 2'b10; #10; // Insert 2 Rupees
    coin = 2'b00; #10; // Clear coin input
    #10;               // Wait for FSM to return to ideal
    
    // --- SCENARIO 2: Extra Amount (2 + 2 = 4) ---
    $display("[TIME %0t] Starting Scenario 2: Extra Amount with Change", $time);
    coin = 2'b10; #10; // Insert 2 Rupees
    coin = 2'b00; #10; // Wait 1 cycle
    coin = 2'b10; #10; // Insert 2 Rupees
    coin = 2'b00; #10; // Clear coin input
    #10;               // Wait for FSM to return to ideal

    // --- SCENARIO 3: Timeout (Insert 1 Rupee, then do nothing) ---
    $display("[TIME %0t] Starting Scenario 3: Timeout Test", $time);
    coin = 2'b01; #10; // Insert 1 Rupee (goes to rs1)
    coin = 2'b00;      // No more coins inserted
    #60;               // Wait 6 clock cycles (greater than your 4-cycle limit)
    
    // --- SCENARIO 4: Asynchronous Reset Mid-way ---
    $display("[TIME %0t] Starting Scenario 4: Reset Test", $time);
    coin = 2'b10; #10; // Insert 2 Rupees (goes to rs2)
    rst = 1;      #10; // Trigger reset
    rst = 0;      #10;
    
    // End Simulation
    $display("[TIME %0t] Simulation Finished.", $time);
    $finish;
  end
  
  // 5. Monitor Outputs in Console
  initial begin
    $monitor("Time=%0t | rst=%b | coin=%b | State=%b | Count=%d | Product=%b | Change=%b", 
             $time, rst, coin, uut.pr_state, uut.count, pr, change);
  end

  // 6. Waveform Generation Block
  initial begin
    $dumpfile("vending_fsm_waves.vcd"); // Names the output waveform file
    $dumpvars(0, vending_fsm_tb);       // Dumps all variables in this testbench and deeper layers
  end

endmodule
