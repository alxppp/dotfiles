# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.

echo "› sudo softwareupdate -i -a"
sudo softwareupdate -i -a

computer_name="BK6"
sudo scutil --set ComputerName "$computer_name"
sudo scutil --set LocalHostName "$computer_name"
sudo scutil --set HostName "$computer_name"
