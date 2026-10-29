# spawn --view (herdr)
Goal: see workers live in herdr and in its Agents panel, tidy, with no change to how workers run.
Default on when herdr's server is reachable; HARNESS_VIEW=off disables; no herdr falls back to headless.
Non-goals: interactive agents, tab reuse, per-task workspaces, changing worker execution.
Behavior: tab per worker in the current workspace, label "<id> · <cli> · <shape>", pane tails the worker log,
pane reported as agent (working, then idle or blocked) with title and display name.
Close: success closes the tab; failed, timeout or violation keeps it (blocked) and notifies (request sound);
HARNESS_VIEW_NOTIFY=all also notifies on success; HARNESS_VIEW_KEEP=1 keeps success tabs; spawn --close-views sweeps kept tabs.
Acceptance: view tests in tests/spawn.test.sh green; real run in live herdr shows tab, agent in `herdr agent list`, auto-close.
