workflow "Triage Pull Request" {
	on = "pull_request"
	resolves = "Apply Pull Request labels"
}

action "Filter action opened|synchronize" {
	uses = "actions/bin/filter@master"
	args = "action 'opened|synchronize'"
}

action "Apply Pull Request labels" {
	uses = "actions/labeler@v1.0.0"
	needs = "Filter action opened|synchronize"
	env = { LABEL_SPEC_FILE=".github/pull_request_labels.yml" }
	secrets = ["GITHUB_TOKEN"]
}
