# Authors:
# https://github.com/maddingo
#
# Docker-compose related zsh aliases further shortcuts

# Aliases ###################################################################

# Function to show the IP address of a docker-compose service
dcip() {
    local dc_images=$(docker-compose ps -q $1 | xargs)
    for dc_image in $( echo "$dc_images" ) ; do
        docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${dc_image}
    done
}
