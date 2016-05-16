implementation driver(){
call init_tar_model(); 

call SM2SM_matchAll();
call RS2RS_matchAll();
call IS2IS_matchAll();
call IS2RS_matchAll();
call T2TA_matchAll();
call T2TB_matchAll();
call T2TC_matchAll();

call SM2SM_applyAll();
call RS2RS_applyAll();
call IS2IS_applyAll();
call IS2RS_applyAll();
call T2TA_applyAll();
call T2TB_applyAll();
call T2TC_applyAll();

assert (

forall t:ref :: {read($tarHeap,t,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$Transition), t)
     ==> 
(

forall s1,s2:ref :: {read($tarHeap,s1,alloc),read($tarHeap,s2,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$AbstractState), s1) && Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$AbstractState), s2)
     ==> read($tarHeap, t, FSM$Transition.source) == s1 && read($tarHeap, t, FSM$Transition.source) == s2 ==> s1 == s2
  
) 

  
) 
;

}
