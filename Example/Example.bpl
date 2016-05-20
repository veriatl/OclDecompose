
/*
 Example of verifying intermediate enumerated result
 */

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


// the following three assertion demonstrates the possibility of  verifying intermediate enumerated result.
// the 1st and 3rd are automatically verified, so that we do not need to enumerate their t.source.
// the 2nd fails to verify, so it needs to be further enumerated.

assert (
forall t:ref :: {read($tarHeap,t,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$Transition), t) ==>
     genBy(t, _T2TA, $srcHeap, $tarHeap) ==> 
       read($tarHeap, t, FSM$Transition.source)!=null 
) ;

assert (

forall t:ref :: {read($tarHeap,t,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$Transition), t) ==>
     genBy(t, _T2TB, $srcHeap, $tarHeap) ==> 
       read($tarHeap, t, FSM$Transition.source)!=null   
) ;

assert (
forall t:ref :: {read($tarHeap,t,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($tarHeap, FSM$Transition), t) ==>
     genBy(t, _T2TC, $srcHeap, $tarHeap) ==> 
       read($tarHeap, t, FSM$Transition.source)!=null 
) ;

}






  

