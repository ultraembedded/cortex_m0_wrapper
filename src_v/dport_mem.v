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
module dport_mem
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           mem_i_rd_i
    ,input           mem_i_flush_i
    ,input           mem_i_invalidate_i
    ,input  [ 31:0]  mem_i_pc_i
    ,input  [ 31:0]  mem_d_addr_i
    ,input  [ 31:0]  mem_d_data_wr_i
    ,input           mem_d_rd_i
    ,input  [  3:0]  mem_d_wr_i
    ,input           mem_d_cacheable_i
    ,input  [ 10:0]  mem_d_req_tag_i
    ,input           mem_d_invalidate_i
    ,input           mem_d_flush_i
    ,input           axi_awvalid_i
    ,input  [ 31:0]  axi_awaddr_i
    ,input  [  3:0]  axi_awid_i
    ,input  [  7:0]  axi_awlen_i
    ,input  [  1:0]  axi_awburst_i
    ,input           axi_wvalid_i
    ,input  [ 31:0]  axi_wdata_i
    ,input  [  3:0]  axi_wstrb_i
    ,input           axi_wlast_i
    ,input           axi_bready_i
    ,input           axi_arvalid_i
    ,input  [ 31:0]  axi_araddr_i
    ,input  [  3:0]  axi_arid_i
    ,input  [  7:0]  axi_arlen_i
    ,input  [  1:0]  axi_arburst_i
    ,input           axi_rready_i

    // Outputs
    ,output          mem_i_accept_o
    ,output          mem_i_valid_o
    ,output          mem_i_error_o
    ,output [ 31:0]  mem_i_inst_o
    ,output [ 31:0]  mem_d_data_rd_o
    ,output          mem_d_accept_o
    ,output          mem_d_ack_o
    ,output          mem_d_error_o
    ,output [ 10:0]  mem_d_resp_tag_o
    ,output          axi_awready_o
    ,output          axi_wready_o
    ,output          axi_bvalid_o
    ,output [  1:0]  axi_bresp_o
    ,output [  3:0]  axi_bid_o
    ,output          axi_arready_o
    ,output          axi_rvalid_o
    ,output [ 31:0]  axi_rdata_o
    ,output [  1:0]  axi_rresp_o
    ,output [  3:0]  axi_rid_o
    ,output          axi_rlast_o
);



//-------------------------------------------------------------
// AXI -> PMEM Interface
//-------------------------------------------------------------
wire          ext_accept_w;
wire          ext_ack_w;
wire [ 31:0]  ext_read_data_w;
wire [  3:0]  ext_wr_w;
wire          ext_rd_w;
wire [  7:0]  ext_len_w;
wire [ 31:0]  ext_addr_w;
wire [ 31:0]  ext_write_data_w;

dport_mem_pmem
u_conv
(
    // Inputs
    .clk_i(clk_i),
    .rst_i(rst_i),
    .axi_awvalid_i(axi_awvalid_i),
    .axi_awaddr_i(axi_awaddr_i),
    .axi_awid_i(axi_awid_i),
    .axi_awlen_i(axi_awlen_i),
    .axi_awburst_i(axi_awburst_i),
    .axi_wvalid_i(axi_wvalid_i),
    .axi_wdata_i(axi_wdata_i),
    .axi_wstrb_i(axi_wstrb_i),
    .axi_wlast_i(axi_wlast_i),
    .axi_bready_i(axi_bready_i),
    .axi_arvalid_i(axi_arvalid_i),
    .axi_araddr_i(axi_araddr_i),
    .axi_arid_i(axi_arid_i),
    .axi_arlen_i(axi_arlen_i),
    .axi_arburst_i(axi_arburst_i),
    .axi_rready_i(axi_rready_i),
    .ram_accept_i(ext_accept_w),
    .ram_ack_i(ext_ack_w),
    .ram_error_i(1'b0),
    .ram_read_data_i(ext_read_data_w),

    // Outputs
    .axi_awready_o(axi_awready_o),
    .axi_wready_o(axi_wready_o),
    .axi_bvalid_o(axi_bvalid_o),
    .axi_bresp_o(axi_bresp_o),
    .axi_bid_o(axi_bid_o),
    .axi_arready_o(axi_arready_o),
    .axi_rvalid_o(axi_rvalid_o),
    .axi_rdata_o(axi_rdata_o),
    .axi_rresp_o(axi_rresp_o),
    .axi_rid_o(axi_rid_o),
    .axi_rlast_o(axi_rlast_o),
    .ram_wr_o(ext_wr_w),
    .ram_rd_o(ext_rd_w),
    .ram_len_o(ext_len_w),
    .ram_addr_o(ext_addr_w),
    .ram_write_data_o(ext_write_data_w)
);

/* verilator lint_off UNSIGNED */
wire dmem_tcm_enable_w = (mem_d_addr_i >= 32'h20000000 && mem_d_addr_i < 32'h20008000);
wire dmem_ext_enable_w = (ext_addr_w   >= 32'h20000000 && ext_addr_w   < 32'h20008000);
wire imem_tcm_enable_w = (mem_d_addr_i >= 32'h00000000 && mem_d_addr_i < 32'h00008000);
wire imem_ext_enable_w = (ext_addr_w   >= 32'h00000000 && ext_addr_w   < 32'h00008000);
/* verilator lint_on UNSIGNED */

reg dmem_tcm_enable_q;
reg dmem_ext_enable_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    dmem_tcm_enable_q <= 1'b0;
else
    dmem_tcm_enable_q <= dmem_tcm_enable_w;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    dmem_ext_enable_q <= 1'b0;
else
    dmem_ext_enable_q <= dmem_ext_enable_w;

//-------------------------------------------------------------
// Dual Port RAM (IMEM)
//-------------------------------------------------------------
wire [31:0] imem_tcm_read_w;
wire [31:0] imem_ext_read_w;

dport_mem_ram13
u_imem
(
    // Internal Port
     .clk0_i(clk_i)
    ,.rst0_i(rst_i)
    ,.addr0_i(mem_d_addr_i[14:2])
    ,.data0_i(mem_d_data_wr_i)
    ,.wr0_i(mem_d_wr_i & {4{imem_tcm_enable_w}})

    // External Port
    ,.clk1_i(clk_i)
    ,.rst1_i(rst_i)
    ,.addr1_i(ext_addr_w[14:2])
    ,.data1_i(ext_write_data_w)
    ,.wr1_i(ext_wr_w & {4{imem_ext_enable_w}})

    // Outputs
    ,.data0_o(imem_tcm_read_w)
    ,.data1_o(imem_ext_read_w)
);

//-------------------------------------------------------------
// Dual Port RAM (DMEM)
//-------------------------------------------------------------
wire [31:0] dmem_tcm_read_w;
wire [31:0] dmem_ext_read_w;

dport_mem_ram13
u_dmem
(
    // Internal Port
     .clk0_i(clk_i)
    ,.rst0_i(rst_i)
    ,.addr0_i(mem_d_addr_i[14:2])
    ,.data0_i(mem_d_data_wr_i)
    ,.wr0_i(mem_d_wr_i & {4{dmem_tcm_enable_w}})

    // External Port
    ,.clk1_i(clk_i)
    ,.rst1_i(rst_i)
    ,.addr1_i(ext_addr_w[14:2])
    ,.data1_i(ext_write_data_w)
    ,.wr1_i(ext_wr_w & {4{dmem_ext_enable_w}})

    // Outputs
    ,.data0_o(dmem_tcm_read_w)
    ,.data1_o(dmem_ext_read_w)
);

//-------------------------------------------------------------
// Data Access / Incoming external access
//-------------------------------------------------------------
reg [10:0] mem_d_tag_q;
reg        mem_d_ack_q;
reg        ext_ack_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
begin
    mem_d_ack_q    <= 1'b0;
    mem_d_tag_q    <= 11'b0;
end
else if ((mem_d_rd_i || mem_d_wr_i != 4'b0) && mem_d_accept_o)
begin
    mem_d_ack_q    <= 1'b1;
    mem_d_tag_q    <= mem_d_req_tag_i;
end
else
    mem_d_ack_q    <= 1'b0;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    ext_ack_q <= 1'b0;
// External request accepted
else if ((ext_rd_w || ext_wr_w != 4'b0) && ext_accept_w)
    ext_ack_q <= 1'b1;
else
    ext_ack_q <= 1'b0;

assign mem_d_ack_o          = mem_d_ack_q;
assign mem_d_resp_tag_o     = mem_d_tag_q;
assign mem_d_data_rd_o      = dmem_tcm_enable_q ? dmem_tcm_read_w : imem_tcm_read_w;
assign mem_d_error_o        = 1'b0;
assign mem_d_accept_o       = 1'b1;


assign ext_accept_w         = 1'b1;
assign ext_ack_w            = ext_ack_q;
assign ext_read_data_w      = dmem_ext_enable_q ? dmem_ext_read_w : imem_ext_read_w;

`ifdef verilator
//-------------------------------------------------------------
// write: Write byte into memory
//-------------------------------------------------------------
function write; /*verilator public*/
    input [31:0] addr;
    input [7:0]  data;
begin
    if (addr >= 32'h20000000)
    begin
        case (addr[1:0])
        2'd0: u_dmem.ram[addr[27:0]/4][7:0]   = data;
        2'd1: u_dmem.ram[addr[27:0]/4][15:8]  = data;
        2'd2: u_dmem.ram[addr[27:0]/4][23:16] = data;
        2'd3: u_dmem.ram[addr[27:0]/4][31:24] = data;
        endcase
    end
    else
    begin
        case (addr[1:0])
        2'd0: u_imem.ram[addr/4][7:0]   = data;
        2'd1: u_imem.ram[addr/4][15:8]  = data;
        2'd2: u_imem.ram[addr/4][23:16] = data;
        2'd3: u_imem.ram[addr/4][31:24] = data;
        endcase
    end
end
endfunction
//-------------------------------------------------------------
// read: Read byte from memory
//-------------------------------------------------------------
function [7:0] read; /*verilator public*/
    input [31:0] addr;
begin
    if (addr >= 32'h20000000)
    begin
        case (addr[1:0])
        2'd0: read = u_dmem.ram[addr[27:0]/4][7:0];
        2'd1: read = u_dmem.ram[addr[27:0]/4][15:8];
        2'd2: read = u_dmem.ram[addr[27:0]/4][23:16];
        2'd3: read = u_dmem.ram[addr[27:0]/4][31:24];
        endcase
    end
    else
    begin
        case (addr[1:0])
        2'd0: read = u_imem.ram[addr/4][7:0];
        2'd1: read = u_imem.ram[addr/4][15:8];
        2'd2: read = u_imem.ram[addr/4][23:16];
        2'd3: read = u_imem.ram[addr/4][31:24];
        endcase
    end
end
endfunction
`endif



endmodule
