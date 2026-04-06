.PHONY: workstation
workstation: galaxy
	ansible-playbook -vv --diff workstation.yml --ask-become-pass $(ARGS)

.PHONY: galaxy
galaxy:
	ansible-galaxy role install --force -r requirements.yml
	ansible-galaxy collection install --force -r requirements.yml

.PHONY: pre-commit
pre-commit:
	pre-commit install
	pre-commit run --verbose --all-files --show-diff-on-failure
