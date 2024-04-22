package panels

import (
	panelBuilder "github.com/perses/perses/cue/dac-utils/prometheus/panel"
	promQuery "github.com/perses/perses/cue/schemas/queries/prometheus:model"
)

statUptime: panelBuilder & {
    #filter: _

    spec: {
        display: {
            name: "Uptime"
            description: "System uptime"
        },
        plugin: commonStatPlugin & { spec: format: unit: "seconds" }
        queries: [{
            kind: "TimeSeriesQuery"
            spec: plugin: promQuery & { spec: {
                datasource: name: "argos-world"
                query: """
                node_time_seconds{\(#filter)}
                -
                node_boot_time_seconds{\(#filter)}
                """
            }}
        }]
    }
}