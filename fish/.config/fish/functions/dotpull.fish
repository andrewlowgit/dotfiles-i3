function dotpull --description 'Pull latest dotfiles from git'
    set -l original_dir (pwd)
    cd ~/dotfiles
    git pull
    cd $original_dir
end
