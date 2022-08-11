# vim:ft=bash

# não mudar a PS1 quando abrir um ambiente nix-shell, permite deixar o PS1 mais limpo e útil nessas horas
export NIX_SHELL_PRESERVE_PROMPT=1
# PS1, um classico do bash
export PS1='\u@\h \w $?\$ \[$(tput sgr0)\]';

# carrega o /etc/set-environment quando o shell inicia
# esse arquivo é gerado das opções environment.variable
if test -f /etc/set-environment; then
    . /etc/set-environment
fi

# PS1 mais limpo quando usar nix-shell
if test -v IN_NIX_SHELL; then
    PS1="(shell:$IN_NIX_SHELL) $PS1"
fi

