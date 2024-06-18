# zsh plugin: rye-venv
location-aware environment activation
---

### Example with oh-my-zsh using powerlevel10k prompt w/ virtualenv and pyenv right-side

### Before entering `rye` project folder:

```zsh
╭─    ~/containers ────────────────────────────────────────────────────────────╮
╰─                                                              at 12:33:24 PM  ─╯
❯ which python; python -V
	/usr/bin/python
	Python 3.12.3
``` 

### After entering `rye` project folder:

```zsh
❯ cd djtoolbar

╭─    ~/containers/djtoolbar  on   main ?13 ──────── django  ╱ 3.12.2   ─╮
╰─                                                              at 11:43:54 AM  ─╯
❯ which python; python -V
	/home/avery/containers/djtoolbar/.venv/bin/python
	Python 3.12.2
```

### Leaving the `rye` project folder again:

```zsh
❯ cd ..

╭─    ~/containers ────────────────────────────────────────────────────────────╮
╰─                                                              at 12:33:24 PM  ─╯
❯ which python; python -V
	/usr/bin/python
	Python 3.12.3
``` 


[What is Rye?](https://rye-up.com/)

[Register article from 2023](https://www.theregister.com/2023/05/04/a_python_tool_called_rye/)

[Recent discussion on Hacker News](https://news.ycombinator.com/item?id=39249005)

---
`rye` plugin, inspired by `poetry` plugin [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) has been entirely rewritten, and renamed `rye-venv`

#### Why use this plugin with rye?
 - Configures your python development environment automatically when you enter a folder bootstrapped with `rye`
 - Plays nice with `python` plugin (`poetry` _plugin has not been tested_) 
 - Minimal and effective

 Configuration: there's a `virtualenv` plugin and a `python` plugin also bundled with `omz`
 I recommend only using the `python` plugin and _not_ the `virtualenv` plugin (they are likely to conflict): [python plugin code](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/python/python.plugin.zsh) Plus, the `virtualenv` plugin is `virtuallyuseless`. see: [virtualenv plugin code](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/virtualenv/virtualenv.plugin.zsh) 

 Also, if you use `rye-venv` and `python` plugins together, it would be best to load
 `python` _after_ `rye-venv` in your array, and disable `PYTHON_AUTO_VRUN` in `.zshrc` (set to `0`).  Only one plugin should automatically enable `venv`. `rye-venv` **has no option to disable this functionality.**

The original source of inspiration `poetry-env`[source](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/poetry-env)
---
```json
[{ "paraphrase": ["poetry-env", "README.md"] }]
```
This plugin automatically changes `rye` environment when you enter a `rye` project directory. It looks for `pyproject.toml` file to determine if its a `rye` environment.  If it fings `pyproject.toml`, and a `venv` is defined by `rye`, it'll try and `source` the `activate` file, enabling the `virtualenv` automatically. When you leave the folder, it will `deactivate` it.

Note: `rye` also uses `venv` and `pyenv`-like file `.python-version`, so if you primarily use `rye`, I recommend removing those plugins from your `.zshrc` array, as they'll likely conflict.  

The `python` omz plugin could still useful, but I recommend running it _after_ `rye-venv` plugin, and disabling `PYTHON_AUTO_VRUN` (set to `0`) Oh-my-ZSH Python plugin info [https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/python](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/python)

At some point I will have to deconflict this plugin with `poetry`, but since `poetry` doesn't manage Python versions, I am not sure why someone would use it instead of `rye`.

---

Still need to install `rye`?  
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

Optional (but _recommended_): `oh my zsh`

# Usage:
**With** oh-my-zsh: 
>tested w/ Arch linux official rye package, _global config not sourced_
---
 1. clone this repo to `$ZSH/custom/plugins/rye-venv`
```zsh
 ╰─❯ cd $ZSH/custom/plugins
		clone --depth 1 https://github.com/averyfreeman/rye-venv.git
```
 2. add `rye-venv` to the plugins array in `$HOME/.zshrc`.  
```zsh
# $HOME/.zshrc
# note: other plugins included to demonstrate order, but are not necessary
	plugins=(asdf ... rye-venv python)
```
 3. reload `.zshrc`
```zsh
 ╰─❯ zsh  # or open a new shell
```

_without_ [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh): 
>_this method is untested_
>_if someone wants to try it, please send me issue w/ results_
>_in theory, it should just need the 3 requirements listed above_
---
 1. clone repo somewhere
 2. source plugin file 
 3. reload `.zshrc` 
```zsh
╰─❯ cd /your/parent/folder
		clone --depth 1 https://github.com/averyfreeman/rye-venv.git
		echo 'source /path/to/rye-venv/rye-venv.plugin.zsh' >> $HOME/.zshrc
		zsh
```



### Example:
---
```zsh
╰─❯ cd $ZSH/custom/plugins
	clone https://github.com/averyfreeman/rye-venv.git
	vim $HOME/.zshrc
	/plugins
```

find uncommented line:
```zsh
plugins=(asdf ... python)
```

add `rye-venv` _here_:
```zsh
# note: other plugins shown not necessary
# 	included to demonstrate order
	plugins=(asdf ... rye-venv python)
```

save file, exit, and reload `.zshrc` - one method: 
```zsh
╰─❯ zsh
	echo $plugins
```

should show: 
```zsh
	... rye-venv ...
```

Also, _don't forget_:

`$RYE_HOME`:
```zsh
╰─❯ env | grep RYE
	RYE_HOME=/home/$USER/.rye
```

--- 
20240618 [Feel free to contact me if you have any questions](https://unixgreybeard.org)

<!-- add this thing about the prompt eventually? 

 -->
