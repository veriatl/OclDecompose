A deductive approach for fault localization in ATL model transformations (Online)
=======

Introduction
------
In model-driven engineering, correct model transformation is essential for reliably producing the artefacts that drive software development. While correctness of model transformation can be specified and checked via contracts, existing approaches do not help to find the precise location of faults that cause the verification failure. We present a fault localization approach, based on natural deduction, for the ATL model transformation language. We start by designing sound natural deduction rules for the ATL language. Then, we propose an automated proof strategy that applies the designed deduction rules on the input OCL postcondition to generate sub-goals: successfully proving the sub-goals implies the satisfaction of the input OCL postcondition. When a sub-goal is not verified, we present the user with sliced ATL model transformation and predicates deduced from the input postcondition as debugging clues. The goal is to alleviate the cognitive loading of debugging unverified sub-goals. We present here the artefects used in the evaluation for our fault localization approach.

Impacts
------
Our evaluation observes three items that would impact fault localization for ATL transformations:
* The guilty construct(s) is presented in the slice. 
* Deduced clues assist developers in various debugging tasks (e.g. generate counter-example). 
* The number of sub-goals that need to be examined to pinpoint a fault are usually small.

Video
------
Interest in VeriATL, but do not have time to install? Worry not! Quick demo of VeriATL on youtube:

[![Click to watch](https://www.youtube.com/yt/brand/media/image/YouTube-logo-full_color.png)](https://youtu.be/rUPLvDHEXiY)

How to run
------
Preparation:
* Download VeriATL [Clone url](https://github.com/veriatl/Compiler.VeriATL.git)
* Download OCLDecomposer [Clone url](https://github.com/veriatl/genTool.git)
* Execute ant script to generate Boogie code. Type "ant help" to see what are the available options.



Evaluation
------
To help reproducing the evaluation result, the following artefacts are generated:
* HSM2FSM / AF2 / AR / DB1 / DR1 / MB6 / MF6 / MT2. Each of these folders contains all the Boogie code to verify each postcondition and localize its fault for a given project (Generated from the previous steps). Within each folder, we have three kinds of artefacts:
  * Auxu. The corresponding Boogie code of the case study.
  * Sub-goals. The Boogie code of the sub-goals / original postcondition.
  * Source. The source code for metamodels, model transformations, contracts and etc.
* Prelude. The core Boogie libraries for the VeriATL verification system.
* Exec. *Run this python script to reproduce the evaluation results.*
* Result. the evaluation results of the orignal and mutated HSM2FSM case study in text format.


Requirements
------
The following tools are needed to reproduce the result of the HSM2FSM case study:
* Python 3.0+
* Boogie 2.2+
* Z3 4.3+
* Java 6+

Contacts
------
> Zheng Cheng: zheng.cheng@inria.fr

> Massimo Tisi: massimo.tisi@inria.fr

Collaborators
------
* Rosemary Monahan, Maynooth Univerisity, IE
* James F. Power, Maynooth Univerisity, IE