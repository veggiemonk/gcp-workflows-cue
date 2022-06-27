#!/bin/bash

[[ ! -f "workflows.json" ]] && wget https://json.schemastore.org/workflows.json

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
    
cue import -f -p workflow -l '#WorkflowSpec:' workflows.json
