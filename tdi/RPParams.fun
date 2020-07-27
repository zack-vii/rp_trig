FUN PUBLIC RPParams(OPTIONAL OUT _times){
  _delay  = 0QU;
  _period = 0QU;
  _width  = 0QU;
  _burst  = 0QU;
  _cycle  = 0QU;
  _repeat = 0LU;
  _count  = 0LU;
  rp_trig_lib->getParams(ref(_delay),ref(_width),ref(_period),ref(_burst),ref(_cycle),ref(_repeat),ref(_count));
  IF(PRESENT(_times)) {
    _times = ZERO(_count,0QU);
    if (SIZE(_times)>0)
      rp_trig_lib->getTimes(val(0LU),val(SIZE(_times)),ref(_times));
  }
  return([_delay,_width,_period,_burst,_cycle,_repeat,_count]);
}
