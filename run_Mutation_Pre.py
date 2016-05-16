import subprocess
from os import walk
import sys
from datetime import datetime
import time

# global settings start
# VERIFICATION OPTION ON PROJECTS
_OPT_VERIFICATION = 1		# CORRECTNESS VERIFICATION
_OPT_VALIDATION = 2			# TRANSLATION VALIDITON
_OPT_VERIFICATION_ORG = 3	# CORRECTNESS VERIFICATION FOR ORIGINAL POSTCONDITION

LibsPath = "Prelude/"		# imported library path
mmPath = "Auxu/"		# imported mm path

taskPath = ""
taskPaths = [
"/Sub-goals/fsm_state_multi_lower/",
"/Sub-goals/fsm_transition_multi_lower/",
"/Sub-goals/fsm_transition_trg_multi_lower/",
"/Sub-goals/unique_fsm_sm_names/",
"/Sub-goals/unique_fsm_state_names/",
"/Sub-goals/fsm_transition_src_multi_upper/"	# new postcondition
]



# PROJ PATH


Proj1 = "MuPre/P01/"			# task 2
Proj2 = "MuPre/P02/"			# task 2
Proj3 = "MuPre/P03/"			# task 2
Proj4 = "MuPre/P04/"			# task 2
Proj5 = "MuPre/P05/"			# task 2
Proj6 = "MuPre/P06/"			# task 2
Proj7 = "MuPre/P07/"			# task 2
Proj8 = "MuPre/P08/"			# task 2
Proj9 = "MuPre/P09/"			# task 2
Proj10 = "MuPre/P10/"			# task 2
Proj11 = "MuPre/P11/"			# task 2
Proj12 = "MuPre/P12/"			# task 2
Proj13 = "MuPre/P13/"			# task 2
Proj14 = "MuPre/P14/"			# task 2




# PROJ TO VERIFY
Projs = [
Proj1,
Proj2,
Proj3,
Proj4,
Proj5,
Proj6,
Proj7,
Proj8,
Proj9,
Proj10,
Proj11,
Proj12,
Proj13,
Proj14
]	

# WHAT OPTION TO VERIFY EACH PROJ
Projs_option_map = { 
Proj1: { _OPT_VERIFICATION_ORG},
Proj2: { _OPT_VERIFICATION_ORG},
Proj3: { _OPT_VERIFICATION_ORG},
Proj4: { _OPT_VERIFICATION_ORG},
Proj5: { _OPT_VERIFICATION_ORG},
Proj6: { _OPT_VERIFICATION_ORG},
Proj7: { _OPT_VERIFICATION_ORG},
Proj8: { _OPT_VERIFICATION_ORG},
Proj9: { _OPT_VERIFICATION_ORG},
Proj10: { _OPT_VERIFICATION_ORG},
Proj11: { _OPT_VERIFICATION_ORG},
Proj12: { _OPT_VERIFICATION_ORG},
Proj13: { _OPT_VERIFICATION_ORG},
Proj14: { _OPT_VERIFICATION_ORG}
}

# BOOGIE ARGS


# global settings end

# forge the cmd that executes Boogie, depending on the [option] that pass in, which stores at task_option_map.
def forgeRunningCommand(projPath, taskName, option):
	command = []

	command.append("boogie")					# command
	

	
	
	
	for libName in loadFiles(LibsPath):
		command.append(LibsPath+libName)		# importing library

	for fN in loadFiles(projPath+mmPath):
		command.append(projPath+mmPath+fN)				# import metamodel related Boogie code


	
	if taskName.startswith("case") and option == _OPT_VERIFICATION:
		command.append(projPath+taskPath+taskName)	# input
	elif taskName.startswith("or") and option == _OPT_VERIFICATION_ORG:
		command.append(projPath+taskPath+taskName)
	else:
		command = []
	
	return command


	
def loadFiles(path):
	
	f = []
	for (dirpath, dirnames, filenames) in walk(path):
		f.extend(filenames)
		break
	
	return f



def BatchTest(isDetailed):

	sum = 0;
	
	global taskPath
	for proj in Projs:
		sum = 0;
		for opt in Projs_option_map[proj]:
			
			for tp in taskPaths:
				taskPath = tp
				tasks = loadFiles(proj+taskPath)	
				
				for task in tasks:
					myCmd = forgeRunningCommand(proj, task, opt)
					
					if myCmd != []:
						start = time.time()
						p = subprocess.Popen(myCmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE) 
						p.wait()
						done = time.time()
						out, err = p.communicate()

						elapsed = done - start
						sum+=elapsed
						
						if(str(out).find(", 0 errors") == -1):
							print("[%s]:[%s]:[%s]:[%s]:%s:%s" % (proj, tp, task, opt, "unverified", str(elapsed)))
							sys.stdout.flush()
							tSub = 0
							for task in tasks:
								myCmd = forgeRunningCommand(proj, task, _OPT_VERIFICATION)
					
								if myCmd != []:
									startSub = time.time()
									p = subprocess.Popen(myCmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE) 
									p.wait()
									doneSub = time.time()
									out, err = p.communicate()

									elapsedSub = doneSub - startSub
									tSub+=elapsedSub
									
									if(str(out).find(", 0 errors") == -1):
										print("\t[%s]:[%s]:[%s]:[%s]:%s:%s" % (proj, tp, task, opt, "unverified", str(elapsedSub)))
										sys.stdout.flush()
									else:
										print("\t[%s]:[%s]:[%s]:[%s]:%s:%s" % (proj, tp, task, opt, "verified", str(elapsedSub)))
										sys.stdout.flush()
							sum+=tSub
							print("\t"+str(tSub))
							
										
						else:
							print("[%s]:[%s]:[%s]:[%s]:%s:%s" % (proj, tp, task, opt, "verified", str(elapsed)))
							sys.stdout.flush()
				
					
			print(sum)
	


	
def main():
	i = datetime.now()
	
	BatchTest(True)
	
	
	

if __name__ == "__main__":
    main()
	
	
