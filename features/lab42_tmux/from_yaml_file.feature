Feature:

  lab42_tmux opens a tmux session as specified in the given yaml file and does not open it in
  a directory with the same name.

  Background:
    Given the directory mydir
    And the yaml file mydir with the following content
      | key  | value |
      | wins | 1     |
      | vi   | true  |

    @wip
  Scenario: Opens session from file
    When I run lab42_tmux mydir
    Then it shall open a tmux session with name specified in the yaml file
    And it shall open the following windows:
      | name | command |
      | vi   |  vi     |
      | sh   |         |
    And it shall attach to the new session at the end
    And the exit status should be 0

  Scenario: CL Parameters override yaml file parameters
    When I run lab42_tmux mydir wins: 2
    Then it shall open a tmux session with name specified in the yaml file
    And it shall open the following windows:
      | name | command |
      | vi   |  vi     |
      | sh   |         |
      | sh   |         |
    And it shall attach to the new session at the end
    And the exit status should be 0

