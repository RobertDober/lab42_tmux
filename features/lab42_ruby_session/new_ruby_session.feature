Feature:

  lab42_ruby_session will open a ruby tmux session with appropriate windows


  Background:
    Given the directory ~/xxx/mygem

  @wip
  Scenario: A typcial ruby gem's layout
    When I run lab42_ruby_session ~/xxx/mygem
    Then it shall open a tmux session with name "mygem"
    And it shall open the following windows:
      | name | command |
      | repl | irb     |
      | vi   | vim .   |
    And it shall attach to the new session at the end
    And the exit status should be 0
