cd projects
project_open ssprint_pocket -revision ssprint_pocket
create_timing_netlist -model slow -temperature 0 -voltage 1100
read_sdc
update_timing_netlist
# NPATHS=n in the environment widens the report (default 12 paths, 12 per endpoint)
set n [expr {[info exists env(NPATHS)] ? $env(NPATHS) : 12}]
set paths [get_timing_paths -setup -npaths $n -nworst [expr {$n > 12 ? 3 : 12}]]
foreach_in_collection p $paths {
    puts "SLK [format %.2f [get_path_info $p -slack]]  [get_node_info [get_path_info $p -from] -name]  ->  [get_node_info [get_path_info $p -to] -name]"
}
delete_timing_netlist
project_close
