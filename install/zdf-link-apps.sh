# Copy .desktop declarations
mkdir -p ~/.local/share/applications
cp ~/dotfiles/applications/*.desktop ~/.local/share/applications/
cp ~/dotfiles/applications/hidden/*.desktop ~/.local/share/applications/

update-desktop-database ~/.local/share/applications
