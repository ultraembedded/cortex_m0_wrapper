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
module dport_mux
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input  [ 31:0]  mem_addr_i
    ,input  [ 31:0]  mem_data_wr_i
    ,input           mem_rd_i
    ,input  [  3:0]  mem_wr_i
    ,input           mem_cacheable_i
    ,input  [ 10:0]  mem_req_tag_i
    ,input           mem_invalidate_i
    ,input           mem_flush_i
    ,input  [ 31:0]  mem_tcm_data_rd_i
    ,input           mem_tcm_accept_i
    ,input           mem_tcm_ack_i
    ,input           mem_tcm_error_i
    ,input  [ 10:0]  mem_tcm_resp_tag_i
    ,input  [ 31:0]  mem_ext_data_rd_i
    ,input           mem_ext_accept_i
    ,input           mem_ext_ack_i
    ,input           mem_ext_error_i
    ,input  [ 10:0]  mem_ext_resp_tag_i

    // Outputs
    ,output [ 31:0]  mem_data_rd_o
    ,output          mem_accept_o
    ,output          mem_ack_o
    ,output          mem_error_o
    ,output [ 10:0]  mem_resp_tag_o
    ,output [ 31:0]  mem_tcm_addr_o
    ,output [ 31:0]  mem_tcm_data_wr_o
    ,output          mem_tcm_rd_o
    ,output [  3:0]  mem_tcm_wr_o
    ,output          mem_tcm_cacheable_o
    ,output [ 10:0]  mem_tcm_req_tag_o
    ,output          mem_tcm_invalidate_o
    ,output          mem_tcm_flush_o
    ,output [ 31:0]  mem_ext_addr_o
    ,output [ 31:0]  mem_ext_data_wr_o
    ,output          mem_ext_rd_o
    ,output [  3:0]  mem_ext_wr_o
    ,output          mem_ext_cacheable_o
    ,output [ 10:0]  mem_ext_req_tag_o
    ,output          mem_ext_invalidate_o
    ,output          mem_ext_flush_o
);



//-----------------------------------------------------------------
// Dcache_if mux
//-----------------------------------------------------------------
wire hold_w;

/* verilator lint_off UNSIGNED */
wire tcm_access_w = (mem_addr_i >= 32'h0 && mem_addr_i < (32'h0 + 32'd1073741824));
/* verilator lint_on UNSIGNED */

reg       tcm_access_q;
reg [4:0] pending_q;

assign mem_tcm_addr_o       = mem_addr_i;
assign mem_tcm_data_wr_o    = mem_data_wr_i;
assign mem_tcm_rd_o         = (tcm_access_w & ~hold_w) ? mem_rd_i : 1'b0;
assign mem_tcm_wr_o         = (tcm_access_w & ~hold_w) ? mem_wr_i : 4'b0;
assign mem_tcm_cacheable_o  = mem_cacheable_i;
assign mem_tcm_req_tag_o    = mem_req_tag_i;
assign mem_tcm_invalidate_o = (tcm_access_w & ~hold_w) ? mem_invalidate_i : 1'b0;
assign mem_tcm_flush_o      = (tcm_access_w & ~hold_w) ? mem_flush_i : 1'b0;

assign mem_ext_addr_o       = mem_addr_i;
assign mem_ext_data_wr_o    = mem_data_wr_i;
assign mem_ext_rd_o         = (~tcm_access_w & ~hold_w) ? mem_rd_i : 1'b0;
assign mem_ext_wr_o         = (~tcm_access_w & ~hold_w) ? mem_wr_i : 4'b0;
assign mem_ext_cacheable_o  = mem_cacheable_i;
assign mem_ext_req_tag_o    = mem_req_tag_i;
assign mem_ext_invalidate_o = (~tcm_access_w & ~hold_w) ? mem_invalidate_i : 1'b0;
assign mem_ext_flush_o      = (~tcm_access_w & ~hold_w) ? mem_flush_i : 1'b0;

assign mem_accept_o         =(tcm_access_w ? mem_tcm_accept_i   : mem_ext_accept_i) & !hold_w;
assign mem_data_rd_o        = tcm_access_q ? mem_tcm_data_rd_i  : mem_ext_data_rd_i;
assign mem_ack_o            = tcm_access_q ? mem_tcm_ack_i      : mem_ext_ack_i;
assign mem_error_o          = tcm_access_q ? mem_tcm_error_i    : mem_ext_error_i;
assign mem_resp_tag_o       = tcm_access_q ? mem_tcm_resp_tag_i : mem_ext_resp_tag_i;

reg [4:0] pending_r;
always @ *
begin
    pending_r = pending_q;

    if (((mem_rd_i || mem_wr_i != 4'b0) && mem_accept_o) && !mem_ack_o)
        pending_r = pending_r + 5'd1;
    else if (!((mem_rd_i || mem_wr_i != 4'b0) && mem_accept_o) && mem_ack_o)
        pending_r = pending_r - 5'd1;
end

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    pending_q <= 5'b0;
else
    pending_q <= pending_r;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    tcm_access_q <= 1'b0;
else if ((mem_rd_i || mem_wr_i != 4'b0) && mem_accept_o)
    tcm_access_q <= tcm_access_w;

assign hold_w = (|pending_q) && (tcm_access_q != tcm_access_w);



endmodule
