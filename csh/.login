keychain id_rsa
set host = `uname -n`
if (-f $HOME/.keychain/$host-csh) then
  source $HOME/.keychain/$host-csh
endif
