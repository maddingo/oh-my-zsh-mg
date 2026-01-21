if command -v jbang > /dev/null || test -d ~/.sdkman/candidates/jbang ; then
	alias j!=jbang
	/usr/bin/mkdir -p ~/.jbang/bin
	path+=(~/.jbang/bin)
else
	echo "JBang is not installed. Either install it or disable the JBang plugin"
fi
