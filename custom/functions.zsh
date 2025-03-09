function mcd() {
	mkdir -p $1;
	cd $1
}

function snap-clean() {
	snap list --all | awk '$6 ~ /.*disabled.*/ {print "sudo snap remove " $1 " --revision=" $3 }' | bash

}
