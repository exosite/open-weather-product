# Getting Started Solution Template

This page describes the project structure used to set and update a Murano Solution. Murano templates can be used in two distinct ways:
- To synchronize an existing Murano solution with a local project folder using the [Murano-CLI](http://docs.exosite.com/development/tools/murano-cli/).
- To publish it as template element on the Murano Exchange marketplace to make it available from other Murano businesses. In such case the source code and repo is obfuscated for the template users. Learn more about [Murano Exchange here](http://docs.exosite.com/reference/ui/exchange/authoring-elements-guide.md).

## Template directories structure

```
getting-started-solution-template/
├── assets/index.html
├── endpoints/example.lua
├── modules/example.lua
├── services/<service_event>.lua | <service>.yaml
├── init.lua
└── murano.yaml
```

## Template format [murano.yaml](./murano.yaml)

**murano.yaml** is the only required component of a template and defines the solution resources.

### Required sections for the template

Section name  | Format | Example                                  | Description
--------------|--------|------------------------------------------|----------------------------------
formatversion | string | `formatversion: 1.0.0`                   | The format version of this file. Must be "1.0.0".
info          | object | [See in the info section](#info-section) | Metadata about this project.

### Optional sections for the template

Following sections are optional and their order is not enforced. If not specified related source files will be ignored. The different section sub-items are themself optional and default values are provided.

Section name | Format | Example                                            | Description
-------------|--------|----------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
assets       | object | [See in the assets section](#assets-section)       | Target source files of the front-end Web application.
endpoints    | object | [See in the endpoints section](#endpoints-section) | Target source files of the webservice back-end endpoints.
modules      | object | [See in the modules section](#modules-section)     | Target reusable module source files.
services     | object | [See in the services section](#services-section)   | Target source files of internal services event handlers.
init_script  | string | [`./init.lua`](init.lua)                           | Relative Path of the solution initialization script file.<br>This script will be executed once at the end of the template setup and allow to initialize the solution configuration and data.<br>The file must contain valid lua script and may includes calls to other Lua Modules.

#### Info section

This section contains meta-information relative to the project.

```yaml
info:
  name: <template_name>
  summary: One line summary of <template_name>
  description: |
    In depth description of <template_name>
    With lots of details.
  authors: ['Someone <b@someone.com> (http://someone.tumblr.com/)']
  version: 1.0.0
```

Fieldname   | Format                                                                                        | Example                                                    | Description
------------|-----------------------------------------------------------------------------------------------|------------------------------------------------------------|-----------------------------------------------------------------------------------------
name        | string (`/^[\s-]+$/`)                                                                         | `myTemplate`                                               | Nice short and easy. This is the template name which do not relate to the solution name.
summary     | string                                                                                        | `One line summary of template`                             | Short one line summary of this template.
description | string                                                                                        | `In depth description of template with lots of details.`   | Longer, multiple paragraph explanation.
authors     | List of string in format:<br>`'Full name <email.com> (link)'`<br>Each elements being optional | `['Someone <b@someone.com> (http://someone.tumblr.com/)']` | Who made this project.
version     | string                                                                                        | `1.0.0 `                                                   | The version of the project.

#### Assets section

This section declares static files (Such as front-end javascript code and images) served by the Solution public API powered by the [Asset service](http://docs.exosite.com/reference/services/asset/).

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

This section declares the different endpoint and backend logic for the solution public API powered by the [Webservice service](http://docs.exosite.com/reference/services/webservice/).

```yaml
endpoints:
  location: endpoints
  include: '**/*.lua'
  exclude: ['*_test.lua', '*_spec.lua']
  cors: {'origin': ['http://localhost:*']}
```

Fieldname | Format      | Example                              | Description                                                                                                                          | Default value
----------|-------------|--------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|--------------
location  | string      | `endpoints`                          | Root folder name containing the files.                                                                                               | `endpoints`
include   | string/list | `'**/*.lua'`                         | Pattern (or list of patterns) to select files in the location directory.<br>The pattern search is relative to the `location` folder. | `'**/*.lua'`
exclude   | list        | `['*_test.lua', '*_spec.lua']`       | Pattern allowing to ignore files from the selection.                                                                                 | `[]`
cors      | object      | `{'origin': ['http://localhost:*']}` | Cross origin resource sharing permission setting.                                                                                    | `{}`

##### File content

Selected files need to contains valid Lua script. Endpoints are defined using a Lua comment header as follows (The file name is not relevant):

```lua
--#ENDPOINT <method> <path>[ <content_type>]
-- Custom logic goes here
```

The `content_type` is optional and `application/json` is the default value.

**Example: [./endpoints/example.lua](./endpoints/example.lua)**

```lua
--#ENDPOINT POST /api/user
print("Creating a new user")

--#ENDPOINT GET /api/user/{userId}
print("Fetch a given user" .. request.parameters.userId)
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

Selected file needs to contain valid Lua script and should be structured as standard Lua modules (http://lua-users.org/wiki/ModulesTutorial).

**Important notes & best practices:**
- All variables & functions should be tagged as *local*.
- The trailing *return* statement is required.
- To avoid confusion with Murano Services, module file name should start with a lower-case letter.
- The module file relative path matters.
- As convention name your module object after the module name.

Find more information regarding modules on the [Murano Scripting Reference](http://docs.exosite.com/articles/working-with-apis/#modules).

**Example: [./modules/src/utils.lua](./modules/src/utils.lua)**

```lua
local utils = { variable = "World"}
function utils.hello()
  return utils.variable
end
return utils
```

Can be accessed in event handlers or other modules using the file full path inside the modules folder:

```lua
require("src.utils").hello() -- -> "World"
```

#### Services section

Section defines Services configuration and related scripting logic for the Solution.
Services defined with below section will get configured for the solution.

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

##### _.lua_ Event logic files content

Selected file needs to contain valid Lua scripts used for service event handlers logic. Scripts are triggered when the relevant Murano event occurs.
The service and event can be defined using the following Lua comment to define multiple event handlers in a single file:

```lua
--#EVENT <service_alias> <event_type>
-- Custom logic goes here
```

**Example: [./services/yyy/xxx.lua](./services/yyy/xxx.lua)**

```lua
--#EVENT user account
print(event.email)

--#EVENT timer timer
print(request.message)
```

If the EVENT tag is missing the file structure is used to represent the service and event as follows.<br>`./services/<service_alias>_<event_type>.lua`

**Examples: [./services/user_account.lua](./services/user_account.lua)**

```lua
print(event.email)
```

Find more information regarding eventhandlers on the [Murano Scripting Reference](http://docs.exosite.com/articles/working-with-apis/#script-execution).

##### _.yaml_ Service configuration files content

Specific configuration parameters can be defined per service using _<service_alias>.yaml_ files in the defined location directory.

Content of the files needs to match the target service configuration parameters.

**Examples: [./services/device2.yaml](./services/device2.yaml)**

```lua
protocol:
  name: onep
provisioning:
  auth_type: token
```

This method can also be used with an empty file to configured service which doesn't have any script logic or specific configuration parameters.
Example: [./services/twilio.yaml](./services/twilio.yaml).
