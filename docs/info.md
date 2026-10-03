<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

An SPI peripheral (mode 0, write-only) configures a set of registers that drive a 16-channel PWM peripheral.
The design runs on a 10 MHz system clock; SPI runs at ~100 kHz. Each SPI transaction is 16 bits:
1 R/W bit (1 = write), 7 address bits, and 8 data bits. Reads and invalid addresses are ignored.

| Addr | Register          | Description                              | Reset |
|------|-------------------|------------------------------------------|-------|
| 0x00 | `en_reg_out_7_0`  | Enable outputs on `uo_out[7:0]`          | 0x00  |
| 0x01 | `en_reg_out_15_8` | Enable outputs on `uio_out[7:0]`         | 0x00  |
| 0x02 | `en_reg_pwm_7_0`  | Enable PWM for `uo_out[7:0]`             | 0x00  |
| 0x03 | `en_reg_pwm_15_8` | Enable PWM for `uio_out[7:0]`            | 0x00  |
| 0x04 | `pwm_duty_cycle`  | PWM duty cycle (0x00 = 0%, 0xFF = 100%)  | 0x00  |

The PWM frequency is ~3 kHz. An output is 0 when its enable bit is 0, 1 when enabled with PWM off,
and follows the PWM signal when both enable and PWM bits are set.

## How to test

Send SPI write transactions on `ui_in[0]` (SCLK), `ui_in[1]` (COPI) and `ui_in[2]` (nCS), then observe
`uo_out` and `uio_out`.

## External hardware

An SPI controller (e.g. a microcontroller) to configure the registers.
