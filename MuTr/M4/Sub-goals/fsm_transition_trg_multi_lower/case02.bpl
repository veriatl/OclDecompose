implementation driver(){
call init_tar_model(); 


call IS2IS_matchAll();
call T2TA_matchAll();


call IS2IS_applyAll();
call T2TA_applyAll();


assert (forall t:ref :: {read($tarHeap,t,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$Transition), t) ==>   
    genBy(t, _T2TA, $srcHeap, $tarHeap)
     ==> 
    genBy(read($tarHeap, t, FSM$Transition.target), _IS2IS, $srcHeap, $tarHeap) 
     ==>
     read($tarHeap, t, FSM$Transition.target)!=null
    
) ;


}




