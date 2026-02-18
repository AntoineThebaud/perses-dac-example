package panels

import (
	panelBuilder "github.com/perses/plugins/prometheus/sdk/cue/panel"
	promQuery "github.com/perses/plugins/prometheus/schemas/prometheus-time-series-query:model"
	promDs "github.com/perses/plugins/prometheus/schemas/datasource:model"
)

timeseriesMemoryBasic: panelBuilder & {
	#filter: _

	spec: {
		display: {
			name:        "Memory Basic"
			description: "Basic memory usage"
		}
		plugin: commonTimeseriesPlugin & {spec: yAxis: format: unit: "bytes"}
		queries: [
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {spec: {
					datasource: kind: promDs.#kind // TODO remove when possible (when explicitopen made default?), we shouldnt have to specify that
					datasource: name: "argos-world"
					query: """
                    node_memory_MemTotal_bytes{\(#filter)}
                    """
					seriesNameFormat: "RAM Total"
				}}
			},
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {spec: {
					datasource: kind: promDs.#kind // TODO remove when possible (when explicitopen made default?), we shouldnt have to specify that
					datasource: name: "argos-world"
					query: """
                    node_memory_MemTotal_bytes{\(#filter)}
                    - node_memory_MemFree_bytes{\(#filter)}
                    - (
                        node_memory_Cached_bytes{\(#filter)}
                        + node_memory_Buffers_bytes{\(#filter)}
                        + node_memory_SReclaimable_bytes{\(#filter)}
                    )
                    """
					seriesNameFormat: "RAM Used"
				}}
			},
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {spec: {
					datasource: kind: promDs.#kind // TODO remove when possible (when explicitopen made default?), we shouldnt have to specify that
					datasource: name: "argos-world"
					query: """
                    node_memory_Cached_bytes{\(#filter)}
                    + node_memory_Buffers_bytes{\(#filter)}
                    + node_memory_SReclaimable_bytes{\(#filter)}
                    """
					seriesNameFormat: "RAM Cache + Buffer"
				}}
			},
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {spec: {
					datasource: kind: promDs.#kind // TODO remove when possible (when explicitopen made default?), we shouldnt have to specify that
					datasource: name: "argos-world"
					query: """
                    node_memory_MemFree_bytes{\(#filter)}
                    """
					seriesNameFormat: "RAM Free"
				}}
			},
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {spec: {
					datasource: kind: promDs.#kind // TODO remove when possible (when explicitopen made default?), we shouldnt have to specify that
					datasource: name: "argos-world"
					query: """
                    node_memory_SwapTotal_bytes{\(#filter)} - node_memory_SwapFree_bytes{\(#filter)}
                    """
					seriesNameFormat: "SWAP used"
				}}
			},
		]
	}
}
