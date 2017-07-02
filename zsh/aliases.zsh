alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

alias webserver="python -m SimpleHTTPServer 8000"
