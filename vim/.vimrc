" vim: set ts=4 sw=4 sts=0:
"-----------------------------------------------------------------------------
" ʸ�������ɴ�Ϣ
"
if &encoding !=# 'utf-8'
	set encoding=japan
	set fileencoding=japan
endif
if has('iconv')
	let s:enc_euc = 'euc-jp'
	let s:enc_jis = 'iso-2022-jp'
	" iconv��eucJP-ms���б����Ƥ��뤫������å�
	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'eucjp-ms'
		let s:enc_jis = 'iso-2022-jp-3'
	" iconv��JISX0213���б����Ƥ��뤫������å�
	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'euc-jisx0213'
		let s:enc_jis = 'iso-2022-jp-3'
	endif
	" fileencodings����
	if &encoding ==# 'utf-8'
		let s:fileencodings_default = &fileencodings
		let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
		let &fileencodings = &fileencodings .','. s:fileencodings_default
		unlet s:fileencodings_default
	else
		let &fileencodings = &fileencodings .','. s:enc_jis
		set fileencodings+=utf-8,ucs-2le,ucs-2
		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
			set fileencodings+=cp932
			set fileencodings-=euc-jp
			set fileencodings-=euc-jisx0213
			set fileencodings-=eucjp-ms
			let &encoding = s:enc_euc
			let &fileencoding = s:enc_euc
		else
			let &fileencodings = &fileencodings .','. s:enc_euc
		endif
	endif
	" ������ʬ
	unlet s:enc_euc
	unlet s:enc_jis
endif
" UTF-8�΢�����ǥ���������֤�����ʤ��褦�ˤ���
if exists("&ambiwidth")
    set ambiwidth=double
endif
" ���ԥ����ɤμ�ưǧ��
set fileformats=unix,dos,mac


"-----------------------------------------------------------------------------
" �Խ���Ϣ
"
"�����ȥ���ǥ�Ȥ���
set autoindent

"-----------------------------------------------------------------------------
" ������Ϣ
"
"����ʸ���󤬾�ʸ���ξ�����ʸ����ʸ������̤ʤ���������
set ignorecase
"����ʸ�������ʸ�����ޤޤ�Ƥ�����϶��̤��Ƹ�������
set smartcase
"�������˺Ǹ�ޤǹԤä���ǽ�����
set wrapscan
"����ʸ�������ϻ��˽缡�о�ʸ����˥ҥåȤ����ʤ�
set noincsearch

"-----------------------------------------------------------------------------
" ������Ϣ
"
"���󥿥å����ϥ��饤�Ȥ�ͭ���ˤ���
syntax on
"���ֹ��ɽ�����ʤ�
set nonumber
"���֤κ�¦�˥�������ɽ��
set listchars=tab:\ \ 
set list
"�����������ꤹ��
set tabstop=8
set shiftwidth=8
set expandtab
"������Υ��ޥ�ɤ򥹥ơ�������ɽ������
set showcmd
"������ϻ����б������̤�ɽ��
set showmatch
"�������ʸ����Υϥ��饤�Ȥ�ͭ���ˤ���
set hlsearch
"���ơ������饤�����ɽ��
set laststatus=2
"���ơ������饤���ʸ�������ɤȲ���ʸ����ɽ������
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
autocmd WinEnter * match WhitespaceEOL /\s\+$/

"-----------------------------------------------------------------------------
" �ޥå����
"
"�Хåե���ư�ѥ����ޥå�
" F2: ���ΥХåե�
" F3: ���ΥХåե�
" F4: �Хåե����
map <F2> <ESC>:bp<CR>
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bw<CR>
"ɽ����ñ�̤ǹ԰�ư����
nnoremap j gj
nnoremap k gk
"�ե졼�ॵ���������Ƥ��ѹ�����
map <kPlus> <C-W>+
map <kMinus> <C-W>-

"set mouse=a

"-----------------------------------------------------------------------------
" gtags
" �������Window���Ĥ���
nnoremap <C-q> <C-w><C-w><C-w>q
" Grep ����
nnoremap <C-g> :Gtags -g
" ���Υե�����δؿ�����
nnoremap <C-l> :Gtags -f %<CR>
" ��������ʲ����������õ��
nnoremap <C-j> :Gtags <C-r><C-w><CR>
" ��������ʲ��λ��Ѳս��õ��
nnoremap <C-k> :Gtags -r <C-r><C-w><CR>
" ���θ������
nnoremap <C-n> :cn<CR>
" ���θ������
nnoremap <C-p> :cp<CR>

"-----------------------------------------------------------------------------
set nowrap
