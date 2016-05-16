procedure driver();
modifies $tarHeap, $linkHeap;
requires valid_src_model($srcHeap);
// 1
requires  
(

forall s1,s2:ref :: {read($srcHeap,s1,alloc),read($srcHeap,s2,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$StateMachine), s1) && Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$StateMachine), s2)
     ==> s1 != s2 ==> read($srcHeap, s1, HSM$StateMachine.name) != read($srcHeap, s2, HSM$StateMachine.name)
  
) 
;
// 2
requires  
(

forall s1,s2:ref :: {read($srcHeap,s1,alloc),read($srcHeap,s2,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$AbstractState), s1) && Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$AbstractState), s2)
     ==> s1 != s2 ==> read($srcHeap, s1, HSM$AbstractState.name) != read($srcHeap, s2, HSM$AbstractState.name)
  
) 
;
// 3
requires  
(

forall s:ref :: {read($srcHeap,s,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$AbstractState), s)
     ==> !((read($srcHeap, s, HSM$AbstractState.stateMachine)==null || !read($srcHeap,read($srcHeap, s, HSM$AbstractState.stateMachine),alloc)))
  
) 
;
// 4
requires  
(

forall s:ref :: {read($srcHeap,s,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$AbstractState), s)
     ==> 
(

forall sm1,sm2:ref :: {read($srcHeap,sm1,alloc),read($srcHeap,sm2,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$StateMachine), sm1) && Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$StateMachine), sm2)
     ==> read($srcHeap, s, HSM$AbstractState.stateMachine) == sm1 && read($srcHeap, s, HSM$AbstractState.stateMachine) == sm2 ==> sm1 == sm2
  
) 

  
) 
;
// 5
requires  
(

forall c1,c2:ref :: {read($srcHeap,c1,alloc),read($srcHeap,c2,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$AbstractState), c1) && Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$AbstractState), c2)
     ==> dtype(c1) == HSM$CompositeState && dtype(c2) == HSM$CompositeState ==> c1 == c2
  
) 
;
// 6
requires  
(

forall t:ref :: {read($srcHeap,t,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$Transition), t)
     ==> !((read($srcHeap, t, HSM$Transition.stateMachine)==null || !read($srcHeap,read($srcHeap, t, HSM$Transition.stateMachine),alloc)))
  
) 
;
// 7
requires  
(

forall t:ref :: {read($srcHeap,t,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$Transition), t)
     ==> 
(

forall sm1,sm2:ref :: {read($srcHeap,sm1,alloc),read($srcHeap,sm2,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$StateMachine), sm1) && Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$StateMachine), sm2)
     ==> read($srcHeap, t, HSM$Transition.stateMachine) == sm1 && read($srcHeap, t, HSM$Transition.stateMachine) == sm2 ==> sm1 == sm2
  
) 

  
) 
;
// 8
requires  
(

forall t:ref :: {read($srcHeap,t,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$Transition), t)
     ==> !((read($srcHeap, t, HSM$Transition.source)==null || !read($srcHeap,read($srcHeap, t, HSM$Transition.source),alloc)))
  
) 
;
// 9
requires  
(

forall t:ref :: {read($srcHeap,t,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$Transition), t)
     ==> 
(

forall s1,s2:ref :: {read($srcHeap,s1,alloc),read($srcHeap,s2,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$AbstractState), s1) && Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$AbstractState), s2)
     ==> read($srcHeap, t, HSM$Transition.source) == s1 && read($srcHeap, t, HSM$Transition.source) == s2 ==> s1 == s2
  
) 

  
) 
;

// 11
requires  
(

forall t:ref :: {read($srcHeap,t,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$Transition), t)
     ==> 
(

forall s1,s2:ref :: {read($srcHeap,s1,alloc),read($srcHeap,s2,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$AbstractState), s1) && Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$AbstractState), s2)
     ==> read($srcHeap, t, HSM$Transition.target) == s1 && read($srcHeap, t, HSM$Transition.target) == s2 ==> s1 == s2
  
) 

  
) 
;
// 12
requires  
(

forall t:ref :: {read($srcHeap,t,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$Transition), t)
     ==> 
(

forall s:ref :: {read($srcHeap,s,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$AbstractState), s)
     ==> read($srcHeap, t, HSM$Transition.source) == s ==> 
(

forall sm1,sm2:ref :: {read($srcHeap,sm1,alloc),read($srcHeap,sm2,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$StateMachine), sm1) && Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$StateMachine), sm2)
     ==> read($srcHeap, t, HSM$Transition.stateMachine) == sm1 && read($srcHeap, s, HSM$AbstractState.stateMachine) == sm2 ==> sm1 == sm2
  
) 

  
) 

  
) 
;
// 13
requires  
(

forall t:ref :: {read($srcHeap,t,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$Transition), t)
     ==> 
(

forall s:ref :: {read($srcHeap,s,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$AbstractState), s)
     ==> read($srcHeap, t, HSM$Transition.target) == s ==> 
(

forall sm1,sm2:ref :: {read($srcHeap,sm1,alloc),read($srcHeap,sm2,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$StateMachine), sm1) && Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$StateMachine), sm2)
     ==> read($srcHeap, t, HSM$Transition.stateMachine) == sm1 && read($srcHeap, s, HSM$AbstractState.stateMachine) == sm2 ==> sm1 == sm2
  
) 

  
) 

  
) 
;
// 14
requires  
(

forall t:ref :: {read($srcHeap,t,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$Transition), t)
     ==> 
(

forall s1,s2:ref :: {read($srcHeap,s1,alloc),read($srcHeap,s2,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$AbstractState), s1) && Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$AbstractState), s2)
     ==> read($srcHeap, t, HSM$Transition.source) == s1 && read($srcHeap, t, HSM$Transition.target) == s2 ==> 
(

forall sm1,sm2:ref :: {read($srcHeap,sm1,alloc),read($srcHeap,sm2,alloc)}
  Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$StateMachine), sm1) && Seq#Contains(Fun#LIB#AllInstanceFrom($srcHeap, HSM$StateMachine), sm2)
     ==> read($srcHeap, s1, HSM$AbstractState.stateMachine) == sm1 && read($srcHeap, s2, HSM$AbstractState.stateMachine) == sm2 ==> sm1 == sm2
  
) 

  
) 

  
) 
;





























