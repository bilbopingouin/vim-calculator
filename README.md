# vim-calculator

Start a simple application to run basic operations using the expression register

## Usage

It provides two sets of commands: calculation (simple operations) and conversions.

### Calulations

There are two ways: the calculator environment and the inline calculator.

#### Inline Calculator

Simply calls the operation like

``` vim
:Calc 1+1
```

#### Calculator environment

The environment is started using `:CalcStart` and stopped using `:CalcStop`.

In the newly created buffer, it is possible to enter an operation within one line. At the end, one of the following command can be used:
- `<C-g>` in insert mode
- `:Calculate` in normal/command mode

This will run the whole line through the expression register and print the result on the next line.

### Conversions

The plugin provides a simple conversion command:

``` vim
:Conv [FN] NN [OPT]
``` 

Where `FN` is the function, `NN` a value to be converted and `OPT` an option. The following functions are implemented:
- `uDH` unsigned decimal to hexadecimal conversion (`OPT`: number of bits of the hexadecimal),
- `sDH` signed decimal to hexadecimal conversion (`OPT`: number of bits of the hexadecimal),
- `uHD` unsigned hexadecimal to decimal conversion (no `OPT` available),
- `sHD` signed hexadecimal to decimal conversions (`OPT`: number of bits of the hexadecimal)
