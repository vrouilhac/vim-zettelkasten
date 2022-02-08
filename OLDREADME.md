# ZettelkastenVim

ZettelkastenVim is my personal implementation of Luhmann's zettelkasten method using Vim as editor. To know more about the zettelkasten method the best way to start is to read the excellent and thorough explations on [zettelkasten.de](https://zettelkasten.de/posts/overview/). There is Sönke Ahrens' How to take smart notes which is a great book about Luhmann and his method. Finally there is the original post wrote from Luhmann himself called [Communicating with Slip Boxes](https://luhmann.surge.sh/communicating-with-slip-boxes).

## Zettelkasten structure

*/archive*  : holds your zettels, the permanent notes
*/inbox*    : holds your drafts (optional as you can take draft on paper, i usually do 50/50 for draft paper/digital)
*/reference*: holds your references, book references, website links, etc...

## Zettelkasten tags

In order to generate tags you need to install [ctags](https://github.com/universal-ctags/ctags) first.
The command to generate the tags is 
```bash
ctags -R .
```
But you can simplify this process by binding a key. I usually use 't' in normal mode but feel free to make this personal, here's the line to add to your ~/.vimrc for a binding of 't' key.
```
nnoremap t ctags -R .<CR><CR>
```

To jump back and forth between tags use ctrl-] and ctrl-o when your cursor is on a tag.

## Zettelkasten syntax color

In order to add colors i created a syntax for .ztl files (all files used inside the zettelkasten folder should end with .ztl).

First if you don't have a folders named "syntax" and "ftdetect" inside your ~/.vim folder, create those folders.
```bash
mkdir ~/.vim/syntax ~/.vim/ftdetect
```
Create a file named `zettelkasten.vim` inside of those two folders.

Copy the content of `/syntax/zettelkasten.vim` inside your ~/.vim/syntax/zettelkasten.vim and the content of `/ftdetect/zettelkasten.vim` inside your ~/.vim/ftdetect.vim.

## Colors

I use xterm with 256 colors enabled, if you don't see colors search for a way to enable 256 colors on your terminal. Here is a way for debian machine.
Paste those line inside your `~/.profile`
```
# set Xterm 256 colors
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
  export TERM='xterm-256color'
else
  export TERM='xterm-color'
fi
```
You can reload your terminal and check the content of TERM `echo $TERM`. If it shows you `xterm-256color` you've enabled it !
