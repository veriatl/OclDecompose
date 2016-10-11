Fault localization for ATL model transformations using natural deduction and program slicing (Online)
=======

Introduction
------
In model-driven engineering, correct model transformation is essential for reliably producing the artefacts that drive software development. While correctness of model transformation can be specified and checked via contracts, existing approaches do not help to find the precise location of faults that cause the verification failure. We present a fault localization approach, based on natural deduction, for the ATL model transformation language. We start by designing sound natural deduction rules for the ATL language. Then, we propose an automated proof strategy that applies the designed deduction rules on the input OCL postcondition to generate sub-goals: successfully proving the sub-goals implies the satisfaction of the input OCL postcondition. When a sub-goal is not verified, we present the user with sliced ATL model transformation and predicates deduced from the input postcondition as debugging clues. The goal is to alleviate the cognitive loading of debugging unverified sub-goals.  We present here the artefects used in the evaluation for our fault localization approach.


How to run
------
Preparation:
0. Download VeriATL [Clone url](https://github.com/veriatl/Compiler.VeriATL.git)
1. Download OCLDecomposer [Clone url](https://github.com/veriatl/genTool.git)

Run VeriATL (ie.nuim.cs.veriatl.compiler) to generate Boogie code to verify the original postcondition:
2. Configure VeriATL (i.e. "veriATL.conf" under "ie.nuim.cs.veriatl.compiler") to specify which project to be verified.
3. Run VeriATL ("xpandExec" under "cs.nuim.ie.workflowRunner" package) first to generate a skeleton for the to-be-verified project. 
3. Copy the artefects into the generated skeleton (e.g. ATL transformation goes to the ATLSRC folder), see [HERE]() for example of structuring the project skeleton.
4. Run VeriATL ("xpandExec" under "cs.nuim.ie.workflowRunner") again, will generate Boogie code to verify the original postcondition.

Run OCLDecomposer (fr.emn.atlanmod.ocldecomposer) to generate sub-goals and Boogie code of sub-goals to localize the fault:
5. Run OCLDecomposer ("ocldecomposerDriver" under "driver" package), the sample args to run it is given at "sampleConf.txt"

At this point, all the Boogie code to verify each postcondition and localize its fault for the given project are generated.


Evaluation
------
First, let us understand the artefects that relevant to reproduce the evaluation result:
- HSM2FSM / AF2 / AR / DB1 / DR1 / MB6 / MF6 / MT2. Each of these folders contains all the Boogie code to verify each postcondition and localize its fault for a given project (Generated from the previous steps). Within each folder, we have three kinds of artefacts:
  * Auxu. The corresponding Boogie code of the case study.
  * Sub-goals. The Boogie code of the sub-goals / original postcondition.
  * Source. The source code for metamodels, model transformations, contracts and etc.
- Prelude. The core Boogie libraries for the VeriATL verification system.
- Exec. python script to reproduce the evaluation results.
- Result. the evaluation results of the orignal and mutated HSM2FSM case study in text format.


Requirements
------
The following tools are needed to reproduce the result of the HSM2FSM case study:
- Python 3.0+
- Boogie 2.2+
- Z3 4.3+
- Java 6+

Contacts
------
[Zheng Cheng](zheng.cheng@inria.fr)
[Massimo Tisi](massimo.tisi@inria.fr)

