# Flutter template

A template for a Flutter project that has a Login and Registration Screen. The main Screen 
has a Navigation Drawer that utilizes Navigator 1.0 with Named Routes. Optional arguments can
be passed to PostPage to demonstrate navigation using Named Routes with arguments.

### Navigation

To Navigate, there are two Navigators set: 
one on `MyApp()` - run in main(), and the other one is on `NavigatorPage`

![Navigator flow](https://user-images.githubusercontent.com/4143153/133398753-401ab2c2-1b18-4274-a0b3-4eb9362750c9.png)


The reason for using two Navigators is so we could utilize a single AppBar and update the
route displayed on the browser's address bar on web.

![Demo](https://user-images.githubusercontent.com/4143153/133398626-de27d502-7a12-49a9-b2bb-ed34982da4f7.gif)


### Contributing

Refer to this doc for frequently used commands in Git: https://about.gitlab.com/images/press/git-cheat-sheet.pdf

#### Checkout

This command switches to the branch, -b creates the branch if it has yet to exist

`git checkout [-b] [BRANCH_NAME]`

#### Merging

Merge changes from branch [BRANCH_NAME] to current branch

`git merge [BRANCH_NAME]`

#### Committing changes to branch

`git add [FILE/PATH]`

Add label on what the committed changes are for

`git add [FILE]`

`git commit -m ‘[MESSAGE]’`  - commit message for the added file, adding commit message for individually added files is also possible

#### Pushing changes

Push changes to remote[origin] repository[BRANCH]

`git push origin [BRANCH]`

#### Delete branch

Deletes local branch

`git branch -d [BRANCH_NAME]`

Push changes to remote[origin] repository[BRANCH]

`git push -d origin [BRANCH_NAME]` 
