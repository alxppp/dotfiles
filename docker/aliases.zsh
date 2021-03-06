alias d='docker $*'
alias d-c='LOCALIP=$(localip) docker-compose $*'
alias d-cp='LOCALIP=$(localip) docker-compose -f docker-compose.yml -f docker-compose.prod.yml $*'
alias dap='d-c exec app $*'
alias dps='docker ps -a --format="table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'
alias dclock='/usr/local/bin/docker run --rm --privileged alpine hwclock -s'
alias ddown='f() { docker ps -aq --filter="name=$1" | xargs docker stop | xargs docker rm };f'
