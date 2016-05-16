implementation driver(){
call init_tar_model(); 


call SM2SM_matchAll();
call T2TC_matchAll();


call SM2SM_applyAll();
call T2TC_applyAll();





assert (

forall t:ref :: {read($tarHeap,t,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$Transition), t)
  ==> 
  genBy(t, _T2TC, $srcHeap, $tarHeap)
  ==>
  genBy(read($tarHeap, t, FSM$Transition.stateMachine), _SM2SM, $srcHeap, $tarHeap)
  ==> 
  read($tarHeap, t, FSM$Transition.stateMachine)!=null
) 
;


}




