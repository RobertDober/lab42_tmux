# Lab42, Programmers' Best Friend In Ruby 2

## Tmux

### Predefined Scripts

#### lab42\_tmux

```
  lab42_tmux some_path [windows: n]
```

If a session with the basename of `some_path` exists will attach to it. Otherwise
will open a session with that name and n *additional* windows, each window will be cwed into `some_path.
