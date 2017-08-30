# Getting Started Solution Template

This page describes the project structure used to set & update a Murano Solution. Murano templates can be used in two distinct way:
- To synchronize an existing Murano solution with a local project folder using the [Murano-CLI](http://docs.exosite.com/development/tools/murano-cli/).
- To publish it as template element on the Murano Exchange marketplace to make it available from other Murano businesses. In such case the source code and repo is obfuscated for the template users. Learn more about [Murano Exchange here](http://docs.exosite.com/reference/reference/ui/exchange/authoring-elements-guide.md).

## Template directories structure

```
getting-started-solution-template/
├── assets/index.html
├── endpoints/example.lua
├── modules/example.lua
├── services/device.lua
└── murano.yml
```

## Template format (murano.yml)

We can see the example in [murano.yml](murano.yml) or below.

```yaml
formatversion: 1.0.0

info:
  name: murano
  summary: One line summary of murano
  description: |
    In depth description of murano
    With lots of details.
  authors: ['someone']
  version: 1.0.0

# The sections assets, endpoints, modules, and services are optional.
#
# They all have defaults values that should work for a majority of the projects out
# there. But they are all fully configurable to fit the way you want your project
# to be.

assets:
  location: assets
  include: '**/*'
  exclude: ['**/.*']
  default_page: index.html

endpoints:
  location: endpoints
  include: '**/*.lua'
  exclude: ['*_test.lua', '*_spec.lua']

modules:
  location: modules
  include: '**/*.lua'
  exclude: ['*_test.lua', '*_spec.lua']

services:
  location: services
  include: '**/*.lua'
  exclude: ['*_test.lua', '*_spec.lua']
```

### Required sections for the template

Section name  | Format | Example                                  | Description
--------------|--------|------------------------------------------|----------------------------------
formatversion | string | `formatversion: 1.0.0`                   | The format version of this file.
info          | object | [See in the info section](#info-section) | Metadata about this project.

### Optional sections for the template

Following section are optional and their order is not enforced. If not specified related source files will be ignored. The different section sub-items are themself optional and default values are provided.

Section name | Format | Example                                            | Description
-------------|--------|----------------------------------------------------|--------------------------------------------------------------
assets       | object | [See in the assets section](#assets-section)       | Target source files of the front-end Web application.
endpoints    | object | [See in the endpoints section](#endpoints-section) | Target source files of the webservice back-end endpoints.
modules      | object | [See in the modules section](#modules-section)     | Target reusable module source files.
services     | object | [See in the services section](#services-section)   | Target source files of internal services event handlers.

#### Info section

This section contains meta-information relative to the project.

```yaml
info:
  name: murano
  summary: One line summary of murano
  description: |
    In depth description of murano
    With lots of details.
  authors: [""]
  version: 1.0.0
```

Fieldname   | Format | Example                                                | Description
------------|--------|--------------------------------------------------------|-----------------------------------------------------------------
name        | string | `murano`                                               | Nice short and easy. Also must be a valid domain name component.
summary     | string | `One line summary of murano`                           | Short one line summary of this project.
description | string | `In depth description of murano with lots of details.` | Longer, multiple paragraph explanation.
authors     | list   | `['']`                                                 | Who made this project.
version     | string | `1.0.0 `                                               | The version of the project.

#### Assets section

This section declare static files (Such as front-end javascript code & images) served by the Solution public API powered by the [Asset service](http://docs.exosite.com/reference/services/asset/).

```yaml
assets:
  location: assets
  include: '**/*'
  exclude: ['**/.*']
  default_page: index.html
```

Fieldname    | Format      | Example      | Description                                                                                                                          | Default value
-------------|-------------|--------------|--------------------------------------------------------------------------------------------------------------------------------------|--------------
location     | string      | `assets`     | Root folder name containing the files.                                                                                               | `assets`
include      | string/list | `'**/*'`     | Pattern (or list of patterns) to select files in the location directory.<br>The pattern search is relative to the `location` folder. | `'**/*'`
exclude      | list        | `['**/.*']`  | Pattern allowing to ignore files from the selection.                                                                                 | `['**/.*']`
default_page | string      | `index.html` | Default asset to serve on the root path of the API `/`.                                                                              | `index.html`

#### Endpoints section

This section declare the different endpoint & backend logic for the solution public API powered by the [Webservice service](http://docs.exosite.com/reference/services/webservice/).

```yaml
endpoints:
  location: endpoints
  include: '**/*.lua'
  exclude: ['*_test.lua', '*_spec.lua']
```

Fieldname | Format      | Example                        | Description                                                                                                                          | Default value
----------|-------------|--------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|--------------
location  | string      | `endpoints`                    | Root folder name containing the files.                                                                                               | `endpoints`
include   | string/list | `'**/*.lua'`                   | Pattern (or list of patterns) to select files in the location directory.<br>The pattern search is relative to the `location` folder. | `'**/*.lua'`
exclude   | list        | `['*_test.lua', '*_spec.lua']` | Pattern allowing to ignore files from the selection.                                                                                 | `[]`

##### File content

Selected files needs to contains valid Lua script. Endpoint are defined using a Lua comment header as follow:

```lua
--#ENDPOINT <method> <path>[ <content_type>]
-- Custom logic goes here
```

The `content_type` is optional and `application/json` is the default value.

**Example: ./endpoints/api/userEndpoints.lua**

```lua
--#ENDPOINT POST /api/user
print("Creating a new user")
--#ENDPOINT GET /api/user/{user_id}
print("Fetch a given user" .. request.parameters.user_id)
```

Find more information about endpoints in the [Murano Scripting Reference](http://docs.exosite.com/articles/working-with-apis/#api-endpoint-scripts).

#### Modules section

Reusable script code definitions

```yaml
modules:
  location: modules
  include: '**/*.lua'
  exclude: ['*_test.lua', '*_spec.lua']
```

Fieldname | Format      | Example                        | Description                                                                                                                          | Default value
----------|-------------|--------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|--------------
location  | string      | `modules`                      | Root folder name containing the files.                                                                                               | `modules`
include   | string/list | `'**/*.lua'`                   | Pattern (or list of patterns) to select files in the location directory.<br>The pattern search is relative to the `location` folder. | `'**/*.lua'`
exclude   | list        | `['*_test.lua', '*_spec.lua']` | Pattern allowing to ignore files from the selection.                                                                                 | `[]`

##### File content

Selected file needs to contains valid Lua script and should be structured as a standard Lua modules (http://lua-users.org/wiki/ModulesTutorial).

**Important note:**
- All variable & function should be tagged as *local*.
- The trailing *return* statement is required.
- The module file relative path matters.

Find more informations regarding modules on the [Murano Scripting Reference](http://docs.exosite.com/articles/working-with-apis/#modules).

**Example: ./modules/src/utils.lua**

```lua
local utils = { variable = "World"}
function utils.hello()
  return utils.variable
end
return utils
```

Can be accessed in event handlers or other modules using:

```lua
require("src.utils").hello() -- -> "World"
```

#### Services section

Section describing Services & related scripting logic for the Solution.

```yaml
services:
  location: services
  include: '**/*.lua'
  exclude: ['*_test.lua', '*_spec.lua']
```

Fieldname | Format      | Example                        | Description                                                                                                                          | Default value
----------|-------------|--------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|--------------
location  | string      | `services`                     | Root folder name containing the files.                                                                                               | `services`
include   | string/list | `'**/*.lua'`                   | Pattern (or list of patterns) to select files in the location directory.<br>The pattern search is relative to the `location` folder. | `'**/*.lua'`
exclude   | list | `['*_test.lua', '*_spec.lua']` | Pattern allowing to ignore files from the selection.                                                                                 | `[]`

##### File content

Selected file needs to contains valid Lua script. The service and event can be defined using the following Lua comment to define multiple event handlers in a single file:

```lua
--#EVENT <service_alias> <event_type>
-- Custom logic goes here
```

**Example: ./services/yyy/xxx.lua**

```lua
--#EVENT timer timer
print(request.timer_id)
--#EVENT device2 event
print(event.identity)
```

If the EVENT tag is missing the file structure is used to represent the service & event as follow.<br>Either:<br>`./services/<service_alias>/<event_type>.lua`<br>Or<br>`./services/<service_alias>_<event_type>.lua`

**Examples:**

- ./services/timer/timer.lua

```lua
print(request.timer_id)
```

- ./services/device2_event.lua

```lua
print(event.identity)
```

Find more informations regarding eventhandlers on the [Murano Scripting Reference](http://docs.exosite.com/articles/working-with-apis/#script-execution).

## Future

- Update examples to use `require`
- Once support is added to the platform for running an `init` script for the solution context we need at add support for it in the `murano.yml`
