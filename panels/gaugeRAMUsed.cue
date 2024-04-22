package panels

import (
	panelBuilder "github.com/perses/perses/cue/dac-utils/prometheus/panel"
	promQuery "github.com/perses/perses/cue/schemas/queries/prometheus:model"
)

gaugeRAMUsed: panelBuilder & {
    #filter: _

    spec: {
        display: {
            name: "RAM Used"
            description: "Non available RAM memory"
        },
        plugin: commonGaugePlugin
        queries: [
            {
                kind: "TimeSeriesQuery"
                spec: plugin: promQuery & {
                    spec: {
                        datasource: name: "argos-world"
                        query: """
                        (
                            (
                                avg_over_time(node_memory_MemTotal_bytes{\(#filter)}[$__rate_interval])
                                -
                                avg_over_time(node_memory_MemFree_bytes{\(#filter)}[$__rate_interval])
                            )
                            /
                            (
                                avg_over_time(node_memory_MemTotal_bytes{\(#filter)}[$__rate_interval])
                            )
                        ) * 100
                        """
                    }
                }
            },
            {
                kind: "TimeSeriesQuery"
                spec: plugin: promQuery & {
                    spec: {
                        datasource: name: "argos-world"
                        query: """
                        100 - (
                            (
                                avg_over_time(node_memory_MemAvailable_bytes{\(#filter)}[$__rate_interval])
                                *
                                100
                            ) 
                            /
                            avg_over_time(node_memory_MemTotal_bytes{\(#filter)}[$__rate_interval])
                        )
                        """
                    }
                }
            }
        ]
    }
}