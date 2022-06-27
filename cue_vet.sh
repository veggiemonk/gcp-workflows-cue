#!/bin/bash


[[ ! -d "workflows-samples" ]] && git clone --depth 1 https://github.com/GoogleCloudPlatform/workflows-samples.git

command -v foo >/dev/null 2>&1 || { 
    echo
    echo >&2 "CUE required but not installed.  Aborting."; 
    echo >&2 "to install CUE:";
    echo >&2 "    brew install cue-lang/tap/cue";
    echo >&2 " OR ";
    echo >&2 "go install cuelang.org/go/cmd/cue@latest";
    echo
    exit 1; 
    }

cue vet -v -c workflows-samples/src/*.workflows.yaml workflows.cue -d '#WorkflowSpec'
