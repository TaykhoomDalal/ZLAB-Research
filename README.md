# Collaborators: Taykhoom Dalal, Giorgia Nicolaou, Defne Ercelen

Instructions to set up access to github:
Setting Up github on Hoffman:
On login: 
1. mkdir [insert_project_name]
2. cd [project_name]
3. git clone git@github.com:TaykhoomDalal/ZLAB-Research.git
4. cd ZLAB-Research
5. git config --global user.name "[Insert your full name here]"
6. git config --global user.email "[insert your exact github account email]"
To set up remote connection to Github
1. ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
a. when it says “Enter a file in which to save the key” just press enter and let it go to the default folder which should be something like “….ssh/id_rsa”
b. when it asks for password I just hit enter twice so there is no password for simplicity
2. eval `ssh-agent -s`
3. ssh-add ~/.ssh/id_rsa
Now we need to copy this SSH key to github account settings
1.  cd ~/.ssh
2.  then using the editor of your choice, open the file called “id_rsa.pub”
a.  I used the command
i.  emacs -nw id_rsa.pub
3.  copy paste the contents of this file using your mouse and control C
a.  then go into your browser and paste it into the search bar so if there are any unnecessary spaces, they will be removed, and then copy what you just pasted
4.  go to https://github.com/settings/keys
5.  click “New SSH Key”
6.  add a title – I called mine “Hoffman Cluster”
7.  and then paste what you have into the key field
8.  last thing to do is to hit add SSH key and if everything went well you should see a key added to your list of SSH keys called “Hoffman Cluster”
9.  Now on the cluster in that folder you are able to make changes and push them to our github repo!
One Quick Note
1.  I made a branch called “workingBranchg” so when you are in the ZLAB folder, go ahead and type 
a.  git checkout workingBranch
b.  Lets avoid editing the main branch except when we want to merge stuff into it
2.  Plus if you wanna go off on your own and try some different things, just use 
a.  git branch [insert branch name]
b.  git checkout [branch name]
