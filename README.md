[![Clojars Project](https://img.shields.io/clojars/v/cark/clojure-lib-template.svg)](https://clojars.org/cark/clojure-lib-template)
[![cljdoc badge](https://cljdoc.org/badge/cark/clojure-lib-template)](https://cljdoc.org/d/cark/clojure-lib-template/CURRENT)
# clojure-lib-template
A library template
## What is it
This library template has the basic functionalities for creating a new library.
- Manage project version in git via command line script
- Generate a pom
- Build the artifact
- Deploy to Clojars
- Compatible with CljDoc
- Testing with Kaocha
## Building
### Requirements
- have a git tag in your repository looking something like this : `v0.0.1`
- have your github origin set up
- have your repository fully commited
- have your clojars credentials at the ready, either in your maven configuration, or as environment variables
### Windows
Building a release / dry run :
```
script\release
```
Building a release, incrementing your version number then deploying to clojars :
```
script\release patch
```
This parameter can be `patch`, `minor` or `major`.
### Bash
No scripts for you. Build one based on the cmd script then share it with me !
## License
Copyright (c) Sacha De Vos and contributors. All rights reserved.

The use and distribution terms for this software are covered by the Eclipse Public License 1.0 (http://opensource.org/licenses/eclipse-1.0.php) which can be found in the file LICENSE.html at the root of this distribution. By using this software in any fashion, you are agreeing to be bound by the terms of this license. You must not remove this notice, or any other, from this software.
