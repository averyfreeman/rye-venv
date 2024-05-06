# zsh plugin: rye-env
location-aware environment activation
---

[What is Rye?](https://rye-up.com/)

[Register article from 2023](https://www.theregister.com/2023/05/04/a_python_tool_called_rye/)

[Recent discussion on Hacker News](https://news.ycombinator.com/item?id=39249005)

Adaptation of `poetry-env`, a plugin included in default `oh-my-zsh` installations
---

#### Why use this?
 - Configures your python development environment automatically when you enter a folder bootstrapped with `rye`
 - Plays nice with `virtualenv` and `pyenv` (`poetry` _untested_) 

Here's the original `poetry-env`[source](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/poetry-env)
---
```json
[{ "paraphrase": ["poetry-env", "README.md"] }]
```
This plugin automatically changes `rye` environment when you enter a `rye` project directory.
Script looks for `pyproject.toml` file to determine if its a `rye` environment.
---

### Please note:
all configuration scenarios assume you already have `rye` installed.  
---
[Official rye installation instructions](https://rye-up.com/guide/installation/)

[Rye releases on github](https://github.com/astral-sh/rye/releases)

[Arch Linux official](https://archlinux.org/packages/extra/x86_64/rye/)

[Homebrew](https://formulae.brew.sh/formula/rye) (Mac _and_ linux)

[Mac Ports](https://ports.macports.org/port/rye/) (MacOS)

[Scoop](https://scoop.sh/#/apps?q=rye) (Windows)

[Winget](https://winstall.app/apps/Rye.Rye) (Windows)


### Requirements:
---
`zsh` shell capable of:
		`add-zsh-hook`
		`autoload`
		`chpwd`

### Optional (but _preferred_):
---
		`oh my zsh`

# Usage:
_without_ [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh): 
>_this method is untested_
>_if someone wants to try it, please send me issue w/ results_
---
 1. clone repo somewhere
 2. source plugin file 
 3. reload `.zshrc` 
```zsh
╰─❯ cd /your/parent/folder
	clone https://github.com/averyfreeman/rye-env.git
	echo 'source /path/to/rye-env/rye-env.plugin.zsh' >> $HOME/.zshrc
	zsh
```

**With** [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh): 
>tested w/ Arch linux official rye package, _global config not sourced_
---
 1. clone this repo to `$ZSH/custom/plugins/rye-env`
 2. add `rye-env` to the plugins array in `$HOME/.zshrc`.  
 3. reload `.zshrc`


### Example:
---
```zsh
╰─❯ cd $ZSH/custom/plugins
	clone https://github.com/averyfreeman/rye-env.git
	vim $HOME/.zshrc
	/plugins
```

find uncommented line:
```zsh
plugins=(asdf ... python virtualenv)
```

add `rye-env` _here_:
```zsh
# note: other plugins shown not necessary
# 	included to demonstrate order
plugins=(asdf ... python rye-env virtualenv)
```

save file, exit, and reload `.zshrc` - one method: 
```zsh
╰─❯ zsh
	echo $plugins
```

should show: 
```zsh
	... rye-env ...
```

Also, _don't forget_:

`$RYE_HOME`:
```zsh
╰─❯ env | grep RYE
	RYE_HOME=/home/$USER/.rye
```

--- 
20240506 
Feel free to contact me if you have any questions