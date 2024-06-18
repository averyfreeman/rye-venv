_toggleRyeShell() {
  # set -x
  local rye_detected=0
  local venv_detected=0

  # Determine if in a dir with a rye project
  if test -f "$PWD/pyproject.toml" && grep -q 'tool.rye' "$PWD/pyproject.toml"
    then
      local rye_detected=1
      export rye_dir="$PWD"
      venv_dir=$(rye show | grep venv: | cut -d ' ' -f2 2>/dev/null)
      if [[ "$rye_detected" -eq 1 && -n $venv_dir && -f "$venv_dir/bin/activate" ]]
        then
          local venv_detected=1
          export venv_dir
          source "$venv_dir/bin/activate"
        else
          echo "rye virtual project not detected"
      fi
    else
      local rye_detected=0
      unset rye_dir
      if [[ "$rye_detected" -eq 0 && -n $venv_dir ]]
        then
          local venv_detected=0
          deactivate
          unset venv_dir
      fi
  fi
  # uncomment these to test:
  # echo "variables:"
  # echo "rye detected: $rye_detected"
  # echo "venv detected: $venv_detected"
  # echo "rye_dir: $rye_dir"
  # echo "venv_dir: $venv_dir"
  # python -V
  # which python
}
autoload -U add-zsh-hook
add-zsh-hook chpwd _toggleRyeShell
_toggleRyeShell # Initial call to check the current directory at shell startup
