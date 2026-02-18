module: "github.com/antoinethebaud/perses-dac-example"
language: {
	version: "v0.15.3"
}
deps: {
	"github.com/perses/perses/cue@v0": {
		v:       "v0.53.0-rc.1"
		default: true
	}
	"github.com/perses/plugins/gaugechart@v0": {
		v:       "v0.12.0-rc.1"
		default: true
	}
	"github.com/perses/plugins/prometheus@v0": {
		v:       "v0.57.0-rc.1"
		default: true
	}
	"github.com/perses/plugins/statchart@v0": {
		v:       "v0.12.0-rc.1"
		default: true
	}
	"github.com/perses/plugins/timeserieschart@v0": {
		v:       "v0.12.0-rc.1"
		default: true
	}
	"github.com/perses/shared/cue@v0": {
		v:       "v0.53.0-rc.2"
		default: true
	}
}
