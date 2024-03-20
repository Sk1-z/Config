# Will create all system links exept for firefox
d=$(pwd)
ln -s $d/picom.conf ~/.config/picom.conf
ln -s $d/i3 ~/.config/i3
ln -s $d/kitty ~/.config/kitty
ln -s $d/neofetch ~/.config/neofetch
ln -s $d/neovim ~/.config/nvim
ln -s $d/polybar ~/.config/polybar
ln -s $d/ranger ~/.config/ranger
ln -s $d/rofi ~/.config/rofi
ln -s $d/picom.conf ~/.config/picom.conf
ln -s $d/zshrc ~/.zshrc

rm $d/i3/i3 $d/kitty/kitty $d/neofetch/neofetch $d/neovim/neovim $d/polybar/polybar $d/ranger/ranger $d/rofi/rofi $d/wiki/wiki 
