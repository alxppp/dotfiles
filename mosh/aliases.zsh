alias mosh='mosh --predict=always --ssh="ssh -o RemoteCommand=none" $*'
alias bk5='mosh bk5 -- tmux attach -t desktop -d'
alias teshub='mosh teshub -- tmux attach -t 0 -d'
# plain-ssh fallback: tmux gives the survives-disconnect part; new -ADs also
# creates the session on a fresh generation instead of erroring.
# -u: force UTF-8 even if a client session arrives with a broken locale
alias workload-ssh='ssh -t workload tmux -u new -ADs desktop'

# mosh into the workload generation. Plain `mosh workload` can't work: the
# alias is a private bridge IP behind a ProxyJump, and mosh's UDP can't
# traverse the jump. Instead, bootstrap mosh-server over the jump by hand and
# point the UDP leg at the HOST's public IP, where a nat=true Incus proxy
# device (managed by server repo scripts/promote-generation, range pinned
# there and in group_vars workload_forward_udp_ports) forwards 61000-61004 to
# whichever generation is live.
function workload() {
  local line
  # NETWORK_TMOUT: an abandoned mosh-server exits after 7 days without an
  # authenticated packet (lost-laptop hygiene); the tmux session survives.
  # TERM + -c 256: the real mosh wrapper forwards the client terminal type
  # and color depth; without them mosh-server emulates a colorless 8-color
  # terminal (no tmux status bar background, gray/italics render white).
  line=$(command ssh workload -- MOSH_SERVER_NETWORK_TMOUT=604800 TERM=${TERM:-xterm-256color} \
    mosh-server new -c 256 -p 61000:61004 -- \
    tmux -u new -ADs desktop | grep '^MOSH CONNECT') || {
    echo "mosh bootstrap failed — falling back to ssh+tmux" >&2
    workload-ssh
    return
  }
  MOSH_KEY=${line##* } command mosh-client 178.105.18.11 ${${(z)line}[3]}
}
