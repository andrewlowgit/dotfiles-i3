function dotsync --description 'Sync dotfiles to git'
    set -l original_dir (pwd)
    cd ~/dotfiles
    
    if test (git status --porcelain | wc -l) -eq 0
        echo "✓ No changes to sync"
        cd $original_dir
        return
    end
    
    git add -A
    echo "Changes to commit:"
    git status --short
    
    read -l -P "Commit message (or press Enter for auto): " msg
    
    if test -z "$msg"
        set msg "Config update: $(date '+%Y-%m-%d %H:%M')"
    end
    
    git commit -m "$msg"
    echo "✓ Changes committed locally"
    echo "  (Run 'git push' when you have a remote set up)"
    
    cd $original_dir
end
