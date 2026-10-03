/*
 * Copyright (c) 2024 Muhammad Saad
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module spi_peripheral (
    input  wire       clk,      // system clock (10 MHz)
    input  wire       rst_n,    // reset_n - low to reset
    input  wire       sclk,     // SPI clock (async to clk)
    input  wire       copi,     // SPI data in (async to clk)
    input  wire       ncs,      // SPI chip select, active low (async to clk)
    output reg  [7:0] en_reg_out_7_0,
    output reg  [7:0] en_reg_out_15_8,
    output reg  [7:0] en_reg_pwm_7_0,
    output reg  [7:0] en_reg_pwm_15_8,
    output reg  [7:0] pwm_duty_cycle
);

    // TODO: implement the SPI peripheral (see onboarding step 6)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            en_reg_out_7_0  <= 8'h00;
            en_reg_out_15_8 <= 8'h00;
            en_reg_pwm_7_0  <= 8'h00;
            en_reg_pwm_15_8 <= 8'h00;
            pwm_duty_cycle  <= 8'h00;
        end
    end

    wire _unused = &{sclk, copi, ncs, 1'b0};

endmodule
