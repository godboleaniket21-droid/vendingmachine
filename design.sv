
module vending_fsm(input clk,rst ,input [1:0]coin, output reg pr,change);
  
  parameter ideal=3'b000 , rs1=3'b001 , rs2=3'b010, rs3=3'b011, rs4=3'b100 ; // bcoz we are checking upto only 4 states .(waiting time for any next inserting coin is 4 cycles thats why)
  
  reg[2:0]pr_state;
  reg[2:0]nxt_state;
  reg[2:0]count; // cycle 
  
  always@ (posedge clk) 
    begin 
      if(rst)
        begin
          count=0;
          pr_state=ideal;
        end
      else
        begin
        count = count+ 1;
      pr_state= nxt_state;
         end
  end
      
  
      always @(pr_state, coin, count) //always at a change occur in pr state or coin or count this block works)
        begin
          
          
          case(pr_state)
            
            ideal: begin
              pr=0;
              change=0;
              
              if(coin==1)
                nxt_state=rs1;
                else if(coin==2)
                  nxt_state=rs2;
                  else 
                    nxt_state=ideal;
            end
              
              rs1: begin 
                pr=0;
                change=0;
                
                if(coin==1)
                  nxt_state =rs2;
                else if (coin==2)
                  nxt_state=rs3;
                else 
                  
                    begin 
                      if(count==4) //4cycle tak ka wait karega
                        nxt_state=ideal;
                      else
                        nxt_state=rs1;
                    end
              end
            
                
              rs2 : begin
                 pr=0;
                change=0;
                
                if (coin==1)
                  nxt_state=rs3;
                else if(coin ==2)
                  nxt_state=rs4;
                else 
                  
                  begin
                    if(count==4)
                      nxt_state=ideal;
                    else
                      nxt_state=rs2;
                  end
              end
            
            rs3: begin
              pr=1;
              change=0;
              
              nxt_state=ideal;
            end
            rs4 : begin pr=1;
              change=1;
              
              nxt_state=ideal;
            end
                    
          endcase
        end
      
              
              
endmodule
              
              
              
              
