
if service.service == "sigfox" and service.action == "updated" then
  -- local parameters = Config.getParameters({service = "sigfox"})

  -- When Sigfox service configuration changes fetch new data
  -- Eg. if password change or else..
  Sigfox.muranoSync()
  -- Would not be needed if Sigfox uses x-exosite-init/x-exosite-update lifecycle events
end
