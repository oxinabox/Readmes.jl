# Readmes

[![Build Status](https://github.com/oxinabox/Readmes.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/oxinabox/Readmes.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)

The core thesis of this package is that full on deployed documentation websites (e.g. done with [Documenter.jl](https://github.com/JuliaDocs/Documenter.jl)) is overkill for many packages; and that a good read me is all you need.
People often only look at the readme on github, they don't want to click through to the docs.
However, one feature that is missing from that is automatically including docstrings into the read-me.
This package aims to solve that.

Rather than working with the `README.md` directly, you work on a `README.template.md`,
from which the `README.md` is generated.
You then check that file into the the git-repo and it will be displayed by github etc.
When you update it 

This package has one function:
```@docs
generate_readme
```


## Automatically regenerating the `README.md` when `README.template.md` or docstring changes

You can use a github action (like this repo does) that automatically adds a commit to regenerate the `README.md`.
You can just copy the file from [`.github/workflows/regenerate.yml`](.github/workflows/regenerate.yml) into your repo.

You could alternatively do it will a similar git precommit hook script locally.

## FAQ

### Isn't checking in generated files like this bad?
Arguably, but better done than perfect.
Its much easier to check in a file than sort out deploy keys etc.
And github etc only render the checked in `README.md`.

### What if I edit the generated README.md directly?
Don't do that.
It will be deleted the next time it is regenerated.
A warning is at the top of the generated file to remind people not to.

### What enviroment should I install Readmes.jl in?
It is the assumption of the aforementioned github actions script that this is installed to `/docs/Project.toml` (potentially along side Documenter.jl etc).
But really you can install it anywhere.