# Getting Started Solution Template


## What needs to be included in this repo

- [x] sample yaml file for a solution application
- [x] need one (1) `assets/index.html` file
- [x] need one (1) `endpoint/example.lua` file
- [x] need one (1) `modules/example.lua` file
- [x] need one (1) `services/device.lua` file
- [ ] Documentation within example files (_& directories?_)
- [ ] _what else?_


## What needs to be done to get this to work

- [ ] 1) Platform support for the yaml file (NOTE: support for `Solutionfile.json` will remain)([MUR-3648](https://i.exosite.com/jira/browse/MUR-3648), Renaud)
- [ ] 2) Extend support in MuranoCLI for `.yml` and `.yaml` extention instead of `.murano`(Landon)
- [ ] 3) Convert the example repos from `Solutionfile.json` --to--> `murano.yml` (AE)
- [ ] 4) Document within each code file (what it does, why it's there, how to use, what options exists) (AE)


## Future

- Update examples to use `require`
- Once support is added to the platform for running an `init` script for the solution context we need at add support for it in the `murano.yml`
