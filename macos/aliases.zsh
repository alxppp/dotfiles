# Changes directory to the current Finder directory.
alias cdf='cd "$(pfd)"'

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

alias pbrcopy="textutil -stdin -format html -convert rtf -stdout -encoding UTF-8 -inputencoding UTF-8 | pbcopy"
