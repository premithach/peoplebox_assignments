# Session 1
## 1. Task: Create a new branch called feature/new-feature from the main branch. Add a file named example.txt with the text “Hello, World!” and push your changes to a remote repository. 
### Initialize the local repository and create README.md
echo "# peoplebox_assignments" >> README.md
git init

### Commit the README file
git add README.md
git commit -m "first commit"

### Set up the remote repository origin
git remote add origin https://github.com/premithach/peoplebox_assignments.git

### Push the main branch to GitHub
git push -u origin main

### Create and switch to the new feature branch 
git checkout -b feature/new-feature

### Create the example.txt file with "Hello, World!" content
echo "Hello, World!" > example.txt

### Stage the file for commit
git add example.txt

### Commit the change
git commit -m 'Add example.txt with 'Hello, World!''

### Push the new branch to the remote repository
git push -u origin feature/new-feature
