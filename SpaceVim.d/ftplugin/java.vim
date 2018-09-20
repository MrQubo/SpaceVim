" Only do this when not done yet for this buffer.
if exists("b:did_ftplugin")
  finish
endif

call region#buffer_init(function('region#rsl_dq_we'))

if exists("g:loaded_local_ftplugin_java") || &cp
  finish
endif
let g:loaded_local_ftplugin_java = 1

let g:JavaComplete_ImportSortType = 'packageName'
let g:JavaComplete_ImportOrder = ['java.', 'javax.', 'com.', 'io.reactivex.', 'io.vertx.', 'io.', 'net.', 'org.apache.', 'org.slf4j.', 'org.', 'lombok.', '*', 'static ']
