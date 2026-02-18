package panels

import (
	panelBuilder "github.com/perses/plugins/prometheus/sdk/cue/panel"
	promQuery "github.com/perses/plugins/prometheus/schemas/prometheus-time-series-query:model"
	promDs "github.com/perses/plugins/prometheus/schemas/datasource:model"
)

statRAMTotal: panelBuilder & {
	#filter: _

	spec: {
		display: {
			name:        "RAM Total"
			description: "Total RAM"
		}
		plugin: commonStatPlugin & unitBytes
		queries: [{
			kind: "TimeSeriesQuery"
			spec: plugin: promQuery & {spec: {
				datasource: kind: promDs.#kind // TODO remove when possible (when explicitopen made default?), we shouldnt have to specify that
				datasource: name: "argos-world"
				query: """
                node_memory_MemTotal_bytes{\(#filter)}
                """
			}}
		}]
	}
}
