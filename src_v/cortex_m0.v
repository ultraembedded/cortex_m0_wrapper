//-----------------------------------------------------------------
//                		Cortex M0 Wrapper
//                           V0.1
//                     Ultra-Embedded.com
//                     	 Copyright 2019
//
//                 Email: admin@ultra-embedded.com
//
//                       License: LGPL
//-----------------------------------------------------------------
//
// This source file may be used and distributed without         
// restriction provided that this copyright statement is not    
// removed from the file and that any derivative work contains  
// the original copyright notice and the associated disclaimer. 
//
// This source file is free software; you can redistribute it   
// and/or modify it under the terms of the GNU Lesser General   
// Public License as published by the Free Software Foundation; 
// either version 2.1 of the License, or (at your option) any   
// later version.
//
// This source is distributed in the hope that it will be       
// useful, but WITHOUT ANY WARRANTY; without even the implied   
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      
// PURPOSE.  See the GNU Lesser General Public License for more 
// details.
//
// You should have received a copy of the GNU Lesser General    
// Public License along with this source; if not, write to the 
// Free Software Foundation, Inc., 59 Temple Place, Suite 330, 
// Boston, MA  02111-1307  USA
//-----------------------------------------------------------------

//-----------------------------------------------------------------
//                          Generated File
//-----------------------------------------------------------------
module cortex_m0
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           ahb_hready_i
    ,input  [ 31:0]  ahb_hrdata_i
    ,input           ahb_hresp_i
    ,input  [ 31:0]  intr_i

    // Outputs
    ,output [ 31:0]  ahb_haddr_o
    ,output          ahb_hwrite_o
    ,output [  2:0]  ahb_hsize_o
    ,output [  2:0]  ahb_hburst_o
    ,output          ahb_hmastlock_o
    ,output [  3:0]  ahb_hprot_o
    ,output [  1:0]  ahb_htrans_o
    ,output [ 31:0]  ahb_hwdata_o
);




`ifdef CORTEX_M0_DS_OLDER
    CORTEXM0DS
    u_core
    (
        // CLOCK AND RESETS ------------------
        .HCLK(clk_i),                   // Clock
        .HRESETn(~rst_i),               // Asynchronous reset
        // AHB-LITE MASTER PORT --------------
        .HADDR(ahb_haddr_o),            // AHB transaction address
        .HBURST(ahb_hburst_o),          // AHB burst: tied to single
        .HMASTLOCK(ahb_hmastlock_o),    // AHB locked transfer (always zero)
        .HPROT(ahb_hprot_o),            // AHB protection: priv; data or inst
        .HSIZE(ahb_hsize_o),            // AHB size: byte, half-word or word
        .HTRANS(ahb_htrans_o),          // AHB transfer: non-sequential only
        .HWDATA(ahb_hwdata_o),          // AHB write-data
        .HWRITE(ahb_hwrite_o),          // AHB write control
        .HRDATA(ahb_hrdata_i),          // AHB read-data
        .HREADY(ahb_hready_i),          // AHB stall signal
        .HRESP(ahb_hresp_i),            // AHB error response
        // MISCELLANEOUS ---------------------
        .NMI(1'b0),                     // Non-maskable interrupt input
        .IRQ(intr_i),                   // Interrupt request inputs
        .TXEV(),                        // Event output (SEV executed)
        .RXEV(1'b0),                    // Event input
        .LOCKUP(),                      // Core is locked-up
        .SYSRESETREQ(),                 // System reset request
        .STCLKEN(1'b1),                 // SysTick SCLK clock enable
        .STCALIB(26'd0),                // SysTick calibration register value

        // POWER MANAGEMENT ------------------
        .SLEEPING()                     // Core and NVIC sleeping
    );
`else
    wire CDBGPWRUPREQ;
    wire CDBGPWRUPACK;
    reg  cdbgpwrup_q;

    always @(posedge clk_i or posedge rst_i)
    if (rst_i)
        cdbgpwrup_q <= 1'b0;
    else
        cdbgpwrup_q <= CDBGPWRUPREQ;

    assign CDBGPWRUPACK   = cdbgpwrup_q;

    CORTEXM0INTEGRATION
    u_core
    (
        // System inputs
        .FCLK           (clk_i),
        .SCLK           (clk_i),
        .HCLK           (clk_i),
        .DCLK           (clk_i),
        .PORESETn       (~rst_i),
        .HRESETn        (~rst_i),
        .DBGRESETn      (~rst_i),
        .RSTBYPASS      (1'b0),
        .SE             (1'b0),

        // Power management inputs
        .SLEEPHOLDREQn  (1'b1),
        .WICENREQ       (1'b0),
        .CDBGPWRUPACK   (CDBGPWRUPACK),

        // Power management outputs
        .SLEEPHOLDACKn  (),
        .WICENACK       (),
        .CDBGPWRUPREQ   (CDBGPWRUPREQ),

        .WAKEUP         (),
        .WICSENSE       (),
        .GATEHCLK       (),
        .SYSRESETREQ    (),

        // System bus
        .HADDR          (ahb_haddr_o),
        .HTRANS         (ahb_htrans_o),
        .HSIZE          (ahb_hsize_o),
        .HBURST         (ahb_hburst_o),
        .HPROT          (ahb_hprot_o),
        .HMASTER        (),
        .HMASTLOCK      (ahb_hmastlock_o),
        .HWRITE         (ahb_hwrite_o),
        .HWDATA         (ahb_hwdata_o),
        .HRDATA         (ahb_hrdata_i),
        .HREADY         (ahb_hready_i),
        .HRESP          (ahb_hresp_i),

        .CODEHINTDE     (),
        .SPECHTRANS     (),
        .CODENSEQ       (),

        // Interrupts
        .IRQ            (intr_i),
        .NMI            (1'b0),
        .IRQLATENCY     (8'h00),
        .ECOREVNUM      (28'h0),

        // Systick
        .STCLKEN        (1'b1),
        .STCALIB        (26'd0),

        // Debug - JTAG or Serial wire
        // Inputs
        .nTRST          (1'b0),
        .SWDITMS        (1'b0),
        .SWCLKTCK       (1'b0),
        .TDI            (1'b0),
        // Outputs
        .TDO            (),
        .nTDOEN         (),
        .SWDO           (),
        .SWDOEN         (),

        .DBGRESTART     (1'b0),
        .DBGRESTARTED   (),

        // Event communication
        .TXEV           (),
        .RXEV           (1'b0),
        .EDBGRQ         (1'b0),

        // Status output
        .HALTED         (),
        .LOCKUP         (),
        .SLEEPING       (),
        .SLEEPDEEP      ()
    );
`endif

//-------------------------------------------------------------
// Debug
//-------------------------------------------------------------
`ifdef verilator
//-------------------------------------------------------------
// get_pc: Get executed instruction PC
//-------------------------------------------------------------
function [31:0] get_pc; /*verilator public*/
begin
    get_pc = u_core.cm0_pc;
end
endfunction
//-------------------------------------------------------------
// get_register: Read register file
//-------------------------------------------------------------
function [31:0] get_register; /*verilator public*/
    input [4:0] r;
begin
    case (r)
    5'd0 :   get_register = u_core.cm0_r00;
    5'd1 :   get_register = u_core.cm0_r01;
    5'd2 :   get_register = u_core.cm0_r02;
    5'd3 :   get_register = u_core.cm0_r03;
    5'd4 :   get_register = u_core.cm0_r04;
    5'd5 :   get_register = u_core.cm0_r05;
    5'd6 :   get_register = u_core.cm0_r06;
    5'd7 :   get_register = u_core.cm0_r07;
    5'd8 :   get_register = u_core.cm0_r08;
    5'd9 :   get_register = u_core.cm0_r09;
    5'd10 :  get_register = u_core.cm0_r10;
    5'd11 :  get_register = u_core.cm0_r11;
    5'd12 :  get_register = u_core.cm0_r12;
    //5'd13 : get_register = u_core.cm0_msp;
    5'd13 :  get_register = u_core.cm0_psp;
    5'd14 :  get_register = u_core.cm0_r14;
    5'd15 :  get_register = u_core.cm0_pc;
    5'd16 :  get_register = u_core.cm0_xpsr;
    5'd17 :  get_register = u_core.cm0_control;
    5'd18 :  get_register = u_core.cm0_primask;
    default: get_register = 32'b0;
    endcase
end
endfunction
`endif

endmodule
