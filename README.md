# perses-dac-example

Example of doing Dashboard-as-Code with Perses, using the CUE SDK.

## Cheat sheet

```bash
# login first
percli login
# refresh token when needed
percli refresh
# build dashboards
percli dac build -d dashboards/ -ojson
# deploy dashboards
percli apply -d built/
# shortcut build + deploy
percli dac build -d dashboards/ -ojson && percli apply -d built/
```

## References:

Perses:
- [DaC user guide](https://perses.dev/docs/perses/v0.44.0/user-guides/dashboard-as-code.md/)
- [DaC CUE SDK documentation](https://github.com/perses/perses/tree/main/docs/dac/cue)

CUE:
- [CUE's official website](https://cuelang.org/)
- [Cuetorials](https://cuetorials.com/), a third-party source of information that is a very good complement
