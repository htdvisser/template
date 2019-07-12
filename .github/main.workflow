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

workflow "Triage Issue" {
	on = "issues"
	resolves = ["Apply Issue labels", "Assign Issue to htdvisser"]
}

action "Apply Issue labels" {
	uses = "actions/github@v1.0.0"
	args = "label triage --action=opened"
	secrets = ["GITHUB_TOKEN"]
}

action "Assign Issue to htdvisser" {
	uses = "actions/github@v1.0.0"
	args = "assign htdvisser --action=opened"
	secrets = ["GITHUB_TOKEN"]
}

workflow "Build Master" {
	on = "push"
	resolves = ["Build Documentation"]
}

action "Filter branch master" {
	uses = "actions/bin/filter@master"
	args = "branch master"
}

action "Build Documentation" {
	needs = "Filter branch master"
	uses = "./.github/actions/hugo"
	args = "-s doc"
}
