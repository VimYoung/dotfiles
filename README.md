# Dotfiles

These are the dotfiles I have been using for the past few months as my daily driver, I must say it was fun
creating and using your on setup and dotfiles for the first time. It is fairly new and
immature repo. Maintained with the help of chezmoi(great project btw), you can learn more about the amazing
project [here](https://www.chezmoi.io) and can use my dotfiles from [these](https://www.chezmoi.io/user-guide/daily-operations/#install-chezmoi-and-your-dotfiles-on-a-new-machine-with-a-single-command) commands.

> Disclaimer
These dotfiles are not made to be worked for every system. It is just a showcase of my configs, in case
anyone finds something interesting, they can surely adopt it in their files. Still, any suggestions and
improvements are welcomed. Feel free to open an issue.

## Showcase

The images of my workstation can be seen at SHOWCASE.md.

## Utilities

| Description   | Tool          |
| ------------- | ------------- |
| Distro        | [Fedora](https://fedoraproject.org/)       |
| Wayland compositor  |   [Hyprland](https://hyprland.org/) |
| App Launcher | [Fuzzel](https://codeberg.org/dnkl/fuzzel) |
| Notification Daemon| [Dunst](https://dunst-project.org/) {[powernotd](https://lib.rs/crates/powernotd)}|
| Wallpaper Daemon | [hyprpaper](https://wiki.hyprland.org/Hypr-Ecosystem/hyprpaper/) with [paperizer](https://gitlab.com/imn1/paperizer) |
| Custom Widgets | [Eww](https://github.com/elkowar/eww) |
| Video Player| [VLC](https://www.videolan.org/) |
| Image Viewer | [Imv](https://sr.ht/~exec64/imv/) |
| Screenshot and Sharing | [Hyprshot](https://github.com/Gustash/Hyprshot) and [OBS Studio](https://obsproject.com/)|
| Logout menu | [wlogout](https://github.com/ArtsyMacaw/wlogout) |
| Topbar | [waybar](https://github.com/Alexays/Waybar/) |
|Browser | [Zen](https://zen-browser.app/) with [nightTab](https://addons.mozilla.org/en-US/firefox/addon/nighttab/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=collection)|
|Terminal | [Kitty](https://sw.kovidgoyal.net/kitty/)|
| Shell | [zsh](https://zsh.sourceforge.io/) {[oh-my-posh](https://ohmyposh.dev/)/ [Antigen](https://github.com/zsh-users/antigen)}|
| Resource Monitor| Btop|
| Screen Locker | Hyprlock |
|Text Editor | Vim |
|IDE| Neovim |
|MPD client| rmpc |
| Filemanager | <ul><li><b>primary:</b> ranger </li><li><b>gui/secondary</b> nautilus </li></ul> |
|Email Client | <ul><li><b>primary:</b> Neomutt with notmuch and leer </li><li><b>gui/secondary</b> Thunderbird with html wraping disabled </li></ul> |
| Fonts | todo list of all fonts |

## Utilities archive

This list contains the utilities I like in general and consider them worth
mentioning along with my current in use utilities. These contains utilities
I have used in the past(marked with **P**), utilities I
have in my whishlist which I want to transition to slowly (marked with **W**) and 
utilities I like in General (marked with **G**).

| Description | Tool |
| ------------- | ------------- |
| Distro        | Arch |
| App Launcher | Rofi[^1]|
| Filemanager | <ul><li><b>Primary:</b> Superfile </li><li><b>GUI/Secondary</b> Thunar </li></ul>
| Video Player| mpv player |
|Terminal | Alacritty|
| Custom Widgets | Chunks-rs |
|Browser | qutebrowser|
| Video Player| MPV |
| Image Viewer | Feh |
|MPD client| kew |
|Email Client | <ul><li><b>primary:</b> Aerc</li><li><b>gui/secondary</b> ProtonMail with html wraping disabled </li></ul> |
| IRC client | Irssi |
|PDF Viewer | Zathura |


Few of "design decisions" which might seem different to others is due to following reasons.
1. This config is used by me on my laptop, hence a concurrent absence of spacing and floating
topbar is eminent for saving space.
2. The config doesn't do anything more than making hyprland look descent and workable.
3. I still don't use half of the utilities I will mention at their full keyboard configs, hence these
are underutilised, as they will fit more in my muscle memory, I shall add more keybinds for them.
4. The config doesn't try to rice apps, at least for now. I will eventually add them but after all the
above checkboxes are met, I might add app rices too, and 2-3 more themes with pywal just so that my eyes
don't get tired of seeing Rose Piné.

## Future work

Okay, so this section maintains as a todo list for the annoying things I want to stop and new tools/features
I want to add in the workflow, it serves as a reference to what changes can come next.

- [x] todo 1
- [ ] todo 2

---
## References

[^1]: Reference to rofi.
