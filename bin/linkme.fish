#!/usr/bin/env fish

# Goal: you should be able to specify, as comments, in any file the location(s)
# where you want symlinks to be created pointing to the file in question. For
# example, say you create a file with the not so Unixy name "My X Startup
# Settings", and inside it you put a comment saying "link to me ~/.xinitrc
# ~/.xsession". Run this tool and those symlinks will be created for you.

# Because honestly, the paths where these files must be found is a programming
# detail and has nothing to do with me as a human using my computer.

# Another perspective is that compared to Stow, this allows you to have a flat
# hierarchy. With Stow, you need a tree like:

# dotfiles/
#     bash/
#         .bashrc
#         .bash_profile
#         .bash_logout
#     uzbl/
#         .config/
#             uzbl/
#                 [...some files]
#         .local/
#             share/
#                 uzbl/
#                     [...some files]
#     vim/
#         .vim/
#             [...some files]
#         .vimrc

# With Linkme, it's possible to simplify that to this:

# dotfiles/
#     bashrc
#     bash_profile
#     bash_logout
#     uzbl_startup
#     uzbl_whatever
#     vimrc

# Or even to this (note arbitrary renamings), and put them together with
# non-dotfiles in the same folder:

# Bash Per-shell Config
# Bash Login Profile
# Bash Logout
# Uzbl Startup
# Uzbl whatever
# Vim Config

test (count $argv) = 0
and set files **
or set files $argv

for file in $files
    set head (head -5 $file)
    set spec_line (string replace -r "link to me (.*)$" "\1" $head)
    set parsed (string split " " $spec_line)
    for wanted_link in $parsed
        ln -s (realpath $file) $wanted_link
    end
end

