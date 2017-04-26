#! /usr/local/bin/Rscript --default-packages=utils --no-restore --no-site-file --no-init-file
library(stats)
library(plyr)
library(gh)
library(git2r)
library(optparse)
library(googlesheets)

#TO-DO: Add verbose option

#See other TO-DOs further down

option_list <- list(
  make_option(c("-d", "--repoDirectory"), default="~/git/r_club_members/", 
              help="Directory for repositories [default= %default]", metavar="path"),
  make_option(c("-o", "--organization"), default="UCD-pbio-rclub", 
              help="Organization name [default= %default]", metavar="character"),
  make_option(c("-u", "--userFile"), default="R Club Github Username (Responses).gsheet", metavar="path",
              help="Path to .csv file with github usernames, or gsheet.  
                *MUST* contain columns 'First.Name', 'Last.Name', & 'github.username'.
                Required for 'create-team' [default = %default]"),
  make_option(c("-r", "--repository"), default="Rclub-r4ds",
              help="Suffix of repository to create, push, or pull to;
                    team name will automatically be pre-pended",metavar="character"),
  make_option(c("-s", "--sourceDirectory"), metavar = "path",
              help="Source directory of files to add to repository"),
  make_option(c("-f", "--files"),  default = "*",
              help="Files to add to repository or to stage.  'copy-files' will move these from a source directory but not stage them.
              'add' will only add files already in the repository. 
              Enclose in quotes and separate with spaces if multiple files. If blank all files in source-directory will be added"),
  make_option(c("-m", "--message"),dest="cmessage",
              help="Commit message"),
  make_option(c("-t", "--team"),dest="team.to.add",
              help="Team to add when using 'add-team' option; this team will be added
              to all repositories matching the keyword given to -r",metavar="character"))

opt_parser <- OptionParser(usage = "usage: %prog CMD [options]",option_list=option_list,
                           description="Script for creating, pushing, and pulling to/from multiple repositories in an organization. \n At lease one CMD is required and should be one of 'create-team', create-repo', 'clone' 'pull', 'push' 'copy-files', 'commit', 'commit-all', 'add', 'add-team' or 'remove-teams'. \n Multiple commands can be given and will be executed sequentially in the order given.")

opt <- parse_args(opt_parser,positional_arguments = TRUE)

debug<-FALSE
#debug
#debug <- TRUE

if (debug) print(opt)


if (length(opt$args)==0 || ! opt$args %in% c("create-team","create-repo","clone","pull","copy-files","add","commit", "commit-all", "push", "remove-teams", "add-team") ) stop(print_help(opt_parser))

attach(opt$options)

if (debug) {
  repoDirectory <- "~/git/r_club_members/"
  organization <- "UCD-pbio-rclub"
  userFile <- "R Club Github Username (Responses).gsheet"
  repository <- "Rclub-r4ds"
}

teams <- gh("/orgs/:org/teams", org=organization,.limit=Inf)

current.teams <- data.frame(team.name=sapply(teams, function(x) x$name),
                            team.id=sapply(teams, function(x) x$id))

if (grepl("add-team",paste(opt$args,sep="",collapse="")) & exists("team.to.add")) team.to.add.id <- current.teams[grepl(team.to.add,current.teams$team.name),"team.id"]

current.teams <- current.teams[!grepl("(Owners|Instructors|Graders)",current.teams$team.name),]

if (debug) current.teams <- current.teams[grepl("Julin",current.teams$team.name),]

# import list of users 
if (grepl("gsheet",userFile)) {
  userFile <- sub(".gsheet","",userFile,fixed = TRUE)
  users <- gs_read(gs_title(userFile))
  colnames(users) <- make.names(colnames(users))
} else {
  users <- read.csv(userFile,as.is=T,header=T,strip.white=T)
}
users$team.name <- make.names(paste(users$First.Name,users$Last.Name))
users$Real.Name <- paste(users$First.Name,users$Last.Name)

current.teams <- current.teams[current.teams$team.name %in% users$team.name,] #ensure that we are only adding repos to Users that have signed up for this module

for (cmd in opt$args) {
  
  #######################-CREATE TEAMS-##############################
  #This will create one team for each username in userFile
  #The user will be added as the sole member of that team.
  #This is necessary for correctly managing student directories and access permissions
  
  if (cmd=="create-team") {
    
    # Get compare existing teams to those in imported spreadsheet
    
    new.teams <- users[! users$team.name %in% current.teams$team.name,]
    new.teams <- new.teams[!new.teams$github.username=="",]
    #new.teams <- new.teams[1:3,]
    
    # create teams
    
    create.team.out <- apply(new.teams,1,function(team) {
      gh("POST /orgs/:org/teams", 
         org = organization,
         name=team[["team.name"]],
         description=paste("Team for",team[["Real.Name"]],"to turn in RClub assignments")
      )
    })
    
    new.team.results <- as.data.frame(t(sapply(create.team.out,function(x) c(x$name,x$id))),stringsAsFactors=FALSE)
    names(new.team.results) <- c("team.name","team.id")
    print(new.team.results)
    new.teams <- merge(new.teams,new.team.results,by="team.name")
    
    # add user to team
    add.members.out <- apply(new.teams,1,function(team) { 
      print(team)
      gh("PUT /teams/:id/memberships/:username",
         id = team[["team.id"]],
         username = team[["github.username"]])
    })
    #Need to add some checks/reports here
    
  }
  
  ################### CREATE REPOSITORIES #############################
  
  if (cmd=="create-repo") {
    if (!exists("repository")) stop(paste("Please provide a repository name", print_help(opt_parser),sep="\n"))
    
    #TO-DO: add a check here to see if the repository already exists
    
    create.repository.out <- apply(current.teams,1,function(team) {
      print(team[["team.name"]])
      gh("POST /orgs/:org/repos",
         org=organization,
         name=paste(repository,team[["team.name"]],sep="_"),
         #description=paste(repo.description,"from",team[["team.name"]]),
         #private="true",
         auto_init=TRUE,
         team_id=team[["team.id"]])
    })
    
    
    #Give teams push access to their repository...
    
    update.repository.out <- apply(current.teams,1,function(team) {
      print(team[["team.name"]])
      gh("PUT /teams/:id/repos/:org/:repo",
         org=organization,
         id=team[["team.id"]],
         repo=paste(repository,team[["team.name"]],sep="_"),
         permission="push")
    })
    
  } 
  
  #################### DELETE REPOSITORIES ###############################
  
  # currently not enabled as an option, but can be run interactively...
  
  if (cmd=="delete-repo") {
    delete.repository.out <- apply(current.teams,1,function(team) {
      print(team[["team.name"]])
      gh("DELETE /repos/:owner/:repo",
         owner="organization",
         repo=paste(repo.prefix,team[["team.name"]],sep="_")
      )
    })
  }
  
  #################### CLONE REPOSITORIES ################################
  
  ##TO-DO possibly have this create a hiearchical directory structure
  ##TO-DO figure out how to do this with git2r::clone  (not like I haven't tried...)
  
  if (cmd=="clone") {
    if (!exists("repository")) stop(paste("Please provide a repository name", print_help(opt_parser),sep="\n"))
    
    if(! file.exists(repoDirectory)) dir.create(repoDirectory)
    
    repos.df <- ldply(apply(current.teams,1,function(team) {
      repos <- gh("GET /teams/:id/repos",id = team[["team.id"]], .limit=Inf)
      data.frame(name=sapply(repos,function(x) x$name),
                 url=sapply(repos,function(x) x$ssh_url),
                 stringsAsFactors = FALSE
      )}))
    
    repos.df <- subset(repos.df,subset = grepl(repository,name))
    
    apply(repos.df,1, function(repo)  {
      if(! file.exists(file.path(repoDirectory,repo["name"]))) {
        system(paste("git clone",repo["url"],file.path(repoDirectory,repo["name"])))
      }
    })
  }
  
  ###################### COPY FILES #####################################
  
  # Add files from a source directory to a set of repositories matching repository name
  
  # TO-DO add directories and preserve path structure if desired
  
  if (cmd=="copy-files") {
    if (!exists("sourceDirectory")) stop(paste("Please provide a Source directory", print_help(opt_parser),sep="\n"))
    if (!exists("repository")) stop(paste("Please provide a repository name", print_help(opt_parser),sep="\n"))
    if (!dir.exists(sourceDirectory)) stop(paste("Source Directory", sourceDirectory, "does not exist"))
    
    if (files=="*") {
      my.files <- dir(sourceDirectory,full.names=T,all.files=TRUE, no.. = TRUE)
    } else {
      my.files <- dir(sourceDirectory, full.names=T,pattern=gsub(" ","|",files),all.files = TRUE,no.. = TRUE)
    }
    if (length(my.files)==0) stop(paste("Error, no matching files in", sourceDirectory))
    
    repo.directories <- dir(repoDirectory, full.names=T, pattern = repository)
    if (length(repo.directories)==0) stop("No Repositories Found")
    for(repo in repo.directories) {
      file.copy(from=my.files,to=repo,recursive = TRUE)
    }
  }
  
  ########################### ADD FILES #################################
  
  # stage  files
  
  if (cmd=="add") {
    if (!exists("repository")) stop(paste("Please provide a repository name", print_help(opt_parser),sep="\n"))
    
    my.files <- unlist(strsplit(files,split = " "))
    
    repo.directories <- dir(repoDirectory, full.names=T, pattern = repository)
    if (length(repo.directories)==0) stop("No Repositories Found")
    for(repo in repo.directories) {
      add(repository(repo),my.files)
    }
  }
  
  ########################### COMMIT ####################################
  
  if (cmd=="commit") {
    if (!exists("repository")) stop(paste("Please provide a repository name", print_help(opt_parser),sep="\n"))
    if (!exists("cmessage")) stop(paste("Please provide a commit message", print_help(opt_parser),sep="\n"))
    
    repo.directories <- dir(repoDirectory, full.names=T, pattern = repository)
    if (length(repo.directories)==0) stop("No Repositories Found")
    for(repo in repo.directories) {
      print(repo)
      tryCatch(commit(repository(repo),cmessage),
               error = function(e) {
                 print(paste("Error committing to", repo))
                 print(e$message)
               })
    }
  }
  
  ######################## COMMIT ALL ###################################
  
  if (cmd=="commit-all") {
    if (!exists("repository")) stop(paste("Please provide a repository name", print_help(opt_parser),sep="\n"))
    if (!exists("cmessage")) stop(paste("Please provide a commit message", print_help(opt_parser),sep="\n"))
    
    repo.directories <- dir(repoDirectory, full.names=T, pattern = repository)
    if (length(repo.directories)==0) stop("No Repositories Found")
    for(repo in repo.directories) {
      print(repo)
      tryCatch(commit(repository(repo),cmessage),
               error = function(e) {
                 print(paste("Error committing to", repo))
                 print(e$message)
               })    }
  }
  
  ######################## PUSH #########################################
  
  # TO-DO figure out authentication in git2r (maybe just add SSH key) and change to the internal command
  if (cmd=="push") {
    if (!exists("repository")) stop(paste("Please provide a repository name", print_help(opt_parser),sep="\n"))
    
    repo.directories <- dir(repoDirectory, full.names=T, pattern = repository)
    if (length(repo.directories)==0) stop("No Repositories Found")
    for(repo in repo.directories) {
      error <- system(paste("cd",repo,
                            "; pwd;  git push -u origin master")) #error will be 0 if success, 1 if failure
      if(error) stop(paste("Error pushing into",repo)) else print(paste("done with ",repo))
    }
  }
  
  
  ############################## PULL ####################################
  
  if (cmd=="pull") {
    if (!exists("repository")) stop(paste("Please provide a repository name", print_help(opt_parser),sep="\n"))
    
    repo.directories <- dir(repoDirectory, full.names=T, pattern = repository)
    if (length(repo.directories)==0) stop(paste("No repositories matching",sQuote(repository),"in",sQuote(repoDirectory)))
    for(repo in repo.directories) {
      error <- system(paste("cd",repo,
                            "; pwd;  git pull")) #error will be 0 if success, 1 if failure
      if(error) stop(paste("Error pulling into",repo)) else print(paste("done with ",repo))
    }
  }
  
  
  ################### REMOVE TEAM FROM REPOSITORY #############################
  
  if (cmd=="remove-teams") {
    if (!exists("repository")) stop(paste("Please provide a repository name", print_help(opt_parser),sep="\n"))
    
    #TO-DO: add a check here to see if the repository already exists
    
    remove.team.out <- apply(current.teams,1,function(team) {
      print(team[["team.name"]])
      gh("DELETE /teams/:id/repos/:owner/:repo", 
         id=team[["team.id"]],
         owner = organization,
         repo=paste(repository,team[["team.name"]],sep="_")
      )
    })
  } 
  
  ################### ADD TEAM #############################
  
  if (cmd=="add-team") {
    if (!exists("repository")) stop(paste("Please provide a repository name", print_help(opt_parser),sep="\n"))
    
    #TO-DO: add a check here to see if the repository already exists
    
    add.team.out <- apply(current.teams,1,function(team) {
      print(team[["team.name"]])
      gh("PUT /teams/:id/repos/:org/:repo",
         id=ifelse(exists("team.to.add.id"),
                   team.to.add.id,
                   team[["team.id"]]),
         org = organization,
         repo=paste(repository,team[["team.name"]],sep="_"),
         permission="push")
    })
  } 
  
  ########################################################################
} # for cmd

detach(opt$options)

#delete.team.out <- sapply(current.teams$team.id, delete.team, ctx)
