Feature:

  lab42_ruby_session will open a ruby tmux session with appropriate windows.
  These windows have a configurable configuration, the presence of some windows
  depends on the presence of some directories (e.g. features and spec)


  Background:
    Given the directories ~/xxx/mygem, ~/xxx/mygem/lib, ~/xxx/mygem/spec, ~/xxx/mygem/features

  @wip
  Scenario: A typcial ruby gem's layout
    When I run lab42_ruby_session ~/xxx/mygem
    Then it shall open a tmux session with name "mygem" in the project_home
    And it shall open the following windows:
      | name     | command     |
      | repl     | irb         |
      | vi       | vi .        |
      | lib      | vi lib      |
      | spec     | vi spec     |
      | features | vi features |
      | cucu     |             |
      | sh       |             |
    And it shall attach to the new session at the end
    And the exit status should be 0
