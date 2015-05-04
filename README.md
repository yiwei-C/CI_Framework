# cloud-int
**Continuous Integration in the Cloud**

With this repository, we are providing anyone wishing to creat a Continuous Integration Pipeline whether it be for personal, educational, or industrial purposes with a pipeline to do so.  While we use specific environments and tools to create the sample webapp we are creating this for, it is easily customizable to suit anyones needs.


##Framwork Overview##

![UML Diagram](https://raw.githubusercontent.com/BU-EC500-SP15/cloud-int/master/Overview.png)

**Technologies Used**

Jenkins:
Jenkins is a Continuous Integration tool that notices when a change is made to a Git or SVN repositoty. When a change is committed Jenkins triggers Maven to build a specified webapp.  Upon a successful build, another job is triggered which will run tests against the webapp in our QA environment.  We will continue to utilize Jenkins jobs to automate this CI process from local machine to Production.

Vagrant:
Vagrant is a tool that allows developers to create portable development environments.  The developer selects a verified Vagrant Image of the OS they desire to use.  In this case, we are using CentOS as that is what our QA and Production environments are running.  We then right a setup.sh script with the necessary commands to install the tools and software needed to run our app.

Maven:
A tool used that automatically builds Java projects utilizing a pom.xml file with specified paths and environments to build to.

Docker:
Docker is a tool used to containerize all dependencies needed to run an app or software.  We use Docker to containerize our webapp with all of the necessary Java libraries and runtime environments so the app will be run within the container as opposed to against the server.  We will also be able to create a Docker container for Jenkins to provide a portable server for anyone who wishes to use it.

Google Developers Console:
Google Developers Console (GDC) is the server we use to host our QA and production environments. GDC acts as our servers and lets us run our code in the environment in which it will be produced in as well as lets us show that we can change code on our local environment, push to a repository, and watch it update automatically in the server.

CentOS:
CentOS is the operating system we are using on GDC.

Java:
Java is the language we have used to develop a web application to test our continuous integration environment. It is also the language in wich Jenkins and Maven use to operate.

**What Makes this Environment Superior to Creating Your Own Framework?**

Many developers within a company or institution often write and test code in a different OS than their QA and Production environments run.  This can cause many problems with programming languages that have different libraries, dictionaries, and runtime environments in one OS than another.  This creates the excuse of "Well, it worked on my machine so I don't see why it doesn't work now."  Luckily, Vagrant takes care of this issue as we are able to create portable VMs that can run the OS and installed software on our QA and Production servers.  The developer can simply download the vagrant file, say "vagrant up", "vagrant ssh" into the Vagrant VM from the command line, run the setup.sh script and the developer is easily able to run and test the app locally before pushing the QA environment.

While Vagrant is a great tool that solves many of the problems of developing and testing in different environments, often times, Vagrant Images can be missing RPMs that are present in other builds of an OS, CentOS in our case.  Luckily, we can solve this issue using Docker.  Docker uses containers to encapsulate any app and any libraries and OS dependencies needed to run the app so rather than running against a server, it runs against the components in the container, therefore eliminating the issue of missing RPMs.

Another problem that Docker solves for users is that it takes away the need stop and restart your servers when launching an update to webapp.  This task can take minutes in most cases and can often lead to a website experiencing downtime.  When an app is containerized using Docker, we simply need to specify the "docker run" command in the post-build step of our Jenkins job for the updated container to run.  Since docker apps run against the container inside the server, the server will never need to be shut down and restarted.

**How to Run the Pipeline as is**

In order to run the pipeline as is, you must first download and install vagrant on your local machine.  This can be done here: http://www.vagrantup.com/downloads.html

Next, you will need to clone this repository to your local machine via command line git commands.
After cloning the git repo, navigate to that repository in your terminal window.

Type the command "vagrant up" which will create a VM based off of the information in the vagrantfile and setup.sh script in this git repository.  These files contains the Vagrant Image for the desired OS and the commands to download and install all software and tools you would like in your environment.

After the VM finishes creating, type the command "vagrant ssh" which allows you to ssh into the VM.  Once inside the VM you are able to access files in directories in the VM and in your local machine seamlessly.
Navigate to the vagrant directory "cd vagrant"
Type "ls" to view the contents of the directory, where you will see many files and folders, including the run.sh file.
Type "./run.sh -r" this script will locally build our dockerized webapp.
Navigate to http://localhost:2200 (as it is set to run on port 2200) to ensure that it is running after the script finishes.

Navigate to 104.154.49.202:8080 to pull up the UI for the QA environment Jenkins.
Here you will see the ninja-test job which is used to build and test the webapp in the QA environment.  If you click on the job and then click on configure, you will see the git repo we are linked to, that we set it to build when a change occurs, reference the pom.xml file that Maven will use to build it, and finally, references the job in the Production environment to build once this one succeeds.
Navigate to 104.154.113.137:8080 to pull up the UI for the Production environment Jenkins.
Here you will see the ninja-publish job which is used to run the previously built image in our Production environment since it runs and passed the test suite in QA.  You will see the post build command "sh ./cloud.sh" that runs our cloud.sh bash script to accomplish running the docker image.

Open up a new terminal window and navigate to this git repo.
Type "cd app/run/ninja-sample/src/main/java/dao"
Open the SetupDao.java file by typing "vim SetupDao.java"
Change the line 'public string post1Title = "Welcome to Cloud Computing" ' to 'public string post1Title = "Welcome to the blog example!" '
Commit the change to the git repo by typing "sudo git add app/run/ninja-sample/src/main/java/dao/DaoSample.java" and then "sudo git commit -m "v1""
Type "sudo git push origin master" to push the commit the repo hosted on Github.

This push will trigger the Jenkins job in the QA server.
You can go back to the Jenkins web UI and see the job building.  If you click on the job and navigate to the console, you will see the step by step output as the job executes.

Once you see this build succeed, you can go to the tab with the Jenkins Web UI for production, click on the job, and see it was triggered by the other job succeeding by opening the console as you did in the QA environment.  Once you see this build succeeds we can navigate to the website.

In your browser, navigate to 104.154.113.137:1234 (as this is the port it is set to deploy to).

You will see the Webapp has successfully gone through our CI pipeline from local machine to Production with very little work done by the developer besides committing a code change to a git repo.  After your first time, you will never need to setup vagrant or any other tools on your local machine again.  You'll simply just need to make code changes and it will be build, test, and deploy automatically.

**How Can You Use our Framework for your Own Use?**

We provide quite a few scripts and tools within this repository that you can edit to suit your own needs.

We have included a vagrantfile which is used to specify the specify the OS we would like, which is CentOS.  We made no changes to this file besides naming the box centos7.0.  You can find other Vagrant boxes here: https://atlas.hashicorp.com/boxes/search with the Vagrant file for your desired OS or use ours if you would like to use Centos.

We also provide a setup.sh file which downloads and installs all of the software and tools we need for our CI process and webapp.  You will want to keep the installations for Git, Docker, Vim, and Java if you are using Java.  You can also add commands to download any other programs you may need such as Ant, Ruby, Python, Hadoop, etc.  We provide code in this file that specify pulling down, building, and running our particular Docker container with our webapp in it.  You will need to change this to specify the container you will be starting. We also include code to pull down a specified Git Repo.  All you neeed to do is simply edit it to reference your repo instead of ours.

You will see there is a run.sh script which has 2 functions.  You can run the command "run.sh -r" which will build the local Docker image and "run.sh -s" which stop the local docker image.

You will also see a Cloud.sh script that is used to run our built Docker Image in our production environment.  You will be able to reuse this as well, without making any changes.

We also include an app_setup.sh script which is used to change all of the other scripts for when a user wants to use a different webapp than ours.  All they simply have to do is change the warName variable and the appFolderName.  This file should always be in the same directory as the Dockerfile as this changes the necessary components of the Dockerfile to run the app.

We include a Dockerfile which is used to containerize our webapp.  This is used to have all the necessary components installed in the container to run our webapp.  We also use this to set environment variables needed to run the app as well.  This is automatically changed to suit your needs when you make slight modifications to the app_setup.sh script.

We also provide a Dockerized Jenkins instance.  This will automatically run thanks to our automation scripts and to access the web interface you will simply need to navigate to http://your-server-ip-address:8080.  Here you will be able to create jobs that suit the needs for your project.  We include a Job Import Plugin that allows you to deploy the webapp to multiple nodes at once as well as trigger jobs that are hosted in another server, say a job completing in your QA environment triggering a job in your Production environment.
