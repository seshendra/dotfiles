" Configure vim-rooter to work with Java files
autocmd rooter BufEnter *.java :Rooter

let g:rooter_patterns = ['build.gradle', '.svn', '.git/']
