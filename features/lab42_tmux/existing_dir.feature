Feature:

  lab42_tmux opens a tmux session in the given directory. The name of the session is
  the basename of the given directory. Additional windows can be opened via the win: parameter


  Background:
    Given the directory mydir

  Scenario: Only one window
    When I run lab42_tmux mydir
    Then it shall open a tmux session with name "mydir" in the project_home
    And it shall attach to the new session at the end
    And the exit status should be 0

  Scenario: Additional windows
    When I run lab42_tmux mydir wins: 2
    Then it shall open a tmux session with name "mydir" in the project_home
    And it shall open the following windows:
      | name | command |
      | sh   |         |
      | sh   |         |
    And it shall attach to the new session at the end
    And the exit status should be 0

