.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: anta
anta: ## Run ANTA checks
	anta nrfu -u test -P -i clab_anta_inventory.yml -c clab_anta_tests.yml

.PHONY: anta-group-by-device
anta-group-by-device: ## Run ANTA checks and group by device
	anta nrfu -u test -P -i clab_anta_inventory.yml -c clab_anta_tests.yml table --group-by device

.PHONY: anta-group-by-test
anta-group-by-test: ## Run ANTA checks and group by test
	anta nrfu -u test -P -i clab_anta_inventory.yml -c clab_anta_tests.yml table --group-by test

.PHONY: anta-failure-only
anta-failure-only: ## Run ANTA checks, hide success, skipped and errors
	anta nrfu -u test -P -i clab_anta_inventory.yml -c clab_anta_tests.yml --hide success --hide skipped --hide error

.PHONY: anta-text
anta-text: ## Run ANTA checks
	anta nrfu -u test -P -i clab_anta_inventory.yml -c clab_anta_tests.yml

.PHONY: anta-text-failure-only
anta-text-failure-only: ## Run ANTA checks, hide success, skipped and errors and output text
	anta nrfu -u test -P -i clab_anta_inventory.yml -c clab_anta_tests.yml --hide success --hide skipped --hide error text

.PHONY: anta-markdown
anta-markdown: ## Run ANTA checks
	anta nrfu -u test -P -i clab_anta_inventory.yml -c clab_anta_tests.yml md-report --md-output anta-report.md

.PHONY: anta-snapshot
anta-snapshot: ## Take ANTA snapshot
	anta exec snapshot -u test -P -i clab_anta_inventory.yml -c commands.yml -o snapshots/

.PHONY: anta-clear-counters
anta-clear-counters: ## Clear counters on switches
	anta exec clear-counters -u test -P -i clab_anta_inventory.yml

.PHONY: anta-collect-tech-support
anta-collect-tech-support: ## Gather tech support files from switches
	anta exec collect-tech-support -u test -P -i clab_anta_inventory.yml

.PHONY: verify-catalog
verify-catalog: ## Verify your ANTA tests are valid
	anta check catalog -c clab_anta_tests.yml
