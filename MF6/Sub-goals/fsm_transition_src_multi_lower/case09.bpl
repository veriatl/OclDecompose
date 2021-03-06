implementation driver(){
var t: ref;
call init_tar_model();
call RS2RS_matchAll();
call T2TC_matchAll();
call RS2RS_applyAll();
call T2TC_applyAll();
assume genBy(t, _T2TC, $srcHeap, $tarHeap);
assume Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$AbstractState), read($tarHeap, t, FSM$Transition.source));
assume Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$Transition), t);
assume genBy(read($tarHeap, t, FSM$Transition.source), _RS2RS, $srcHeap, $tarHeap);
assume read($tarHeap, t, FSM$Transition.source) == null || !read($tarHeap, read($tarHeap, t, FSM$Transition.source), alloc);
assume genBy(read($tarHeap, t, FSM$Transition.source), _RS2RS, $srcHeap, $tarHeap) || genBy(read($tarHeap, t, FSM$Transition.source), _IS2IS, $srcHeap, $tarHeap) || genBy(read($tarHeap, t, FSM$Transition.source), _IS2RS, $srcHeap, $tarHeap);
assume genBy(t, _T2TA, $srcHeap, $tarHeap) || genBy(t, _T2TB, $srcHeap, $tarHeap) || genBy(t, _T2TC, $srcHeap, $tarHeap);
assert false;
}

