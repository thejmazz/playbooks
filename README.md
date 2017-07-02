# Some Plays

To create a new user:

```bash
PUBLIC_KEY=`cat ~/.ssh/some_key.pub` \
docker-compose run --rm ansible ./plays/user.yml --ask-pass
```

To delete a user (prompted for delete home + backup)

```bash
docker-compose run --rm ansible ./plays/delete-user.yml --ask-pass
```
