Feature:

  lab42_tmux opens a tmux session in the given directory. The name of the session is
  the basename of the given directory. Additional windows can be opened via the win: parameter

  But the script will not open a new tmux session in the scenarii...

  Scenario: Missing parameter
    When I run lab42_tmux
    Then the output should contain "unable to determine session name"
    And it shall not open a tmux session
    And the exit status should be -1

  Scenario: Missing directory
    When I run lab42_tmux nonexisting_dir
    Then the output should match "is neither a yaml file or directory"
    And it shall not open a tmux session
    And the exit status should be -1


