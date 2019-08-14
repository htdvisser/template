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
	resolves = ["Update Github Pages"]
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

action "Update Github Pages" {
	needs = "Build Documentation"
	uses = "./.github/actions/update-gh-pages"
	args = "./doc/public"
	secrets = ["DEPLOY_KEY"]
}
