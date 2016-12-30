# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -l --color"
  alias ll="gls -lAh --color"
  alias la='gls -A --color'
fi
