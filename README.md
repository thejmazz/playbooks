# Some Plays

My playbooks for, given a blank install of

- Ubuntu 16.04 (currently supported)
- Arch Linux (todo)
- MacOS (todo)

get up to speed with my preferred configurations and programs, and in the case
of an external server, be prepared to serve https requests via [Let's
Encrypt][letsencrpypt]. These playbooks make use of, or are used from, my
[dotfiles][dottos] managed by [yadm][yadm].

Eventually it should support root and non-root access. For example, install
programs to `~/bin` if root access is not available.

I have purposefully left out configuration such as

```yaml
become: yes
remote_user: root
become_method: sudo
```

since it makes more sense to set these as applicable from the CLI, imho.  The
above equivalent in CLI arguments is `-b -u root -K` or `--become --user root
--ask-become-pass`. (Note the default for `--user` is root).

If you do not have an ssh key for root, use `-k` or `--ask-pass`. If you do
have an ssh key for root, ensure it is added to your ssh-agent, or use
`--private-key=PRIVATE_KEY_FILE`.

For choosing hosts, you can make your own `hosts` file and then set it with
`-i hosts`. Alternatively you can pass a comma seperated host list (with a
comma at the end) like `-i "127.0.0.1,"`.

Take care when running through a docker container - ssh keys, `know_hosts`,
etc, will need to be volume mounted in. When running through docker, use
`docker-compose run --rm ansible` in place of `ansible`.

## 0. Install programs as root

This is required to be done before creating a user since the user uses these
programs (specifically, commands in [`~/.yadm/bootstrap`][bootstrap] may fail).
This can be skipped if instead your yadm bootstrap runs ansible with the
localhost as target.

*This step should be optional. I have still yet to organize the differences
between root and non-root setups.*

```bash
ansible ./plays/base.yml -i "127.0.0.1," --ask-pass
```

## 1. Create your user

To create a new user:

```bash
ansible ./plays/user.yml --ask-pass \
--extra-vars "public_key=~/.ssh/some_key.pub"
```

To delete a user (prompted for delete home + backup)

```bash
ansible ./plays/delete-user.yml --ask-pass
```

## Todos

- [ ] tpm
- [ ] `bind-key -t vi-copy v begin-selection` unkown command
- [ ] prefix
- [ ] statusline
- [ ] colors (for windows, status)
- [ ] tab switching
- [ ] choose interface for ifstat
- [ ] local nvim
- [ ] local tmux
- [ ] local yadm
- [ ] packer support for Digital Ocean, AWS, etc
- [ ] docker entrypoint that adds keys to ssh-agent
- [ ] vim tab color to match tmux tabs
- [ ] run ansible with target localhost from yadm bootstrap
- [ ] don't run container as root

[bootstrap]: https://github.com/thejmazz/dottos/blob/master/.yadm/bootstrap
[dottos]: https://github.com/thejmazz/dottos
[letsencrpypt]: https://letsencrypt.org/
[yadm]: https://github.com/TheLocehiliosan/yadm

