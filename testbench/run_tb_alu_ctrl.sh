#!/bin/bash
iverilog -o ./outputs/sim.vvp tb_alu_ctrl.sv
vvp ./outputs/sim.vvp