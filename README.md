Vim plugin for sql filetypes.

Allows to go to db function source file (like go file).
Usage example:
  In a sql file place cursor on the "schema.function" and press \gf

Source files have to have names matching to functions names
and be placed in the directories matching to schemas names. 
(i.e. sql_gf_home/schema/function.sql)
 
Plugin defines three mappings:
    <leader>gf  - go to file
    <leader>wf  - split horizontally 
    <leader>vf  - split vertically 

Installation:
  Place sql_gf.vim in your ftplugin directory.
  Set the variable g:sql_gf_home in your .vimrc
  pointing to the directoty with schemas folder
  Example:
      let g:sql_gf_home = '~/mydb'
