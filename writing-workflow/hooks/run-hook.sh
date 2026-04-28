#!/bin/bash
# Writing Workflow Plugin Hook Runner (Unix/macOS)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec bash "${SCRIPT_DIR}/$1"
