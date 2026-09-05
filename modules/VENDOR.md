# Vendored modules

These directories are third-party HDL cores vendored into the tree (no
submodules -- the whole point is a self-contained, reproducible build). Each
was copied from its upstream repository at the commit below (by way of the
S.T.U.N. Runner core's tree); their own LICENSE files are kept alongside the
sources.

| module | upstream | commit |
|---|---|---|
| cpu-t65 | https://github.com/mist-devel/T65 (via plasticbugs/punchout, plasticbugs/stunrunner) | vendored |
| sound-jt51 | https://github.com/jotego/jt51 | 985a573dcfc1ff135553a39f7eae21d18ba57cbe |
| sound-tms5220 | https://github.com/d18c7db/TMS5220_FPGA (GPL-3; from MAME's tms5220.cpp, "Speak External" only, which is all the System 2 board uses) | 5285e1eff99859ca25e9f2d6bdab10b9830dd0ff, with one local change: the two FIFO bit-extraction slices whose width is `K_bits(m_PC-2)` are spelled out per width (5 / 4 / 3) so every slice bound is static for GHDL synth (marked `(plasticbugs)` in `TMS5220.vhd`) |

`cpu-t65/gen/t65.v` and `sound-tms5220/gen/tms5220.v` are the GHDL
conversions of the VHDL (`tools/gen_vhdl_cores.sh`); that Verilog is what
both Quartus and Verilator compile.

To update one: re-copy from upstream at the new commit (do not add it as a
submodule) and record the commit here.
