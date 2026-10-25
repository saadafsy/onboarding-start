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

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sclk_sync       <= 3'b000;
            ncs_sync        <= 3'b111;
            copi_sync       <= 2'b00;
            en_reg_out_7_0  <= 8'h00;
            en_reg_out_15_8 <= 8'h00;
            en_reg_pwm_7_0  <= 8'h00;
            en_reg_pwm_15_8 <= 8'h00;
            pwm_duty_cycle  <= 8'h00;
        end else begin
            sclk_sync <= {sclk_sync[1:0], sclk};
            ncs_sync  <= {ncs_sync[1:0], ncs};
            copi_sync <= {copi_sync[0], copi};
        end
    end

endmodule
