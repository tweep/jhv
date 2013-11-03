
## Some usefil git commands:

## Git workflow is different than the svn/cvs one: 

 * add a file to git:  

   git add <FILE>  

 * show the status of a file  
   : git status <FILE>

 * commit a file to git   
   : git commit <FILE>  

 * **or** do all in one command wit the **commit -a** option:   
   : git commit -a -m 'added new benchmarks' 


 * use **gitk** to show the **git log** history   

 * **avoid** to always type your password:   
   GitHub's help also suggests that if you're on Mac OS and used homebrew to install git, you can use the native Mac OS keystore with:  

   git config --global credential.helper osxkeychain 


