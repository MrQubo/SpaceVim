" Only do this when not done yet for this buffer.
if exists("b:did_ftplugin")
  finish
endif

call region#buffer_init(function('region#rsl_dq_we'))
