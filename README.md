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

Alternatively, just `cd` into `node-scripts` and run `yarn install && yarn build`.

---

## TODO?

- [ ] Support multiple, specific profile installations
  - eg: `install.sh $HOME zsh git bash`
