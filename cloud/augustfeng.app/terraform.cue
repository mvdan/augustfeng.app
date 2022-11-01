package terraform

configuration: {
	lib.gcp & {
		_gcp: iam: "ci-cd-pipeline": {
			account_id:   "ci-cd-pipeline"
			display_name: "GitHub Actions service account"
			roles: ["roles/container.admin"]
			key: rotation_days: 30
		}
	}
	lib.github & {
		_github: secrets: GOOGLE_CREDENTIALS: "${base64decode(google_service_account_key.ci-cd-pipeline.private_key)}"
	}
}