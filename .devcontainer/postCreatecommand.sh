#!/usr/bin/env bash

pip install -r /workspaces/pdt-l2ls-demo/.devcontainer/requirements.txt

ansible-galaxy install -r /workspaces/pdt-l2ls-demo/.devcontainer/requirements.yml