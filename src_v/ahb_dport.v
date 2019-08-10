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
module ahb_dport
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input  [ 31:0]  outport_data_rd_i
    ,input           outport_accept_i
    ,input           outport_ack_i
    ,input           outport_error_i
    ,input  [ 10:0]  outport_resp_tag_i
    ,input  [ 31:0]  inport_haddr_i
    ,input           inport_hwrite_i
    ,input  [  2:0]  inport_hsize_i
    ,input  [  2:0]  inport_hburst_i
    ,input           inport_hmastlock_i
    ,input  [  3:0]  inport_hprot_i
    ,input  [  1:0]  inport_htrans_i
    ,input  [ 31:0]  inport_hwdata_i

    // Outputs
    ,output [ 31:0]  outport_addr_o
    ,output [ 31:0]  outport_data_wr_o
    ,output          outport_rd_o
    ,output [  3:0]  outport_wr_o
    ,output          outport_cacheable_o
    ,output [ 10:0]  outport_req_tag_o
    ,output          outport_invalidate_o
    ,output          outport_flush_o
    ,output          inport_hready_o
    ,output [ 31:0]  inport_hrdata_o
    ,output          inport_hresp_o
);




`define AHB_HTRANS_IDLE   2'd0
`define AHB_HTRANS_BUSY   2'd1
`define AHB_HTRANS_NONSEQ 2'd2
`define AHB_HTRANS_SEQ    2'd3
`define AHB_HSIZE_BYTE    3'd0
`define AHB_HSIZE_HALF    3'd1
`define AHB_HSIZE_WORD    3'd2

localparam STATE_W       = 1;
localparam STATE_ADDRESS = 1'b0;
localparam STATE_DATA    = 1'b1;
reg [STATE_W-1:0]   state_r;
reg [STATE_W-1:0]   state_q;

reg [31:0]          addr_q;
reg                 write_q;
reg [3:0]           strb_q;

always @ *
begin
    state_r = state_q;

    case (state_r)
    STATE_ADDRESS:
    begin
        if (inport_htrans_i != `AHB_HTRANS_IDLE)
            state_r = STATE_DATA;
    end
    STATE_DATA:
    begin
        if (inport_hready_o && inport_htrans_i == `AHB_HTRANS_IDLE)
            state_r = STATE_ADDRESS;
    end
    endcase
end

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    state_q <= STATE_ADDRESS;
else
    state_q <= state_r;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    addr_q <= 32'b0;
else if (inport_hready_o)
    addr_q <= inport_haddr_i;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    write_q <= 1'b0;
else if (inport_hready_o)
    write_q <= inport_hwrite_i;

assign inport_hready_o = (state_q == STATE_ADDRESS) ||
                         (state_q == STATE_DATA && 
                         (
                            (outport_ack_i)
                         )
                         );

reg [3:0] strb_r;
always @ *
begin
    strb_r = 4'b0;

    case (inport_hsize_i)
    `AHB_HSIZE_WORD: strb_r = 4'hF;
    `AHB_HSIZE_HALF: strb_r = inport_haddr_i[1] ? 4'hc : 4'h3;
    `AHB_HSIZE_BYTE:
    begin
        case (inport_haddr_i[1:0])
        2'd0: strb_r = 4'b0001;
        2'd1: strb_r = 4'b0010;
        2'd2: strb_r = 4'b0100;
        2'd3: strb_r = 4'b1000;
        endcase
    end
    default:
        ;
    endcase
end

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    strb_q <= 4'b0;
else if (inport_hready_o)
    strb_q <= strb_r;

//-------------------------------------------------------------
// Write Request
//-------------------------------------------------------------
reg wr_inhibit_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    wr_inhibit_q <= 1'b0;
else if ((|outport_wr_o) && outport_accept_i)
    wr_inhibit_q <= 1'b1;
else if (outport_ack_i)
    wr_inhibit_q <= 1'b0;

wire req_valid_w    = state_q == STATE_DATA;
wire req_is_read_w  = (req_valid_w ? !write_q : 1'b0);
wire req_is_write_w = (req_valid_w ? write_q  : 1'b0);

assign outport_addr_o       = {addr_q[31:2], 2'b0};
assign outport_data_wr_o    = inport_hwdata_i;
assign outport_wr_o         = (req_is_write_w & ~wr_inhibit_q) ? strb_q : 4'b0000;
assign outport_cacheable_o  = 1'b0;
assign outport_req_tag_o    = 11'd0;
assign outport_invalidate_o = 1'b0;
assign outport_flush_o      = 1'b0;     

//-------------------------------------------------------------
// Read Request
//-------------------------------------------------------------
reg rd_inhibit_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    rd_inhibit_q <= 1'b0;
else if (outport_rd_o && outport_accept_i)
    rd_inhibit_q <= 1'b1;
else if (outport_ack_i)
    rd_inhibit_q <= 1'b0;

assign outport_rd_o    = req_is_read_w & ~rd_inhibit_q;
assign inport_hrdata_o = outport_data_rd_i;




endmodule
