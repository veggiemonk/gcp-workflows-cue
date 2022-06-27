#!/bin/bash


git clone --depth 1 https://github.com/GoogleCloudPlatform/workflows-samples.git

# brew install cue-lang/tap/cue
# OR 
# go install cuelang.org/go/cmd/cue@latest

cue vet -v -c workflows-samples/src/*.workflows.yaml workflows.cue -d '#WorkflowSpec'
