" SQL filetype plugin file
"
" Description:
"   Go to db function source file.
"   Source files have to have names matching to functions names
"   and be placed in the directories matching to schemas names. (i.e. sql_gf_home/schema/function.sql)
"
"  
"   Plugin defines three mappings:
"       <leader>gf  - go to file
"       <leader>wf  - split horizontally 
"       <leader>vf  - split vertically 
"
"   <leader> key is usually backslash
"   
"   Usage example:
"   In a sql file place cursor on the schema.function and press \gf
"
" Installation:
"   Place sql_gf.vim in your ftplugin directory.
"   Set the variable g:sql_gf_home in your .vimrc
"   ponting to the directoty with schemas folder
"   let g:sql_gf_home = '~/mydb'
"
" Creator: Sasha Aliashkevich
"
" Version: 0.1
"

if exists("b:did_sql_gf")
    finish
endif
let b:did_sql_gf = 1

if !exists("*GoFunction")
    fu! GoFunction(mode)
        let l:sourcePath = expand(g:sql_gf_home)
        let l:sourcePath = substitute(l:sourcePath, '\/$', '', 'g')
        let l:sourcePath = l:sourcePath.'/'

        let l:schema = ''
        let l:ff = ''
        let l:word = expand("<cWORD>") 
        let l:word = matchstr(l:word, '[^\(]*')
        let l:farr = split(l:word, '\.')
        :if len(l:farr) != 2
            echo 'Word "' . expand("<cWORD>") . '" is not a function'
        :else
            let l:schema = l:farr[0]
            let l:ff = l:farr[1]

            " exceptions:
            :if l:schema == 'userdb'
                let l:schema = 'user'
            :endif

            let l:fpath = l:sourcePath . l:schema .'/'. l:ff . '.sql'
            :if filereadable(l:fpath)
                :if a:mode == 0
                    execute ':edit ' l:fpath
                :elseif a:mode == 1
                    execute ':split ' l:fpath
                :elseif a:mode == 2
                    execute ':vert split ' l:fpath
                :endif
            :else
                echo 'Can not read file ' l:fpath
            :endif
        :endif

        unlet l:sourcePath l:schema l:ff l:farr l:fpath l:word

    endfu
endif

nmap <leader>gf :call GoFunction(0)<CR> " go to file
nmap <leader>wf :call GoFunction(1)<CR> " split horizontally 
nmap <leader>vf :call GoFunction(2)<CR> " split vertically 

