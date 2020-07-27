FUN PUBLIC RPReInit(optional in _delay){
  _delay = IF_ERROR(KIND(_delay)>0, 0BU) ? QUADWORD_UNSIGNED(_delay) : *;
  return(rp_trig_lib->reinit(ref(_delay)));
}
