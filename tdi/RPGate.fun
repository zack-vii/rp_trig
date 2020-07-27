FUN PUBLIC RPGate(IN _list){
  _byte = 0BU;
  for(_i=0;_i<size(_list);_i++) _byte = IOR(_byte,4<<_list[_i]);
  return(rp_trig_lib->gate(val(_byte)));
}
