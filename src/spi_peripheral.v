/*
 * Copyright (c) 2024 Muhammad Saad
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module spi_peripheral (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       sclk,
    input  wire       copi,
    input  wire       ncs,
    output reg  [7:0] en_reg_out_7_0,
    output reg  [7:0] en_reg_out_15_8,
    output reg  [7:0] en_reg_pwm_7_0,
    output reg  [7:0] en_reg_pwm_15_8,
    output reg  [7:0] pwm_duty_cycle
);

    reg [2:0] sclk_sync;
    reg [2:0] ncs_sync;
    reg [1:0] copi_sync;

    wire sclk_rise  = sclk_sync[1] & ~sclk_sync[2];
    wire ncs_rise   = ncs_sync[1]  & ~ncs_sync[2];
    wire ncs_active = ~ncs_sync[1];
    wire copi_bit   = copi_sync[1];

    reg [15:0] shift_reg;
    reg [4:0]  bit_count;

    localparam [6:0] max_address = 7'h04;

    wire       rw_bit  = shift_reg[15];
    wire [6:0] address = shift_reg[14:8];
    wire [7:0] data    = shift_reg[7:0];

    wire transaction_valid = (bit_count == 5'd16) && rw_bit && (address <= max_address);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sclk_sync       <= 3'b000;
            ncs_sync        <= 3'b111;
            copi_sync       <= 2'b00;
            shift_reg       <= 16'h0000;
            bit_count       <= 5'd0;
            en_reg_out_7_0  <= 8'h00;
            en_reg_out_15_8 <= 8'h00;
            en_reg_pwm_7_0  <= 8'h00;
            en_reg_pwm_15_8 <= 8'h00;
            pwm_duty_cycle  <= 8'h00;
        end else begin
            sclk_sync <= {sclk_sync[1:0], sclk};
            ncs_sync  <= {ncs_sync[1:0], ncs};
            copi_sync <= {copi_sync[0], copi};

            if (ncs_active) begin
                if (sclk_rise && bit_count != 5'd16) begin
                    shift_reg <= {shift_reg[14:0], copi_bit};
                    bit_count <= bit_count + 5'd1;
                end
            end else begin
                bit_count <= 5'd0;
            end

            if (ncs_rise && transaction_valid) begin
                case (address)
                    7'h00: en_reg_out_7_0  <= data;
                    7'h01: en_reg_out_15_8 <= data;
                    7'h02: en_reg_pwm_7_0  <= data;
                    7'h03: en_reg_pwm_15_8 <= data;
                    7'h04: pwm_duty_cycle  <= data;
                    default: ;
                endcase
            end
        end
    end

endmodule
