Feature:

  lab42_tmux will open the number of indicated additional windows.


  Background:
    Given the directory ~/xxx/yyy

  @wip
  Scenario: Session name from directory's base name
    When I run lab42_tmux ~/xxx/yyy
    Then it shall open a tmux session with name "yyy"
    And it shall open only one window
    And it shall attach to the new session at the end
    And the exit status should be 0

  @wip
  Scenario: Session name from directory's base name and some windows
    When I run lab42_tmux ~/xxx/yyy windows: 2 
    Then it shall open a tmux session with name "yyy"
    And it shall open 3 windows
    And it shall attach to the new session at the end
    And the exit status should be 0

  Scenario: Second call of session attaches only
    Given I run lab42_tmux ~/xxx/yyy
    When I rerun lab42_tmux ~/xxx/yyy
    Then it shall attach to the tmux session
    And it shall not open another tmux session

  Scenario: dry_run parameter avoids calls to tmux
    When I run lab42_tmux ~/xxx/yyy :dry_run
    Then it shall not open a tmux session
    And it shall print the tmux commands
