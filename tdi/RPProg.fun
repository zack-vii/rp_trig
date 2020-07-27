FUN PUBLIC RPProg(optional in _delay, optional in _width, optional in _period, optional in _burst, optional in _cycle, optional in _repeat, optional in _times){
  _delay  = IF_ERROR(KIND(_delay )>0,0BU) ? QUADWORD_UNSIGNED(_delay) : *;
  _period = IF_ERROR(KIND(_period)>0,0BU) ? QUADWORD_UNSIGNED(_period): *;
  _width  = IF_ERROR(KIND(_width )>0,0BU) ? QUADWORD_UNSIGNED(_width) : *;
  _burst  = IF_ERROR(KIND(_burst )>0,0BU) ? QUADWORD_UNSIGNED(_burst) : *;
  _cycle  = IF_ERROR(KIND(_cycle )>0,0BU) ? QUADWORD_UNSIGNED(_cycle) : *;
  _repeat = IF_ERROR(KIND(_repeat)>0,0BU) ?     LONG_UNSIGNED(_repeat): *;
  IF(IF_ERROR(NDIMS(_times)>0,0BU)) {
/* make sequence */
    _count  = LONG_UNSIGNED(SIZE(_times));
    _times  = QUADWORD_UNSIGNED(_times);
    return(rp_trig_lib->makeSequence(ref(_delay),ref(_width),ref(_period),ref(_burst),ref(_cycle),ref(_repeat),ref(_count),ref(_times)));
  } ELSE {
/* make clock */
    return(rp_trig_lib->makeClock(ref(_delay),ref(_width),ref(_period),ref(_burst),ref(_cycle),ref(_repeat)));
  }   
}
