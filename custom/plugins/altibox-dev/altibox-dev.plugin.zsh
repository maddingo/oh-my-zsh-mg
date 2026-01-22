export VAULT_ADDR=${VAULT_ADDR:-"https://vault.pc.lysetele.dev"}
export OCP_SERVER=${OCP_SERVER:-"https://api.svgocplab2.lysetele.net:6443"}

function has_vpn() {
	nmcli -t -c no c | awk -F: '$3 == "vpn" && $4 == "" {exit 1}'; return $?
}

function set_vault_token() {
	export VAULT_TOKEN="$(vault token lookup -format=json | jq -r .data.id)"
}

function oc_login() {
	local IPA_PASSWORD=$(cat $HOME/.ipa-password)

	~/bin/oc login --server=${OCP_SERVER} --username=$USER --password="${IPA_PASSWORD}" >/dev/null 2>&1
}

function docker_login() {
	local IPA_PASSWORD=$(cat $HOME/.ipa-password)
	docker login -u $USER -p "${IPA_PASSWORD}" nexus.altibox.net:8086 >/dev/null 2>&1
	docker login -u $USER -p "${IPA_PASSWORD}" nexus.altibox.net:8085 >/dev/null 2>&1
}

function reload_altibox_dev_plugin() {
	if [[ -r .altiboxrc ]]; then
		source .altiboxrc
		load_env

	fi
}

function load_env() {
	# check if VPN connection is up
	if has_vpn; then
		set_vault_token
		oc_login
		docker_login
	else
		echo "VPN is down"
	fi
}

function vpn_up() {
	nmcli connection up Altibox\ VPN
}

function vpn_down() {
	nmcli connection down Altibox\ VPN
}

load_env

add-zsh-hook chpwd reload_altibox_dev_plugin
