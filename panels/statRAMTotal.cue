package panels

import (
	panelBuilder "github.com/perses/perses/cue/dac-utils/prometheus/panel"
	promQuery "github.com/perses/perses/cue/schemas/queries/prometheus:model"
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
				datasource: name: "argos-world"
				query: """
                node_memory_MemTotal_bytes{\(#filter)}
                """
			}}
		}]
	}
}
