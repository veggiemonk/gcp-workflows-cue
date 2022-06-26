package main

import (
	"fmt"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"cuelang.org/go/cue/format"
	cueload "cuelang.org/go/cue/load"
)

func main() {
	// 	Create a new context
	// Required to load a cue files
	cuectx := cuecontext.New()

	// Simple cue configuration
	// We will need it later
	config := &cueload.Config{}

	// Load a cue instance from the current directory
	instances := cueload.Instances([]string{"./workflows.cue"}, config)

	// Retrieve first instance
	// There can be more if there are multiples packets in the directory (if I have understood well)
	// It returns a usable value.
	v := cuectx.BuildInstance(instances[0])

	// Generate AST from cue instance
	ast := v.Syntax(
		// Uncomment to close struct and lists
		// Comment to get theoretical plan
		// cue.Final(),

		// Display docs
		cue.Docs(true),
	)

	// Format beautiful display from ast
	display, err := format.Node(ast)
	if err != nil {
		panic(err)
	}

	fmt.Println(string(display))
}
