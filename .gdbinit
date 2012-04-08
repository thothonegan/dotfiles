#
# .gdbinit
# GDB Init file
#

# Alias for setting up guardmalloc
define guardmalloc
	set env DYLD_INSERT_LIBRARIES /usr/lib/libgmalloc.dylib
	printf ">> GuardMalloc enabled\n"
end
document guardmalloc
	Enables guardmalloc on MacOSX
end

