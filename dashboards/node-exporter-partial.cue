package dashboard

import (
	dashboardBuilder "github.com/perses/perses/cue/dac-utils/dashboard"
	panelGroupsBuilder "github.com/perses/perses/cue/dac-utils/panelgroups"
	promFilterBuilder "github.com/perses/plugins/prometheus/sdk/cue/filter"
	panels "github.com/antoinethebaud/perses-dac-example/panels"
	nodeVarsBuilder "github.com/antoinethebaud/perses-dac-example:nodeVarsBuilder"
)

#nodeFilter: {promFilterBuilder & nodeVarsBuilder}.filter

dashboardBuilder & {
	#name: "node-exporter-partial"
	#display: name: "Node Exporter Partial"
	#project: "athebaud"
	#variables: nodeVarsBuilder.variables
	#panelGroups: panelGroupsBuilder & { #input: [{
		#title: "Quick CPU / Mem / Disk"
		#cols:  7
		#panels: [
			panels.gaugeSysLoad & {#filter: #nodeFilter},
			panels.gaugeRAMUsed & {#filter: #nodeFilter},
			panels.gaugeRootFS & {#filter: #nodeFilter},
			panels.statCPUCores & {#filter: #nodeFilter},
			panels.statRAMTotal & {#filter: #nodeFilter},
			panels.statRootFSTotal & {#filter: #nodeFilter},
			panels.statUptime & {#filter: #nodeFilter},
		]
	}]}
}
