#!/bin/bash

wget https://json.schemastore.org/workflows.json

# brew install cue-lang/tap/cue
# OR 
# go install cuelang.org/go/cmd/cue@latest

cue import -f -p workflow -l '#WorkflowSpec:' workflows.json
