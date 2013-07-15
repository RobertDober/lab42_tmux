# Lab42, Programmers' Best Friend In Ruby 2

## Tmux

### Predefined Scripts

#### lab42\_tmux

```
  lab42_ruby_session project_home [:dry_run] [repl: <repl and params>]
```

Opens a tmux session with the following windows




      repl, defaulting to "irb"
      vi "vi ."
      lib "vi lib"
      spec "vi spec" iff project_home/spec exists
      features "vi feartures" iff project_home/featutes exists 
      cucu "sh" iff project_home/featutes exists 
      a shell
  
*Broken in 0.0.2*
```
  lab42_tmux some_path [windows: n]
```

If a session with the basename of `some_path` exists will attach to it. Otherwise
will open a session with that name and n *additional* windows, each window will be cwed into `some_path.
