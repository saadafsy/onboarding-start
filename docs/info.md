<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

SPI controlled PWM peripheral. The SPI peripheral is write only (mode 0) and sets 5 registers that control 16 outputs.
Each SPI transaction is 16 bits: 1 R/W bit, 7 bit address, 8 bit data. Reads and invalid addresses are ignored.

| Address | Register        | Description                    |
|---------|-----------------|--------------------------------|
| 0x00    | en_reg_out_7_0  | enable outputs on uo_out[7:0]  |
| 0x01    | en_reg_out_15_8 | enable outputs on uio_out[7:0] |
| 0x02    | en_reg_pwm_7_0  | enable PWM on uo_out[7:0]      |
| 0x03    | en_reg_pwm_15_8 | enable PWM on uio_out[7:0]     |
| 0x04    | pwm_duty_cycle  | duty cycle (0x00 = 0%, 0xFF = 100%) |

PWM frequency is ~3 kHz (10 MHz clock).

## How to test

Send SPI writes on ui_in[0] (SCLK), ui_in[1] (COPI), ui_in[2] (nCS) and check uo_out / uio_out.

## External hardware

A microcontroller or anything that can act as an SPI controller.
