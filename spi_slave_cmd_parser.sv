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

module spi_slave_cmd_parser(
      input  logic [7:0] cmd,
      output logic       get_addr,
      output logic       get_mode,
      output logic       get_data,
      output logic       send_data,
      output logic       enable_cont,
      output logic       enable_regs,
      output logic       wait_dummy,
      output logic       error,
      output logic [1:0] reg_sel
      );


  always_comb
  begin
    get_addr       = 0;
    get_mode       = 0;
    get_data       = 0;
    send_data      = 0;
    enable_cont    = 0;
    enable_regs    = 1'b0;
    wait_dummy     = 0;
    reg_sel        = 2'b00;
    error          = 1'b1;
    case(cmd)
      8'h1: //write reg0
      begin
        get_addr       = 0;
        get_mode       = 0;
        get_data       = 1;
        send_data      = 0;
        enable_cont    = 0;
        enable_regs    = 1'b1;
        error          = 1'b0;
        wait_dummy     = 0;
        reg_sel        = 2'b00;
      end
      8'h2: //write mem
      begin
        get_addr       = 1;
        get_mode       = 0;
        get_data       = 1;
        send_data      = 0;
        enable_cont    = 1'b1;
        enable_regs    = 1'b0;
        error          = 1'b0;
        wait_dummy     = 0;
        reg_sel        = 2'b00;
      end
      8'h5: //read reg0
      begin
        get_addr       = 0;
        get_mode       = 0;
        get_data       = 0;
        send_data      = 1;
        enable_cont    = 0;
        enable_regs    = 1'b1;
        error          = 1'b0;
        wait_dummy     = 0;
        reg_sel        = 2'b00;
      end
      8'h7: //read reg1
      begin
        get_addr       = 0;
        get_mode       = 0;
        get_data       = 0;
        send_data      = 1;
        enable_cont    = 0;
        enable_regs    = 1'b1;
        error          = 1'b0;
        wait_dummy     = 0;
        reg_sel        = 2'b01;
      end
      8'hB: //read mem
      begin
        get_addr       = 1;
        get_mode       = 0;
        get_data       = 0;
        send_data      = 1;
        enable_cont    = 1'b1;
        enable_regs    = 1'b0;
        error          = 1'b0;
        wait_dummy     = 1;
        reg_sel        = 2'b00;
      end
      8'h11: //write reg1
      begin
        get_addr       = 1'b0;
        get_mode       = 1'b0;
        get_data       = 1'b1;
        send_data      = 1'b0;
        enable_cont    = 1'b0;
        enable_regs    = 1'b1;
        error          = 1'b0;
        wait_dummy     = 1'b0;
        reg_sel        = 2'b01;
      end
      8'h20: // write reg2
      begin
        get_addr       = 1'b0;
        get_mode       = 1'b0;
        get_data       = 1'b1;
        send_data      = 1'b0;
        enable_cont    = 1'b0;
        enable_regs    = 1'b1;
        error          = 1'b0;
        wait_dummy     = 1'b0;
        reg_sel        = 2'b10;
      end
      8'h21: // read reg2
      begin
        get_addr       = 1'b0;
        get_mode       = 1'b0;
        get_data       = 1'b0;
        send_data      = 1'b1;
        enable_cont    = 1'b0;
        enable_regs    = 1'b1;
        error          = 1'b0;
        wait_dummy     = 1'b0;
        reg_sel        = 2'b10;
      end
      8'h30: // write reg3
      begin
        get_addr       = 1'b0;
        get_mode       = 1'b0;
        get_data       = 1'b1;
        send_data      = 1'b0;
        enable_cont    = 1'b0;
        enable_regs    = 1'b1;
        error          = 1'b0;
        wait_dummy     = 1'b0;
        reg_sel        = 2'b11;
      end
      8'h31: // read reg3
      begin
        get_addr       = 1'b0;
        get_mode       = 1'b0;
        get_data       = 1'b0;
        send_data      = 1'b1;
        enable_cont    = 1'b0;
        enable_regs    = 1'b1;
        error          = 1'b0;
        wait_dummy     = 1'b0;
        reg_sel        = 2'b11;
      end
    endcase
  end

endmodule
