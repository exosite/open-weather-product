
-- This part is needed as schedule settings from Timer service are not working
-- This can be removed once MUR-10927 is released
Timer.sendInterval({timer_id="hourly-sync", duration=3600 * 1000})
