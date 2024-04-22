package panels

import (
	panelBuilder "github.com/perses/perses/cue/dac-utils/prometheus/panel"
	promQuery "github.com/perses/perses/cue/schemas/queries/prometheus:model"
)

timeseriesNetworkTrafficBasic: panelBuilder & {
	#filter: _

	spec: {
		display: {
			name:        "Network Traffic Basic"
			description: "Basic network info per interface"
		}
		plugin: commonTimeseriesPlugin
		queries: [
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {spec: {
					datasource: name: "argos-world"
					query: """
                    irate(node_network_receive_bytes_total{\(#filter)}[$__rate_interval]) * 8
                    """
					seriesNameFormat: "recv {{device}}"
				}}
			},
			{
				kind: "TimeSeriesQuery"
				spec: plugin: promQuery & {spec: {
					datasource: name: "argos-world"
					query: """
                    irate(node_network_transmit_bytes_total{\(#filter)}[$__rate_interval]) * 8
                    """
					seriesNameFormat: "trans {{device}}"
				}}
			},
		]
	}
}
