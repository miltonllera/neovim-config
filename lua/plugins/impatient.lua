local status, impatient = pcall(require, "impatient")
if (not status) then return end

impatient.enable_profile()