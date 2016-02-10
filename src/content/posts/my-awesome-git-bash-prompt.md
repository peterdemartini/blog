---
title: My Awesome Git Bash Prompt
date: 2014-11-22
template: post.hbt
---
Ever wanted a readable, git ready bash prompt? Well here ya go :)

Add this to your ~/.bash_profile

	prompt_command () {
      if [ $? -eq 0 ]; then # set an error string for the prompt, if applicable
          ERRPROMPT=" "
      else
          ERRPROMPT='->($?) '
      fi
      if [ "\$(type -t __git_ps1)" ]; then # if we're in a Git repo, show current branch
          BRANCH="\$(__git_ps1 '[ %s ] ')"
      fi

      local git_status="$(git status 2> /dev/null)"

      local TIME=`fmt_time` # format time for prompt string
      local LOAD=`uptime|awk '{min=NF-2;print $min}'`
      local GREEN="\[\033[0;32m\]"
      local CYAN="\[\033[0;36m\]"
      local BCYAN="\[\033[1;36m\]"
      local BLUE="\[\033[0;34m\]"
      local GRAY="\[\033[0;37m\]"
      local DKGRAY="\[\033[1;30m\]"
      local LIGHT_GRAY="\[\033[0;37m\]"
      local WHITE="\[\033[1;37m\]"
      local RED="\[\033[0;31m\]"
      local YELLOW="\[\033[0;33m\]"
      local MAGENTA="\[\033[0;35m\]"
      local OCHRE="\033[38;5;95m"
      # return color to Terminal setting for text color
      local DEFAULT="\[\033[0;39m\]"
      # set the titlebar to the last 2 fields of pwd
      local TITLEBAR='\[\e]2;`pwdtail`\a'

      if [[ ! $git_status =~ "working directory clean" ]]; then
        local BRANCHCOLOR="${RED}"
      elif [[ $git_status =~ "Your branch is ahead of" ]]; then
        local BRANCHCOLOR="${YELLOW}"
      elif [[ $git_status =~ "nothing to commit" ]]; then
        local BRANCHCOLOR="${GREEN}"
      else
        local BRANCHCOLOR="${OCHRE}"
      fi

      export PS1="\[${TITLEBAR}\]${CYAN}[${BCYAN}\u${GREEN}${WHITE}@${BCYAN}\h\${LIGHT_GRAY}(${LOAD})${WHITE}${TIME}${CYAN}]${RED}$ERRPROMPT${GRAY}\\w\n${BRANCHCOLOR}${BRANCH}${BCYAN}${DEFAULT}$ "
      # Tab Names for iTerm
      echo -ne "\033]0;${PWD##*/}$(__git_ps1 :%s)\007"
	}
	PROMPT_COMMAND=prompt_command
