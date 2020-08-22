#!/usr/bin/env fish
# Shrink the largest videos in the current directory.
# ASSUMPTION: the directory contains videos only.

set items (count (ls))
set subset (math "round($items/4)")
set to_shrink (du -h * | sort -h | tail -$subset | cut -f 2)

# Note: ffmpeg will fail for files with odd widths, not divisible by 2.
# Todo: if the first try errors, retry using ih instead of iw.
for x in $to_shrink
	set newname (string replace -r "^" "new-" $x)
	ffmpeg -y -i $x -vf "scale=iw*.5:-2" $newname 
	trash $x
end


