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

---

> TODO
>
> - [ ] Support multiple, specific profile installations
>   - eg: `install.sh $HOME zsh git bash`
