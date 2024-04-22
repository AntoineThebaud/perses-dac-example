package panels

import (
	panelBuilder "github.com/perses/perses/cue/dac-utils/prometheus/panel"
	promQuery "github.com/perses/perses/cue/schemas/queries/prometheus:model"
)

timeseriesDiskSpaceUsedBasic: panelBuilder & {
	#filter: _

	spec: {
		display: {
			name:        "Disk Space Used Basic"
			description: "Disk space used of all filesystems mounted"
		}
		plugin: commonTimeseriesPlugin & {spec: yAxis: format: unit: "percent"}
		queries: [{
			kind: "TimeSeriesQuery"
			spec: plugin: promQuery & {spec: {
				datasource: name: "argos-world"
				query: """
                100 - (
                    (node_filesystem_avail_bytes{\(#filter),device!~'rootfs'} * 100)
                    /
                    node_filesystem_size_bytes{\(#filter),device!~'rootfs'}
                )
                """
				seriesNameFormat: "{{mountpoint}}"
			}}
		}]
	}
}
