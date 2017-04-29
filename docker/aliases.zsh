alias d='docker $*'
alias d-c='LOCALIP=$(localip) docker-compose $*'
alias dap='d-c exec app $*'
alias dps='docker ps -a'
