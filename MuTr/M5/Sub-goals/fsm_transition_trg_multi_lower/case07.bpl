implementation driver(){
call init_tar_model(); 




call IS2RS_matchAll();

call T2TB_matchAll();





call IS2RS_applyAll();

call T2TB_applyAll();



assert  
(

forall t:ref :: {read($tarHeap,t,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$Transition), t) ==>
    genBy(t, _T2TB, $srcHeap, $tarHeap) ==>
      (

      genBy(read($tarHeap, t, FSM$Transition.target), _IS2RS, $srcHeap, $tarHeap)  
      )
      ==>
     read($tarHeap, t, FSM$Transition.target)!=null
) 
;




}
