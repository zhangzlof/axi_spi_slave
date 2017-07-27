/* Copyright (C) 2017 ETH Zurich, University of Bologna
 * All rights reserved.
 *
 * This code is under development and not yet released to the public.
 * Until it is released, the code is under the copyright of ETH Zurich and
 * the University of Bologna, and may contain confidential and/or unpublished
 * work. Any reuse/redistribution is strictly forbidden without written
 * permission from ETH Zurich.
 *
 * Bug fixes and contributions will eventually be released under the
 * SolderPad open hardware license in the context of the PULP platform
 * (http://www.pulp-platform.org), under the copyright of ETH Zurich and the
 * University of Bologna.
 */

module spi_slave_syncro
    #(
    parameter AXI_ADDR_WIDTH = 32
    )
    (
    input  logic                       sys_clk,
    input  logic                       rstn,
    input  logic                       cs,
    input  logic [AXI_ADDR_WIDTH-1:0]  address,
    input  logic                       address_valid,
    input  logic                       rd_wr,
    output logic                       cs_sync,
    output logic [AXI_ADDR_WIDTH-1:0]  address_sync,
    output logic                       address_valid_sync,
    output logic                       rd_wr_sync
    );

  logic [1:0] cs_reg;
  logic [2:0] valid_reg;
  logic [1:0] rdwr_reg;

  assign cs_sync = cs_reg[1];
  assign address_valid_sync = ~valid_reg[2] & valid_reg[1]; //detect rising edge of addr valid
  assign address_sync = address;
  assign rd_wr_sync = rdwr_reg[1];

  always @(posedge sys_clk or negedge rstn)
  begin
    if(rstn == 1'b0)
    begin
      cs_reg     <=  2'b11;
      valid_reg  <=  3'b000;
      rdwr_reg   <=  2'b00;
    end
    else
    begin
      cs_reg     <= {cs_reg[0],cs};
      valid_reg  <= {valid_reg[1:0],address_valid};
      rdwr_reg   <= {rdwr_reg[0],rd_wr};
    end
  end

endmodule
