# biomotion-priming
COGS119 Project


##Getting started with git 

Great! We have a git repo! 
A typical worksession with git is usually like this:

-> Go to command window -> find the biomotion-priming folder.
-> Choose desired branch using git checkout <branch-name> (I'll come back to branches later)
-> Pulling (get the latest version from the remote repo) the branch using git pull. You now have the lates version of the code on your local machine.
-> Writing awesome MATLAB code. 
-> When done with some piece of awesome code, we want to commit it and push it to the remote repo so everyone can see all the awesome stuff you have implemented. It's better to commit too often than not at all. To commit and push the code to remote, foolw these steps:

0. git status - writes out a nice summary of the state of git. Check you're in the correct branch.
1. git add <file-name>  - to add the files you've been working on something called the stage. The files you add are the ones you will commit.
  
  -> git add * -  adds all changed files to the stage
2. git commit -m "A short message that describes what you have done for the others to see." This "commits" the changes locally. Finally we push these changes to the remote:
3. git push   This updates the remote repo to include your awesome changes! If you have created a new branch, you need to write:
  git push -u origin/<name_of_your_branch>    This tells git to create the same branch in the remote repo.
  
And that's it! As long as everything goes fine. But what if someone else updated the remote repo before i pushed my changes, and we have been working on the same file? Git wont know which file is the 'correct' one, and we get what is called a merge conflict. Ine way to try and avoid this, is to use branches. A branch is like a separate version of our code where you can write and change everything you want without affecting the rest of the group. It is a good idea to create a new branch when you want to start on a new feature, for example the analysis.

Lets say I started working on analysis.m. I create a branch called analysis (or whatever). Then Devon wants to work on analysis as well. She can create a new branch called analysis-devon and work there. Now we wont get conflicts even though we are both editing the same file. In the end, we merge the branches back together choosing the best from both.

To see all branches you have locally:
git branch
To get all branches that have been created by someone else in the remote repo down to your local:
git fetch
To switch to an existing branch:
git checkout <branch_name>
To create and switch to a new branch:
git checkout <new_branch_name>

Lets git started! (sry)
