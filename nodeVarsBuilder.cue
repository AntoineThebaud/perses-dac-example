package nodeVarsBuilder

import (
	varGroupBuilder "github.com/perses/perses/cue/dac-utils/variable/group"
	promQLVarBuilder "github.com/perses/plugins/prometheus/sdk/cue/variable/promql"
	textVarBuilder "github.com/perses/perses/cue/dac-utils/variable/text"
)

varGroupBuilder & {
	#input: [
		textVarBuilder & {
			#name: "stack"
			#value: "erd4"
			#constant: true
			#display: hidden: true
		},
		textVarBuilder & {
			#name: "prometheus"
			#value: "system"
			#constant: true
			#display: hidden: true
		},
		textVarBuilder & {
			#name: "job"
			#value: "cmdbrtu-custom-sd"
			#constant: true
			#display: hidden: true
		},
		promQLVarBuilder & {
			#name: "instance"
			#display: name: "Host"
			#metric: "node_uname_info"
			#datasourceName: "argos-world"
		},
	]
}
