function _rider_theme_git_branch_name
	echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function fish_prompt
	# this must be the first line
	set -l last_status $status

	set -l yellow (set_color yellow)
	set -l green (set_color green)
	set -l normal (set_color normal)
	set -l magenta (set_color magenta)
	set -l red (set_color red)
	set -l blue (set_color blue)
	set -l cyan (set_color cyan)
	set -l gray (set_color 555)
	set -l orange (set_color FF4500)

	set -l cwd (prompt_pwd)

	set -l lambda "߷"

	if test $last_status -eq 0
		set status_indicator $green$lambda
	else
		set status_indicator $red$lambda
	end

	if [ (_rider_theme_git_branch_name) ]
		set branch_name (_rider_theme_git_branch_name | tr '[:upper:]' '[:lower:]')
		switch $branch_name
			case 'master'
				set git_info "$cyan ($red$branch_name$cyan)$normal"
			case 'develop'
				set git_info "$cyan ($yellow$branch_name$cyan)$normal"
			case 'release'
				set git_info "$cyan ($orange$branch_name$cyan)$normal"
			case '*'
				set git_info "$cyan ($red$branch_name$cyan)$normal"
		end
	end

	switch $ENV_CONTEXT
		case 'VERIMI'
			echo "$status_indicator$magenta [$ENVNUM]$blue$cwd$git_info $normal"
		case 'PERSONAL'
			echo "$status_indicator$magenta $blue$cwd$git_info $normal"
		case '*'
			echo "$status_indicator$magenta $blue$cwd$git_info $normal"
	end
end
