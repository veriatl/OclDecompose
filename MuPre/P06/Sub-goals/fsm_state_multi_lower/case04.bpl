implementation driver(){
call init_tar_model(); 



call SM2SM_matchAll();
call RS2RS_matchAll();
call IS2IS_matchAll();
call IS2RS_matchAll();




call SM2SM_applyAll();
call RS2RS_applyAll();
call IS2IS_applyAll();
call IS2RS_applyAll();



assert (

forall s:ref :: {read($tarHeap,s,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$AbstractState), s)
     ==> 
     (
      !genBy(s, _RS2RS, $srcHeap, $tarHeap) &&
      !genBy(s, _IS2IS, $srcHeap, $tarHeap) &&
      !genBy(s, _IS2RS, $srcHeap, $tarHeap)
     )
     ==>
     genBy(read($tarHeap, s, FSM$AbstractState.stateMachine), _SM2SM, $srcHeap, $tarHeap)
     ==>
     read($tarHeap, s, FSM$AbstractState.stateMachine)!=null
  
) 
;


}




