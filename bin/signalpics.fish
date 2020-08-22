#!/usr/bin/env fish
# Self-explanatory (recurse into subdirs and rename pics)
# For use in ~/.config/Signal/attachments.noindex/

for dir in *
    cd $dir
    for f in *                                                                          
        mv "$f" (date -r "$f" "+%Y-%m-%d--%H%M%S-$f")
    end                                                                                 
    cd ..                                                                               
end      
