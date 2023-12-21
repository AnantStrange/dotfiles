<p align="center" size="30px">
    <h1 align="center" size="80px">✨ Strange's Dotfiles ✨</h1>
</p>

### How to install

##### Install [gnu-stow](https://www.gnu.org/software/stow/manual/stow.html)
```bash
# For arch based distros:  
sudo pacman -S stow

# For debian based distros:  
sudo apt install stow
```
### Clone the repo 
```bash
git clone https://github.com/AnantStrange/dotfiles.git --recurse
cd dotfiles
git stow *
```

`stow *` will symlink all the config files present int dotfiles directory.

To only symlink specific config files use `stow packagae_name` where package_name 
are te directory names inside dotfiles.

>Note : nvim/.config/nvim is a [submodule](https://github.com/AnantStrange/nvim)


