package panels

import (
	panelBuilder "github.com/perses/perses/cue/dac-utils/prometheus/panel"
	promQuery "github.com/perses/perses/cue/schemas/queries/prometheus:model"
)

statCPUCores: panelBuilder & {
    #filter: _

    spec: {
        display: {
            name: "CPU Cores"
            description: "Total number of CPU cores"
        },
        plugin: commonStatPlugin & { spec: format: unit: "decimal" }
        queries: [{
            kind: "TimeSeriesQuery"
            spec: plugin: promQuery & { spec: {
                datasource: name: "argos-world"
                query: """
                count(count(node_cpu_seconds_total{\(#filter)}) by (cpu))
                """
            }}
        }]
    }
}