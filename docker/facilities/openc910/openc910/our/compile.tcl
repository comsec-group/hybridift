# Script to compile RTL sourcecode

# Set working library.
set LIB work

# If a simulation is loaded, quit it so that it compiles in a clean working library.
set STATUS [runStatus]
if {$STATUS ne "nodesign"} {
    quit -sim
}

# Start with a clean working library.
if { [file exists $LIB] == 1} {
    echo "lib exist"
    file delete -force -- $LIB
}
vlib $LIB

# # Compile DUT from file list.
# vlog -sv -pedanticerrors -work $LIB -f ../../sourcecode/gift/file.list

# Compile TB from file list.
vlog -sv -work $LIB -f file.list -suppress 7061 -suppress 2244
quit
