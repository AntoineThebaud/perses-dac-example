package panels

import (
	panelBuilder "github.com/perses/perses/cue/dac-utils/prometheus/panel"
	promQuery "github.com/perses/perses/cue/schemas/queries/prometheus:model"
)

statRootFSTotal: panelBuilder & {
    #filter: _

    spec: {
        display: {
            name: "RootFS Total"
            description: "Total RootFS"
        },
        plugin: commonStatPlugin & unitBytes
        queries: [{
            kind: "TimeSeriesQuery"
            spec: plugin: promQuery & { spec: {
                datasource: name: "argos-world"
                query: """
                node_filesystem_size_bytes{\(#filter),mountpoint="/",fstype!="rootfs"}
                """
            }}
        }]
    }
}