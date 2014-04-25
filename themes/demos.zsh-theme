# pretty awesome zsh theme
# author: stphndemos

DEMOS_BRACKET_COLOR="%{$fg[white]%}"
DEMOS_GIT_GOOD="%{$fg[green]%}"
DEMOS_GIT_BAD="%{$fg[red]%}"
DEMOS_CYAN=%{$'\e[0;36m'%}
DEMOS_RESET="%{$reset_color%}"
DEMOS_BOLD="%{$terminfo[bold]%}"
DEMOS_SET_SEPARATOR="$DEMOS_RESET$DEMOS_BOLD$DEMOS_BRACKET_COLOR"
DEMOS_SEPARATOR="$DEMOS_SET_SEPARATOR|$DEMOS_RESET"

ZSH_THEME_GIT_PROMPT_PREFIX="$DEMOS_SEPARATOR$DEMOS_BOLD"
ZSH_THEME_GIT_PROMPT_SUFFIX="$DEMOS_BOLD"
ZSH_THEME_GIT_PROMPT_CLEAN="$DEMOS_GIT_GOOD"
ZSH_THEME_GIT_PROMPT_DIRTY="$DEMOS_GIT_BAD"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="$DEMOS_GIT_BAD-$DEMOS_RESET"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="$DEMOS_GIT_GOOD+$DEMOS_RESET"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="$DEMOS_GIT_BAD±$DEMOS_RESET"

function demos_git_prompt() {
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    local SUBMODULE_SYNTAX=''
    local GIT_STATUS=''
    local CLEAN_MESSAGE='nothing to commit, working directory clean'
    if [[ "$(command git config --get oh-my-zsh.hide-status)" != "1" ]]; then
      if [[ $POST_1_7_2_GIT -gt 0 ]]; then
            SUBMODULE_SYNTAX="--ignore-submodules=dirty"
      fi
      if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
          GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} -uno 2> /dev/null | tail -n1)
      else
          GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} 2> /dev/null | tail -n1)
      fi
      if [[ -n $GIT_STATUS ]]; then
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_DIRTY${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
      else
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_CLEAN${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
      fi
    else
      echo "$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_CLEAN${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
  fi
}

local user_host='$DEMOS_BOLD$DEMOS_BRACKET_COLOR│%{$fg[green]%}%m'
local git_branch='$DEMOS_BOLD$(demos_git_prompt)$(git_remote_status)$DEMOS_SEPARATOR$DEMOS_RESET'
local current_dir='$DEMOS_BOLD$DEMOS_CYAN%~$DEMOS_RESET'
local return_code="%(?..$DEMOS_SEPARATOR%{$fg[red]%}%?$DEMOS_RESET)"

PROMPT="${user_host}${git_branch}${current_dir}${return_code}
%B│>%b "



