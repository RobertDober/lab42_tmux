Feature:

  lab42_tmux will open the number of indicated additional windows.


  Background:
    Given the directories ~/xxx/xxx, ~/xxx/yyy, ~/xxx/zzz

  Scenario: Session name from directory's base name
    When I run lab42_tmux ~/xxx/xxx
    Then it shall open a tmux session with name "xxx"
    And it shall not open any new windows
    And it shall attach to the new session at the end
    And the exit status should be 0

  @wip
  Scenario: Session name from directory's base name and some windows
    When I run lab42_tmux ~/xxx/yyy windows: 2 
    Then it shall open a tmux session with name "yyy"
    And it shall open 2 additional windows
    And it shall attach to the new session at the end
    And the exit status should be 0

  Scenario: Second call of session attaches only
    Given I run lab42_tmux ~/xxx/zzz
    When I rerun lab42_tmux ~/xxx/zzz
    Then it shall attach to the tmux session
    And it shall not open another tmux session

