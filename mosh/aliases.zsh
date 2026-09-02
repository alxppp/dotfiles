alias mosh='mosh --predict=always --ssh="ssh -o RemoteCommand=none" $*'
alias bk5='mosh bk5 -- tmux attach -t desktop -d'
alias teshub='mosh teshub -- tmux attach -t 0 -d'
# no mosh here: workload is a private bridge IP behind a ProxyJump — mosh's
# UDP can't traverse the jump, and the host firewall only admits SSH anyway.
# tmux still gives the survives-disconnect part; new -ADs also creates the
# session on a fresh generation instead of erroring.
# -u: force UTF-8 even if a client session arrives with a broken locale
alias workload='ssh -t workload tmux -u new -ADs desktop'
