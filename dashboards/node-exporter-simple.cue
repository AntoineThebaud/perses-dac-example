// Copyright 2023 The Perses Authors
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package test

import (
	dashboardBuilder "github.com/perses/perses/cue/dac-utils/dashboard"
	panelGroupsBuilder "github.com/perses/perses/cue/dac-utils/panelgroups"
	varGroupBuilder "github.com/perses/perses/cue/dac-utils/variable/group"
	promQLVarBuilder "github.com/perses/perses/cue/dac-utils/prometheus/variable/promql"
	textVarBuilder "github.com/perses/perses/cue/dac-utils/variable/text"
	promFilterBuilder "github.com/perses/perses/cue/dac-utils/prometheus/filter"

	panels "github.com/AntoineThebaud/dac-tech-talk-dashboard/panels"
)

#nodeVarsBuilder: varGroupBuilder & {
	#input: [
		textVarBuilder & { #name: "stack", #value: "erd4", #constant: true },
		textVarBuilder & { #name: "prometheus", #value: "system", #constant: true},
		textVarBuilder & { #name: "job", #value: "cmdbrtu-custom-sd", #constant: true },
		promQLVarBuilder & {
			#name: "instance"
			#display: name: "Host"
			#metric: "node_uname_info"
			#datasourceName: "argos-world"
		},
	]
}

#nodeFilter: {promFilterBuilder & #nodeVarsBuilder}.filter

dashboardBuilder & {
	#name:      "nodeexportersimple"
	#display: name: "Node Exporter Simple"
	#project:   "athebaud"
	#variables: #nodeVarsBuilder.variables
	#panelGroups: panelGroupsBuilder & {
		#input: [
			{
				#title: "Quick CPU / Mem / Disk"
				#cols:  7
				#panels: [
					panels.gaugeSysLoad & { #filter: #nodeFilter },
					panels.gaugeRAMUsed & { #filter: #nodeFilter },
				]
			},
			{
				#title:  "Basic CPU / Mem / Net / Disk"
				#cols:   2
				#height: 8
				#panels: [
				]
			},
		]
	}
}
