vim-redub
=========

Vim plugin for moving and renaming files.

Adds a single command, that can be used in two ways:

Use `:Redub <path>` to move the file in the current buffer to the given path.
The buffer is correctly updated to reflect the change.

Use `:Redub <source-path> <destination-path>` to move an arbitrary file to a
new path. If the file is open in a buffer, the buffer will be correctly updated
to reflect the change.

