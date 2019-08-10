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
module cortex_m0_wrapper
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           rst_cpu_i
    ,input           axi_i_awready_i
    ,input           axi_i_wready_i
    ,input           axi_i_bvalid_i
    ,input  [  1:0]  axi_i_bresp_i
    ,input  [  3:0]  axi_i_bid_i
    ,input           axi_i_arready_i
    ,input           axi_i_rvalid_i
    ,input  [ 31:0]  axi_i_rdata_i
    ,input  [  1:0]  axi_i_rresp_i
    ,input  [  3:0]  axi_i_rid_i
    ,input           axi_i_rlast_i
    ,input           axi_t_awvalid_i
    ,input  [ 31:0]  axi_t_awaddr_i
    ,input  [  3:0]  axi_t_awid_i
    ,input  [  7:0]  axi_t_awlen_i
    ,input  [  1:0]  axi_t_awburst_i
    ,input           axi_t_wvalid_i
    ,input  [ 31:0]  axi_t_wdata_i
    ,input  [  3:0]  axi_t_wstrb_i
    ,input           axi_t_wlast_i
    ,input           axi_t_bready_i
    ,input           axi_t_arvalid_i
    ,input  [ 31:0]  axi_t_araddr_i
    ,input  [  3:0]  axi_t_arid_i
    ,input  [  7:0]  axi_t_arlen_i
    ,input  [  1:0]  axi_t_arburst_i
    ,input           axi_t_rready_i
    ,input  [ 31:0]  intr_i

    // Outputs
    ,output          axi_i_awvalid_o
    ,output [ 31:0]  axi_i_awaddr_o
    ,output [  3:0]  axi_i_awid_o
    ,output [  7:0]  axi_i_awlen_o
    ,output [  1:0]  axi_i_awburst_o
    ,output          axi_i_wvalid_o
    ,output [ 31:0]  axi_i_wdata_o
    ,output [  3:0]  axi_i_wstrb_o
    ,output          axi_i_wlast_o
    ,output          axi_i_bready_o
    ,output          axi_i_arvalid_o
    ,output [ 31:0]  axi_i_araddr_o
    ,output [  3:0]  axi_i_arid_o
    ,output [  7:0]  axi_i_arlen_o
    ,output [  1:0]  axi_i_arburst_o
    ,output          axi_i_rready_o
    ,output          axi_t_awready_o
    ,output          axi_t_wready_o
    ,output          axi_t_bvalid_o
    ,output [  1:0]  axi_t_bresp_o
    ,output [  3:0]  axi_t_bid_o
    ,output          axi_t_arready_o
    ,output          axi_t_rvalid_o
    ,output [ 31:0]  axi_t_rdata_o
    ,output [  1:0]  axi_t_rresp_o
    ,output [  3:0]  axi_t_rid_o
    ,output          axi_t_rlast_o
);

wire           dport_flush_w;
wire           dport_tcm_cacheable_w;
wire  [ 31:0]  dport_tcm_data_rd_w;
wire  [  3:0]  ahb_hprot_w;
wire  [ 31:0]  ahb_hwdata_w;
wire           dport_tcm_rd_w;
wire           dport_tcm_flush_w;
wire  [ 10:0]  dport_resp_tag_w;
wire  [ 10:0]  dport_tcm_resp_tag_w;
wire  [ 10:0]  dport_axi_resp_tag_w;
wire           dport_tcm_invalidate_w;
wire           dport_ack_w;
wire  [  2:0]  ahb_hsize_w;
wire  [ 10:0]  dport_axi_req_tag_w;
wire  [ 31:0]  dport_data_wr_w;
wire           dport_invalidate_w;
wire  [ 10:0]  dport_tcm_req_tag_w;
wire           dport_axi_flush_w;
wire           ahb_hresp_w;
wire           dport_tcm_ack_w;
wire           dport_axi_accept_w;
wire           dport_cacheable_w;
wire  [ 31:0]  ahb_hrdata_w;
wire  [  3:0]  dport_tcm_wr_w;
wire           dport_rd_w;
wire           dport_axi_ack_w;
wire           ahb_hmastlock_w;
wire  [ 31:0]  dport_axi_data_rd_w;
wire           dport_axi_invalidate_w;
wire  [  2:0]  ahb_hburst_w;
wire           ahb_hready_w;
wire  [ 31:0]  dport_addr_w;
wire  [ 31:0]  dport_data_rd_w;
wire  [ 31:0]  dport_tcm_data_wr_w;
wire  [ 31:0]  dport_axi_addr_w;
wire           dport_error_w;
wire           dport_tcm_accept_w;
wire  [ 31:0]  ahb_haddr_w;
wire  [  3:0]  dport_wr_w;
wire           dport_axi_error_w;
wire  [ 31:0]  dport_axi_data_wr_w;
wire  [ 10:0]  dport_req_tag_w;
wire           ahb_hwrite_w;
wire           dport_axi_cacheable_w;
wire  [  3:0]  dport_axi_wr_w;
wire  [ 31:0]  dport_tcm_addr_w;
wire           dport_tcm_error_w;
wire           dport_axi_rd_w;
wire  [  1:0]  ahb_htrans_w;
wire           dport_accept_w;


dport_mux u_dmux
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.mem_addr_i(dport_addr_w)
    ,.mem_data_wr_i(dport_data_wr_w)
    ,.mem_rd_i(dport_rd_w)
    ,.mem_wr_i(dport_wr_w)
    ,.mem_cacheable_i(dport_cacheable_w)
    ,.mem_req_tag_i(dport_req_tag_w)
    ,.mem_invalidate_i(dport_invalidate_w)
    ,.mem_flush_i(dport_flush_w)
    ,.mem_tcm_data_rd_i(dport_tcm_data_rd_w)
    ,.mem_tcm_accept_i(dport_tcm_accept_w)
    ,.mem_tcm_ack_i(dport_tcm_ack_w)
    ,.mem_tcm_error_i(dport_tcm_error_w)
    ,.mem_tcm_resp_tag_i(dport_tcm_resp_tag_w)
    ,.mem_ext_data_rd_i(dport_axi_data_rd_w)
    ,.mem_ext_accept_i(dport_axi_accept_w)
    ,.mem_ext_ack_i(dport_axi_ack_w)
    ,.mem_ext_error_i(dport_axi_error_w)
    ,.mem_ext_resp_tag_i(dport_axi_resp_tag_w)

    // Outputs
    ,.mem_data_rd_o(dport_data_rd_w)
    ,.mem_accept_o(dport_accept_w)
    ,.mem_ack_o(dport_ack_w)
    ,.mem_error_o(dport_error_w)
    ,.mem_resp_tag_o(dport_resp_tag_w)
    ,.mem_tcm_addr_o(dport_tcm_addr_w)
    ,.mem_tcm_data_wr_o(dport_tcm_data_wr_w)
    ,.mem_tcm_rd_o(dport_tcm_rd_w)
    ,.mem_tcm_wr_o(dport_tcm_wr_w)
    ,.mem_tcm_cacheable_o(dport_tcm_cacheable_w)
    ,.mem_tcm_req_tag_o(dport_tcm_req_tag_w)
    ,.mem_tcm_invalidate_o(dport_tcm_invalidate_w)
    ,.mem_tcm_flush_o(dport_tcm_flush_w)
    ,.mem_ext_addr_o(dport_axi_addr_w)
    ,.mem_ext_data_wr_o(dport_axi_data_wr_w)
    ,.mem_ext_rd_o(dport_axi_rd_w)
    ,.mem_ext_wr_o(dport_axi_wr_w)
    ,.mem_ext_cacheable_o(dport_axi_cacheable_w)
    ,.mem_ext_req_tag_o(dport_axi_req_tag_w)
    ,.mem_ext_invalidate_o(dport_axi_invalidate_w)
    ,.mem_ext_flush_o(dport_axi_flush_w)
);


cortex_m0 u_core
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_cpu_i)
    ,.ahb_hready_i(ahb_hready_w)
    ,.ahb_hrdata_i(ahb_hrdata_w)
    ,.ahb_hresp_i(ahb_hresp_w)
    ,.intr_i(intr_i)

    // Outputs
    ,.ahb_haddr_o(ahb_haddr_w)
    ,.ahb_hwrite_o(ahb_hwrite_w)
    ,.ahb_hsize_o(ahb_hsize_w)
    ,.ahb_hburst_o(ahb_hburst_w)
    ,.ahb_hmastlock_o(ahb_hmastlock_w)
    ,.ahb_hprot_o(ahb_hprot_w)
    ,.ahb_htrans_o(ahb_htrans_w)
    ,.ahb_hwdata_o(ahb_hwdata_w)
);


ahb_dport u_conv
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_cpu_i)
    ,.outport_data_rd_i(dport_data_rd_w)
    ,.outport_accept_i(dport_accept_w)
    ,.outport_ack_i(dport_ack_w)
    ,.outport_error_i(dport_error_w)
    ,.outport_resp_tag_i(dport_resp_tag_w)
    ,.inport_haddr_i(ahb_haddr_w)
    ,.inport_hwrite_i(ahb_hwrite_w)
    ,.inport_hsize_i(ahb_hsize_w)
    ,.inport_hburst_i(ahb_hburst_w)
    ,.inport_hmastlock_i(ahb_hmastlock_w)
    ,.inport_hprot_i(ahb_hprot_w)
    ,.inport_htrans_i(ahb_htrans_w)
    ,.inport_hwdata_i(ahb_hwdata_w)

    // Outputs
    ,.outport_addr_o(dport_addr_w)
    ,.outport_data_wr_o(dport_data_wr_w)
    ,.outport_rd_o(dport_rd_w)
    ,.outport_wr_o(dport_wr_w)
    ,.outport_cacheable_o(dport_cacheable_w)
    ,.outport_req_tag_o(dport_req_tag_w)
    ,.outport_invalidate_o(dport_invalidate_w)
    ,.outport_flush_o(dport_flush_w)
    ,.inport_hready_o(ahb_hready_w)
    ,.inport_hrdata_o(ahb_hrdata_w)
    ,.inport_hresp_o(ahb_hresp_w)
);


dport_mem u_tcm
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.mem_i_rd_i(1'b0)
    ,.mem_i_flush_i(1'b0)
    ,.mem_i_invalidate_i(1'b0)
    ,.mem_i_pc_i(32'b0)
    ,.mem_d_addr_i(dport_tcm_addr_w)
    ,.mem_d_data_wr_i(dport_tcm_data_wr_w)
    ,.mem_d_rd_i(dport_tcm_rd_w)
    ,.mem_d_wr_i(dport_tcm_wr_w)
    ,.mem_d_cacheable_i(dport_tcm_cacheable_w)
    ,.mem_d_req_tag_i(dport_tcm_req_tag_w)
    ,.mem_d_invalidate_i(dport_tcm_invalidate_w)
    ,.mem_d_flush_i(dport_tcm_flush_w)
    ,.axi_awvalid_i(axi_t_awvalid_i)
    ,.axi_awaddr_i(axi_t_awaddr_i)
    ,.axi_awid_i(axi_t_awid_i)
    ,.axi_awlen_i(axi_t_awlen_i)
    ,.axi_awburst_i(axi_t_awburst_i)
    ,.axi_wvalid_i(axi_t_wvalid_i)
    ,.axi_wdata_i(axi_t_wdata_i)
    ,.axi_wstrb_i(axi_t_wstrb_i)
    ,.axi_wlast_i(axi_t_wlast_i)
    ,.axi_bready_i(axi_t_bready_i)
    ,.axi_arvalid_i(axi_t_arvalid_i)
    ,.axi_araddr_i(axi_t_araddr_i)
    ,.axi_arid_i(axi_t_arid_i)
    ,.axi_arlen_i(axi_t_arlen_i)
    ,.axi_arburst_i(axi_t_arburst_i)
    ,.axi_rready_i(axi_t_rready_i)

    // Outputs
    ,.mem_i_accept_o()
    ,.mem_i_valid_o()
    ,.mem_i_error_o()
    ,.mem_i_inst_o()
    ,.mem_d_data_rd_o(dport_tcm_data_rd_w)
    ,.mem_d_accept_o(dport_tcm_accept_w)
    ,.mem_d_ack_o(dport_tcm_ack_w)
    ,.mem_d_error_o(dport_tcm_error_w)
    ,.mem_d_resp_tag_o(dport_tcm_resp_tag_w)
    ,.axi_awready_o(axi_t_awready_o)
    ,.axi_wready_o(axi_t_wready_o)
    ,.axi_bvalid_o(axi_t_bvalid_o)
    ,.axi_bresp_o(axi_t_bresp_o)
    ,.axi_bid_o(axi_t_bid_o)
    ,.axi_arready_o(axi_t_arready_o)
    ,.axi_rvalid_o(axi_t_rvalid_o)
    ,.axi_rdata_o(axi_t_rdata_o)
    ,.axi_rresp_o(axi_t_rresp_o)
    ,.axi_rid_o(axi_t_rid_o)
    ,.axi_rlast_o(axi_t_rlast_o)
);


dport_axi u_axi
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.mem_addr_i(dport_axi_addr_w)
    ,.mem_data_wr_i(dport_axi_data_wr_w)
    ,.mem_rd_i(dport_axi_rd_w)
    ,.mem_wr_i(dport_axi_wr_w)
    ,.mem_cacheable_i(dport_axi_cacheable_w)
    ,.mem_req_tag_i(dport_axi_req_tag_w)
    ,.mem_invalidate_i(dport_axi_invalidate_w)
    ,.mem_flush_i(dport_axi_flush_w)
    ,.axi_awready_i(axi_i_awready_i)
    ,.axi_wready_i(axi_i_wready_i)
    ,.axi_bvalid_i(axi_i_bvalid_i)
    ,.axi_bresp_i(axi_i_bresp_i)
    ,.axi_bid_i(axi_i_bid_i)
    ,.axi_arready_i(axi_i_arready_i)
    ,.axi_rvalid_i(axi_i_rvalid_i)
    ,.axi_rdata_i(axi_i_rdata_i)
    ,.axi_rresp_i(axi_i_rresp_i)
    ,.axi_rid_i(axi_i_rid_i)
    ,.axi_rlast_i(axi_i_rlast_i)

    // Outputs
    ,.mem_data_rd_o(dport_axi_data_rd_w)
    ,.mem_accept_o(dport_axi_accept_w)
    ,.mem_ack_o(dport_axi_ack_w)
    ,.mem_error_o(dport_axi_error_w)
    ,.mem_resp_tag_o(dport_axi_resp_tag_w)
    ,.axi_awvalid_o(axi_i_awvalid_o)
    ,.axi_awaddr_o(axi_i_awaddr_o)
    ,.axi_awid_o(axi_i_awid_o)
    ,.axi_awlen_o(axi_i_awlen_o)
    ,.axi_awburst_o(axi_i_awburst_o)
    ,.axi_wvalid_o(axi_i_wvalid_o)
    ,.axi_wdata_o(axi_i_wdata_o)
    ,.axi_wstrb_o(axi_i_wstrb_o)
    ,.axi_wlast_o(axi_i_wlast_o)
    ,.axi_bready_o(axi_i_bready_o)
    ,.axi_arvalid_o(axi_i_arvalid_o)
    ,.axi_araddr_o(axi_i_araddr_o)
    ,.axi_arid_o(axi_i_arid_o)
    ,.axi_arlen_o(axi_i_arlen_o)
    ,.axi_arburst_o(axi_i_arburst_o)
    ,.axi_rready_o(axi_i_rready_o)
);



endmodule
