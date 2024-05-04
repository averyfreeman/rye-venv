_toggleRyeShell() {
  # Determine if currently in a Rye-managed directory
  local in_rye_dir=0
  if [[ -f "$PWD/pyproject.toml" ]] && grep -q 'tool.rye' "$PWD/pyproject.toml"; then
    in_rye_dir=1
  fi

  # Deactivate the current environment if moving out of a Rye directory or into a different Rye directory
  if [[ $rye_active -eq 1 ]] && { [[ $in_rye_dir -eq 0 ]] && [[ "$PWD" != "$rye_dir"* ]]; }; then
    export rye_active=0
    unset rye_dir
    deactivate
  fi

  # Activate the environment if in a Rye directory and no environment is currently active
  if [[ $in_rye_dir -eq 1 ]] && [[ $rye_active -ne 1 ]]; then
    venv_dir=$(rye env info --path 2>/dev/null)
    if [[ -n "$venv_dir" ]]; then
      export rye_active=1
      export rye_dir="$PWD"
      source "${venv_dir}/bin/activate"
    fi
  fi
}
autoload -U add-zsh-hook
add-zsh-hook chpwd _toggleRyeShell
_toggleRyeShell # Initial call to check the current directory at shell startup
