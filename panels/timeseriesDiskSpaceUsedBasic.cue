package panels

import (
	panelBuilder "github.com/perses/plugins/prometheus/sdk/cue/panel"
	promQuery "github.com/perses/plugins/prometheus/schemas/prometheus-time-series-query:model"
	promDs "github.com/perses/plugins/prometheus/schemas/datasource:model"
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
				datasource: kind: promDs.#kind // TODO remove when possible (when explicitopen made default?), we shouldnt have to specify that
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
