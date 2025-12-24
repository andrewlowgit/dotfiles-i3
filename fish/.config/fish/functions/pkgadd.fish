function pkgadd --description 'Install package and auto-add to dotfiles'
    if test (count $argv) -eq 0
        echo "Usage: pkgadd <package-name>"
        return 1
    end
    
    set pkg $argv[1]
    set install_script ~/dotfiles/packages/install-packages.sh
    
    # Install the package
    echo "Installing $pkg..."
    sudo pacman -S $pkg
    
    if test $status -eq 0
        # Update the explicit package list
        echo "Updating package list..."
        pacman -Qe | awk '{print $1}' > ~/dotfiles/packages/pacman-explicit.txt
        
        # Check if package already in install-packages.sh
        if grep -q "$pkg" $install_script
            echo "✓ Package installed (already in install-packages.sh)"
        else
            # Add to ADDITIONAL_PACKAGES array
            echo "Adding $pkg to ADDITIONAL_PACKAGES..."
            sed -i "/^ADDITIONAL_PACKAGES=(/a\    $pkg" $install_script
            echo "✓ Package installed and added to ADDITIONAL_PACKAGES"
            echo "💡 Tip: Periodically sort ADDITIONAL_PACKAGES into proper categories"
        end
        
        echo ""
        echo "Run: dotsync && git push"
    else
        echo "✗ Installation failed"
    end
end
