# vim-calculator

Start a simple application to run basic operations using the expression regiter

## Usage

Call the command `:CalcStart`. This will create a scratch buffer. Enter some operation (e.g. 1+1) and then either in insert mode call `<C-g>` or in normal mode, `:Calculate`. In both cases, it will run the content of the line to the expression register of vim. And print it to the next line.

`:CalcStop` ends the application.
