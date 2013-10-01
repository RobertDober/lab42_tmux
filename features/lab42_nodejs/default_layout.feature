Feature:

  lab42_nodejs will open a node.js session with a default window configuration


  Background:
    Given the directories ~/xxx/nodeproject, ~/xxx/nodeproject/src, ~/xxx/nodeproject/spec

  Scenario: Default windows with spec
    When I run lab42_nodejs ~/xxx/nodeproject
    Then it shall open a tmux session with name "nodeproject" in the project_home
    And it shall open the following windows:
      | name | command |
      | repl | node     |
      | vi   | vi .    |
      | src  | vi src  |
      | spec | vi spec |
      | sh   |         |
    And it shall attach to the new session at the end
    And the exit status should be 0

