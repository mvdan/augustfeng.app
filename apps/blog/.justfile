[private]
default:
    @just --list

server:
    open http://localhost:1313
    hugo server

lint:
    emacs --script scripts/linter/linter.el -f program | cue vet scripts/linter/linter.cue json: -