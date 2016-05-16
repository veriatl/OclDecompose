implementation driver(){
call init_tar_model(); 
call T2TC_matchAll()
call IS2IS_matchAll()
call RS2RS_matchAll()
call IS2RS_matchAll()
call T2TC_applyAll()
call IS2IS_applyAll()
call RS2RS_applyAll()
call IS2RS_applyAll()
assert ( forall t:ref :: {read($tarHeap,t,alloc)}Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$Transition), t) ==> (genBy(t, _T2TC, $srcHeap, $tarHeap)) ==> (forall s1:ref :: {read($tarHeap,s1,alloc)}Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$AbstractState), s1) ==> (genBy(s1, _IS2IS, $srcHeap, $tarHeap)) ==> (forall s2:ref :: {read($tarHeap,s2,alloc)}Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$AbstractState), s2) ==> ((!genBy(s2, _RS2RS, $srcHeap, $tarHeap) && !genBy(s2, _IS2IS, $srcHeap, $tarHeap) && !genBy(s2, _IS2RS, $srcHeap, $tarHeap))) ==> (genBy(read($tarHeap, t, FSM$Transition.source), _IS2IS, $srcHeap, $tarHeap)) ==>read($tarHeap, t, FSM$Transition.source) == s1 && read($tarHeap, t, FSM$Transition.source) == s2 ==> s1 == s2)));
}

