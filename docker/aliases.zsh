alias d='docker $*'
alias d-c='docker-compose $*'
alias dps='docker ps -a --format="table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'
alias ddown='f() { docker ps -aq --filter="name=$1" | xargs docker stop | xargs docker rm };f'
