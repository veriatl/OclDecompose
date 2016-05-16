implementation driver(){
call init_tar_model(); 


call SM2SM_matchAll();

call SM2SM_applyAll();


assert (

forall s1: ref :: {read($tarHeap,s1,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$StateMachine), s1) ==>
  !genBy(s1, _SM2SM, $srcHeap, $tarHeap) ==>
  (forall s2: ref ::  {read($tarHeap,s2,alloc)}
     Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$StateMachine), s2) ==>
     !genBy(s2, _SM2SM, $srcHeap, $tarHeap) ==>
       s1 != s2 ==> read($tarHeap, s1, FSM$StateMachine.name) != read($tarHeap, s2, FSM$StateMachine.name)
  )
) 
;


}




