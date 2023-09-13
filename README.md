# java_sql


First i setup the application of employee management system

Then created the an ec2 instance in AWS

Installed the Postgresql in that instance

    setup password for the user postgres

    created the database employee_app for the application 

    By using the employee_app database created the table in it name employees

       It contains the attributes like id, firstname, lastname, email.
       
    For the i connected  a extra EBS to the ec2 instance and mounted it and using the crontab automated the backed uisng the pgdumb command,the bash script is also given in the github 

Next i setup the application.properties data to the application files like database url,username,password etc

Then using the maven i packaged a jar file out of the application

After that i wrote the docker file to create the image out of it

I ran the image and tested it

Then i pushed the image to dockerhub 

After that we setup the kubernetes cluster with 2 worker nodes in it

     All the default pods were running

     Then we applied the Deployment file and service file using kubectl

     then we created the target group in the aws

     And created a Application load balancer and attached to the target group

`````````````````````````````````````````````````````````````````````````

After this we created the jenkins pipeline to automate it
![Screenshot from 2023-09-13 17-02-26](https://github.com/j-rin/java_sql/assets/78196411/2842e884-ef64-4eab-8e01-a60b3071fe68)

Cloned the repo from github

build using mvn clean package

then took the Dockerfile and created the image

And pushed to Dockerhub

Integrated it with Sonarqube for the analysis

Then Deployed it with Docker in tomcat

     
