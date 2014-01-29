# pretty awesome zsh theme
# author: stphndemos

DEMOS_BRACKET_COLOR="%{$fg[white]%}"
DEMOS_GIT_BRANCH_COLOR="%{$fg[green]%}"
DEMOS_GIT_CLEAN_COLOR="%{$fg[green]%}"
DEMOS_GIT_DIRTY_COLOR="%{$fg[red]%}"
DEMOS_CYAN=%{$'\e[0;36m'%}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$terminfo[bold]%}$DEMOS_BRACKET_COLOR‹%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$terminfo[bold]%}$DEMOS_BRACKET_COLOR› %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" $DEMOS_GIT_CLEAN_COLOR✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" $DEMOS_GIT_DIRTY_COLOR✗%{$reset_color%}"

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$terminfo[bold]%}$DEMOS_BRACKET_COLOR‹%{$fg[green]%}%m$DEMOS_BRACKET_COLOR›%{$reset_color%}'
local current_dir='%{$terminfo[bold]%}$DEMOS_CYAN%~%{$reset_color%}'
local git_branch='%{$terminfo[bold]%}$(git_prompt_info)%{$reset_color%}'

PROMPT="${user_host} ${git_branch}${current_dir}
%B››%b "
RPROMPT="${return_code}"
