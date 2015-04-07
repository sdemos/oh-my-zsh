# pretty awesome zsh theme
# author: stphndemos

DEMOS_BRACKET_COLOR="%{$fg[white]%}"
DEMOS_GOOD="%{$fg[green]%}"
DEMOS_BAD="%{$fg[red]%}"
DEMOS_CYAN=%{$'\e[0;36m'%}
DEMOS_RESET="%{$reset_color%}"
DEMOS_BOLD="%{$terminfo[bold]%}"
DEMOS_SET_SEPARATOR="$DEMOS_RESET$DEMOS_BOLD"
DEMOS_SEPARATOR="$DEMOS_SET_SEPARATOR|$DEMOS_RESET"

ZSH_THEME_GIT_PROMPT_PREFIX="$DEMOS_SEPARATOR$DEMOS_BOLD"
ZSH_THEME_GIT_PROMPT_SUFFIX="$DEMOS_BOLD"
ZSH_THEME_GIT_PROMPT_CLEAN="$DEMOS_GOOD"
ZSH_THEME_GIT_PROMPT_DIRTY="$DEMOS_BAD"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="$DEMOS_BAD-$DEMOS_RESET"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="$DEMOS_GOOD+$DEMOS_RESET"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="$DEMOS_BAD±$DEMOS_RESET"

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

function demos_cabal_prompt() {
  cabal_files=(*.cabal(N))
  if [ $#cabal_files -gt 0 ]; then
    # get the name of the cabal program
    [[ $cabal_files =~ '(.+)\.cabal' ]] && local cabal_name=$match[1]
    if [ -f cabal.sandbox.config ]; then
      echo "$DEMOS_BOLD$DEMOS_GOOD${cabal_name}$DEMOS_SEPARATOR$DEMOS_RESET"
    else
      echo "$DEMOS_BOLD$DEMOS_BAD${cabal_name}$DEMOS_SEPARATOR$DEMOS_RESET"
    fi
  fi
}


local user_host='$DEMOS_SET_SEPARATOR│%{$fg[green]%}%m'
local git_branch='$DEMOS_BOLD$(demos_git_prompt)$(git_remote_status)$DEMOS_SEPARATOR$DEMOS_RESET'
local cabal_info='$(demos_cabal_prompt)$DEMOS_RESET'
local current_dir='$DEMOS_BOLD$DEMOS_CYAN%~$DEMOS_RESET'
local return_code='%(?..$DEMOS_SEPARATOR%{$fg[red]%}%?$DEMOS_RESET)'
local prompt='$DEMOS_BOLD│> $DEMOS_RESET'

PROMPT="${user_host}${git_branch}${cabal_info}${current_dir}${return_code}
${prompt}"



