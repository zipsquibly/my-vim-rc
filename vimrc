set number
set ts=4
set shiftwidth=4
set expandtab
set path=/home/opus/trunk/src/**
so $HOME/.vim/myfiletypes.vim
set ch=2		" Make command line two lines high
set mousehide		" Hide the mouse when typing text
set number

set noswapfile

syntax on
filetype plugin on

colorscheme desert


 set nocompatible               " be iMproved
 filetype off                   " required!

 set rtp+=~/.vim/bundle/vundle/
 call vundle#rc()

 " let Vundle manage Vundle
 " required! 
 Bundle 'gmarik/vundle'
 Bundle 'scrooloose/nerdtree'
 Bundle 'jistr/vim-nerdtree-tabs'

 " My Bundles here:
 Bundle 'taglist-plus'
 "
 " original repos on github
 Bundle 'tpope/vim-fugitive'
 Bundle 'Lokaltog/vim-easymotion'
 Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
 " vim-scripts repos
 Bundle 'L9'
 Bundle 'FuzzyFinder'
 " non github repos
 Bundle 'git://git.wincent.com/command-t.git'
 " ...
 Bundle "pangloss/vim-javascript"

 filetype plugin indent on     " required!

"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed.


" This is a simple regex that can be used to search an HTML file and replace
" all unquoted attributes with their quoted version.
map <F9> :%s/\([^&^?]\)\(\<[[:alnum:]-]\{-}\)=\([[:alnum:]-#%]\+\)/\1\2="\3"/g<Return>
map <F1> :bprevious<Return>
map <F2> :bnext<Return>
map <F11> :cn<Return>
map <F12> :cp<Return>

function! InsertTabWrapper(direction)
    let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
		return "\<tab>"
	elseif "backward" == a:direction
		return "\<c-p>"
	else
		return "\<c-n>"
	endif
	endfunction

inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>
nmap <silent> <C-N> :silent noh<CR>

au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
au FileType xsd exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
au FileType wsdl exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

highlight comment ctermfg=lightblue

" Move cursor together with the screen
noremap <c-j> j<c-e>
noremap <c-k> k<c-y>

noremap p ]p

" create an easy way to insert a UUID, press F3
nnoremap <F3> :read !uuidgen<cr>

" THIS highlights the line with the cursor
"set cul                                           
"hi CursorLine term=none cterm=none ctermbg=4




" Search for selected text in visual mode with */#
" effect: overrides unnamed register
" Simplest version: vnoremap * y/<C-R>"<CR>
" Better one: vnoremap * y/\V<C-R>=escape(@@,"/\\")<CR><CR>
" This is so far the best, allowing all selected characters and multiline
" selection:
"
" Atom \V sets following pattern to "very nomagic", i.e. only the backslash
" has special meaning.
" As a search pattern we insert an expression (= register) that
" calls the 'escape()' function on the unnamed register content '@@',
" and escapes the backslash and the character that still has a special
" meaning in the search command (/|?, respectively).
" This works well even with <Tab> (no need to change ^I into \t),
" but not with a linebreak, which must be changed from ^M to \n.
" This is done with the substitute() function.
vnoremap * y/\V<C-R>=substitute(escape(@@,"/\\"),"\n","\\\\n","ge")<CR><CR>
vnoremap # y?\V<C-R>=substitute(escape(@@,"?\\"),"\n","\\\\n","ge")<CR><CR> 

set makeprg=make.sh\ %
nmap \sh                  :source ~/.vim/vimsh.vim<CR>

" Some handy abbr
iab gao getAPIObject
iab gdt getDBTable
iab gdtr getDBTransation
iab gob getObject
iab ld logdebug
iab cl console.log

command C !perl -c %
