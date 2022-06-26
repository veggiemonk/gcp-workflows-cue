package workflow

import "list"

#WorkflowSpec: {
	// Google Cloud Workflows config file
	//
	// Orchestrate Workflows consisting of Google Cloud APIs, SaaS
	// APIs or private API endpoints.
	@jsonschema(schema="http://json-schema.org/draft-07/schema#")
	(#stepArray | (null | bool | number | string | [_, ...] | {
		{[=~"^.*$" & !~"^()$"]: #subworkflow}
	})) & _

	#subworkflow: null | bool | number | string | [...] | {
		// A list of parameters.
		params?: [...string]

		// An array of objects with a single step.
		steps?: #stepArray
	}

	#stepArray: [_, ...] & [...null | bool | number | string | list.MaxItems(1) & [_, ...] | {
		{[=~"^.*$" & !~"^()$"]: #step}
	}]

	#step: null | bool | number | string | [...] | {
		// Required
		call?: ("http.get" | "http.post" | "http.request" | "sys.sleep" | string) & string

		// Arguments to a workflow step.
		args?: null | bool | number | string | [...] | {
			url?: (string | string) & string

			// Required if using call type http.request. The type of HTTP
			// request method to use.
			method?: "GET" | "HEAD" | "POST" | "PUT" | "DELETE" | "CONNECT" | "OPTIONS" | "TRACE" | "PATCH"

			// Request headers.
			headers?: {
				...
			}

			// Request body.
			body?: {
				...
			}

			// Request query parameters.
			query?: {
				...
			}

			// Required if the API being called requires authentication.
			auth?: null | bool | number | string | [...] | {
				// The type of authentication.
				type?: "OIDC" | "OAuth2"
			}

			// Time in seconds. How long a request is allowed to run before
			// throwing an exception.
			timeout?: number

			// The number of seconds to sleep.
			seconds?: number
		}

		// Define a dictionary.
		assign?: [...null | bool | number | string | list.MaxItems(1) & [_, ...] | {
			...
		}]

		// Variable name where the result of an HTTP invocation step is
		// stored.
		result?: string

		// A switch block.
		switch?: [...null | bool | number | string | [...] | {
			// An expression to switch on.
			condition: string

			// The next step to jump to. "end" to terminate.
			next?: string | *"end"

			// A list of steps to run in this switch statement.
			steps?: #stepArray

			// Stop a workflow's execution and return a value, variable, or
			// expression.
			return?: _

			// Raise an exception.
			raise?: #raise
		}]

		// The next step to jump to. "end" to terminate.
		next?: string | *"end"

		// Stop a workflow's execution and return a value, variable, or
		// expression.
		return?: _

		// Try a single step or a list of steps.
		try?: #step

		// Optional. If omitted, all other fields are required. Options
		// include ${http.default_retry} and
		// ${http.default_retry_non_idempotent}. Allows you to specify a
		// default retry policy to use. If you specify a retry policy,
		// omit all other fields in the retry block.
		retry?: null | bool | number | string | [...] | {
			// Required if you don't select a default retry policy. Defines
			// which error codes will be retried. Options include
			// ${http.default_retry_predicate},
			// ${http.default_retry_predicate_non_idempotent}, or a custom
			// predicate defined as a subworkflow.
			predicate?: string

			// Maximum number of times a step will be retried.
			max_retries?: int

			// Block that controls how retries occur.
			backoff?: null | bool | number | string | [...] | {
				// Delay in seconds between the initial failure and the first
				// retry.
				initial_delay?: int

				// Maximum delay in seconds between retries.
				max_delay?: int

				// Multiplier applied to the previous delay to calculate the delay
				// for the subsequent retry.
				multiplier?: int
			}
		}

		// Except a try clause.
		except?: #step | (null | bool | number | string | [...] | {
			// Name of a dictionary variable that contains the error message.
			as?: string

			// An array of objects with a single step.
			steps?: #stepArray
		})

		// Raise an exception.
		raise?: #raise
	}

	#raise: (string | {
		...
	}) & (string | {
		...
	})
}
