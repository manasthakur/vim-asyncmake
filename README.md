# Vim-AsyncMake

AsyncMake is a simple plugin to utilize the jobs facility introduced in Vim 8, and run shell commands _asynchronously_ from inside Vim.
It has been tweaked specifically to build projects and list out errors, if any.

## Features

* No intrusion to the Vim workflow; works in tandem with quickfix windows and the `errorformat` (details below).
* Falls back to synchronous builds for older Vim versions.

## Usage

AsyncMake provides a simple command (called, guess what, `AsyncMake`) to run shell commands asynchronously, which can be invoked as follows:
```vim
:AsyncMake [cmd]
```
For example, to compile the current Java file, use:
```vim
:AsyncMake javac %
```
Or to compile a certain file `Main.java` inside a directory `util`:
```vim
:AsyncMake javac util/Main.java
```

There is also a variable `b:asyncmakeprg`, which could be used to define the default command that needs to be run asynchronously for a buffer.
For example, if you wish to always compile the _current Java file_, add the following line to `~/.vim/after/ftplugin/java.vim`:
```vim
let b:asyncmakeprg = "javac %"
```
Next, from a Java file, type `:AsyncMake` and press `Enter`.

In order to be able to read the errors in the quickfix window, add the following line to `~/.vim/after/ftplugin/java.vim`:
```vim
setlocal errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
```
The above line determines the format for listing the errors in a quickfix window, for Java files. See `:help errorformats` to learn about defining the `errorformat` for other file-types.

If all the settings worked properly, you would get a `Compiling: cmd` message (it will disappear once the command finishes execution).
If the compilation was successful, you will get a message `No errors!`.
If the compilation failed with some errors, the errors are loaded into the quickfix list.
In order to open the quickfix window automatically in case of errors, add the following autocommand to your vimrc:
```vim
autocmd QuickFixCmdPost [^l]* cwindow
```

Press `Enter` over an error to jump to it; navigate to the next and previous errors using `:cnext` and `:cprevious`, respectively.
I recommend the following convenience mappings:
```vim
nnoremap ]c :cnext<CR>
nnoremap [c :cprevious<CR>
```
See `:help quickfix` to learn more about working with quickfix windows.

A mapping I use to invoke AsyncMake with `b:asyncmakeprg` defined in the proper ftplugin file is the following:
```vim
nnoremap ,, :AsyncMake<CR>
```

If your Vim version is below 8 (check using `:version`), the 'Make' part of AsyncMake still works like above; however, the builds will be _synchronous_, that is, you would see the compilation happening as you would normally do by running the command with a `bang`: `:!command`.

## Installation

Use your favorite plugin-manager, or install manually.
Refer [this article](https://gist.github.com/manasthakur/ab4cf8d32a28ea38271ac0d07373bb53)
for general help on managing plugins in Vim.

Star this repository on GitHub if you like the plugin.
Use the issue-tracker for complaints and feature-requests.

## License

[MIT](LICENSE)

