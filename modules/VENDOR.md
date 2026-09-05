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

`cpu-t65/gen/t65.v` is the GHDL conversion of the VHDL (`ghdl synth
--out=verilog`, see the S.T.U.N. Runner core's `tools/gen_vhdl_cores.sh`);
that Verilog is what both Quartus and Verilator compile.

To update one: re-copy from upstream at the new commit (do not add it as a
submodule) and record the commit here.
