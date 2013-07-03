@wip
Feature:

  lab42_tmux will not open or attach to a session if no parameter is given

  Scenario: Missing session name
    When I run lab42_tmux
    Then the output should contain "unable to determine session name"
    And it shall not open a tmux session
    And it shall not attach to a tmux session
    And the exit status should be 1

  Scenario: Missing directory
    When I run lab42_tmux /home/xxx
    Then the output should contain "no such directory /home/xxx"
    And it shall not open a tmux session
    And it shall not attach to a tmux session
    And the exit status should be 1
