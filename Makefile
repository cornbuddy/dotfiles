.PHONY: workstation
workstation: galaxy
	ansible-playbook -vv --diff workstation.yml --ask-become-pass $(ARGS)

.PHONY: galaxy
galaxy:
	ansible-galaxy role install -r requirements.yml
	ansible-galaxy collection install -r requirements.yml

.PHONY: pre-commit
pre-commit:
	pre-commit install
	pre-commit run --verbose --all-files --show-diff-on-failure
