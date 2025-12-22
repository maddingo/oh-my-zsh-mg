export SDKMAN_DIR=~/.sdkman

install_local_sdk() {
	if [[ ! -d $SDKMAN_DIR/candidates/java/$1-local ]]; then
		[[ -d /usr/lib/jvm/java-$1-openjdk-amd64 ]] && sdk install java $1-local /usr/lib/jvm/java-$1-openjdk-amd64
	fi
}

if [[ -f "$SDKMAN_DIR/bin/sdkman-init.sh" ]]; then
	source "$SDKMAN_DIR/bin/sdkman-init.sh"
	# local aliases do not work without a java version installed through sdkman :-(
	if [[ -d "$SDKMAN_DIR/candidates/java" ]]; then
		install_local_sdk 8
		install_local_sdk 11
		install_local_sdk 17
		install_local_sdk 21
		install_local_sdk 25
	else
	 	echo "Set up any java version with sdkman to make local aliases work, e.g. sdk install java"
	fi
fi
