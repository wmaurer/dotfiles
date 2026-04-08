#!/bin/bash
# chezmoi:template: false
systemctl --user daemon-reload
systemctl --user enable --now agentsview.service
