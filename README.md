# cloud-int
Continuous Integration in the Cloud

With this repository, we are providing anyone wishing to creat a Continuous Integration Pipeline whether it be for personal, educational, or industrial purposes with a pipeline to do so.  While we use specific environments and tools to create the sample webapp we are creating this for, it is easily customizable to suit anyones needs.

Technologies Used:

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

What Makes this Environment Superior to Creating Your Own Framework?

Many developers within a company or institution often write and test code in a different OS than their QA and Production environments run.  This can cause many problems with programming languages that have different libraries, dictionaries, and runtime environments in one OS than another.  This creates the excuse of "Well, it worked on my machine so I don't see why it doesn't work now."  Luckily, Vagrant takes care of this issue as we are able to create portable VMs that can run the OS and installed software on our QA and Production servers.  The developer can simply download the vagrant file, say "vagrant up", "vagrant ssh" into the Vagrant VM from the command line, run the setup.sh script and the developer is easily able to run and test the app locally before pushing the QA environment.

