## What is this?

A place where I store and sync-up environment configuration files (aka: `dotfiles` - think `~/.bashrc`, etc.)

## How to use?

Run `install.sh` to create symlinks to the configuration files here into a given directory (like `$HOME`)

```sh
./install.sh $HOME
```

You can also install just a specific profile or configuration by passing it in as an additional parameter:

```sh
# Installs zsh configuration into $HOME
./install.sh $HOME zsh
```

### Rebuilding node-scripts

The contents of `./node-scripts/` needs to be rebuilt if they're ever changed. By default, running the install script will _not_ run the build scripts for this, but by passing `RUN_BUILD=true` as an environment variable, you can force this to happen.

```sh
RUN_BUILD=true ./install.sh $HOME
```

Alternatively, just `cd` into `node-scripts` and run `npm install && npm run build`.

### Updating

```
./update.sh
```

---

## TODO?

- [ ] Support multiple, specific profile installations
	- eg: `install.sh $HOME zsh git bash`
- [ ] Create `uninstall` script
	- In case we want to remove extraneous symlinks from a previous installation or content from a separate dotfiles branch.
- [ ] Handle pre-existing configs
	- Offer a solution to (dangerously) remove existing configs with `$HOME`
		- Needed in case the paths go stale (ie: moving the `my-dotfiles` repo elsewhere, breaking the already existing symlinks)
		- `rm $OUT/$config` possibly?
- [ ] Fresh/first install script
	- This would actually install the needed programs/executables
	- Installs git, zsh, node, pyenv, etc.
	- git plugins
		 - git difftools (delta)
- [ ] Better way to determine what system is being set up
	- What is the OS? Is it a work machine? Is it a personal machine? etc.
		- OS is handled in `first-install.sh` - could be leveraged elsewhere
	- Windows installations? (?!)
- [ ] Rename `**/install.sh` -> `**/link.sh` and `<root>/first-install.sh` -> `**/install.sh` (per-profile installation; might be more manageable or make more sense?)
