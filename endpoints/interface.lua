-- WARNING: Do not modify, changes will not persist updates
-- You can safely add new endpoints under /vendor/*

--#ENDPOINT POST /interface/v1/getIdentity
--#SECURITY basic
--#TAGS interface
local r = require("pdaas.lib.router")
local a = require("pdaas.apps")
local h = require("pdaas.lib.helper")
local i = require("pdaas.interface")
local operation = request.body

r:start(request):run(
    function(r)
        return r.headers.authorization
    end
):run(h.appTokenParser):run(
    function(r)
        return a.verifySecret(r.app_id, r.secret)
    end
):run(
    function(r)
        return i.getIdentity(r.app_id, operation)
    end
):response(response)

--#ENDPOINT POST /interface/v1/getIdentityState
--#SECURITY basic
--#TAGS interface
local r = require("pdaas.lib.router")
local a = require("pdaas.apps")
local h = require("pdaas.lib.helper")
local i = require("pdaas.interface")
local operation = request.body

r:start(request):run(
    function(r)
        return r.headers.authorization
    end
):run(h.appTokenParser):run(
    function(r)
        return a.verifySecret(r.app_id, r.secret)
    end
):run(
    function(r)
        return i.getIdentityState(r.app_id, operation)
    end
):response(response)

--#ENDPOINT POST /interface/v1/claimDevices
--#SECURITY basic
--#TAGS interface
local r = require("pdaas.lib.router")
local a = require("pdaas.apps")
local h = require("pdaas.lib.helper")
local i = require("pdaas.interface")
local operation = request.body

r:start(request):run(
    function(r)
        return r.headers.authorization
    end
):run(h.appTokenParser):run(
    function(r)
        return a.verifySecret(r.app_id, r.secret)
    end
):run(
    function(r)
        return i.claimDevices(r.app_id, operation)
    end
):response(response)

--#ENDPOINT POST /interface/v1/getTempClaimURL
--#SECURITY basic
--#TAGS interface
local r = require("pdaas.lib.router")
local a = require("pdaas.apps")
local h = require("pdaas.lib.helper")
local i = require("pdaas.interface")
local operation = request.body

r:start(request):run(
    function(r)
        return r.headers.authorization
    end
):run(h.appTokenParser):run(
    function(r)
        return a.verifySecret(r.app_id, r.secret)
    end
):run(
    function(r)
        return i.getTempClaimURL(r.app_id, operation)
    end
):response(response)

--#ENDPOINT POST /interface/v1/listIdentities
--#SECURITY basic
--#TAGS interface
local r = require("pdaas.lib.router")
local a = require("pdaas.apps")
local h = require("pdaas.lib.helper")
local i = require("pdaas.interface")
local operation = request.body

r:start(request):run(
    function(r)
        return r.headers.authorization
    end
):run(h.appTokenParser):run(
    function(r)
        return a.verifySecret(r.app_id, r.secret)
    end
):run(
    function(r)
        return i.listIdentities(r.app_id, operation)
    end
):response(response)

--#ENDPOINT POST /interface/v1/setIdentityState
--#SECURITY basic
--#TAGS interface
local r = require("pdaas.lib.router")
local a = require("pdaas.apps")
local h = require("pdaas.lib.helper")
local i = require("pdaas.interface")
local operation = request.body

r:start(request):run(
    function(r)
        return r.headers.authorization
    end
):run(h.appTokenParser):run(
    function(r)
        return a.verifySecret(r.app_id, r.secret)
    end
):run(
    function(r)
        return i.setIdentityState(r.app_id, operation)
    end
):response(response)

--#ENDPOINT POST /interface/v1/setContext
--#SECURITY basic
--#TAGS interface
local r = require("pdaas.lib.router")
local a = require("pdaas.apps")
local h = require("pdaas.lib.helper")
local i = require("pdaas.interface")
local operation = request.body

r:start(request):run(
    function(r)
        return r.headers.authorization
    end
):run(h.appTokenParser):run(
    function(r)
        return a.verifySecret(r.app_id, r.secret)
    end
):run(
    function(r)
        return i.setContext(r.app_id, operation)
    end
):response(response)

--#ENDPOINT POST /interface/v1/getContext
--#SECURITY basic
--#TAGS interface
local r = require("pdaas.lib.router")
local a = require("pdaas.apps")
local h = require("pdaas.lib.helper")
local i = require("pdaas.interface")
local operation = request.body

r:start(request):run(
    function(r)
        return r.headers.authorization
    end
):run(h.appTokenParser):run(
    function(r)
        return a.verifySecret(r.app_id, r.secret)
    end
):run(
    function(r)
        return i.getContext(r.app_id, operation)
    end
):response(response)
