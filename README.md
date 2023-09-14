




**Application Setup:**
- Took Employee Management System application as the base of the project

**PostgreSQL Installation and Configuration:**

- An AWS EC2 instance was created for hosting the database server (PostgreSql)
- Also the security groups for the PostgreSql was configured 
- PostgreSql was installed and configured on the instance
- The "employee_app" database was created to support the application.
- Within the "employee_app" database, "employees" table was created
- Configured the psql  for listening to the public ip addresses to get the remote requests
- Configuration details, including the database URL, username, and password, were added to the application.properties to the java application .This is done so that application connects correctly and the data is fetched from the database  
<img src="https://github.com/j-rin/java_sql/blob/main/new/Screenshot%20from%202023-09-13%2017-05-54.png" width="600" height="300">

**EBS Volume Addition:**


<img src="https://github.com/j-rin/java_sql/blob/main/new/Screenshot%20from%202023-09-13%2017-07-58.png" width="600" height="300">

- For the data reliability, an additional Elastic Block Store (EBS) volume (/dev/xvdf) was attached to the EC2 instance and configured the necessary mounting(/mnt/my_ebs_volume).
  
- Backups was automated  using crontab, with the bash script and working was tested

<img src="https://github.com/j-rin/java_sql/blob/main/new/Screenshot%20from%202023-09-13%2021-29-46.png" width="600" height="300">

**Building and Containerizing**

- The application was packaged into a JAR file using Maven.
  
- java version 17 was used for it

- Created a Dockerfile to generate a Docker image from the application.

- The Docker image was pushed to Docker Hub for convenient sharing and distribution ,(jerinpaul/java-app:latest)

<img src="https://github.com/j-rin/java_sql/blob/main/new/Screenshot%20from%202023-09-13%2021-36-12.png" width="600" height="300">

**Kubernetes**

- A Kubernetes cluster was established using Kubeadm,EKS featuring two worker nodes.

- Made sure that all the components were running properly by checking their status using kubectl commands.

- Deployment and Service files were applied to Kubernetes using kubectl with necessary details  to deploy the application.

- The deployment  ran successfully, and it was verified that the application was running on the designated port.
  
<img src="https://github.com/j-rin/java_sql/blob/main/new/WhatsApp%20Image%202023-09-13%20at%204.39.54%20PM.jpeg" width="600" height="300">

**AWS**

- Created an AWS target group to manage traffic to the worker nodes  where the application pods are running .

- An Application Load Balancer was created and linked to the target group to distribute traffic effectively.

- Assigned necessary security groups for the ALB
 http://clusteralb-1649197627.ap-south-1.elb.amazonaws.com/
<img src="https://github.com/j-rin/DevopsAssessment/blob/main/new/Screenshot%20from%202023-09-14%2015-48-55.png" width="600" height="300">

**Jenkins Pipeline**
   
<img src="https://github.com/j-rin/java_sql/blob/main/new/Screenshot%20from%202023-09-13%2017-02-26.png" width="600" height="300">

- Automation was introduced via a Jenkins pipeline using a declarative pipeline script.

  **GitHub Repository Integration:**
      - The pipeline was set up to clone GitHub repository.

  **Build and Packaging:**
      - Maven was employed within the pipeline for building the artifact

   **Containerizing Application**
      - The pipeline included the creation of a Docker image from the Dockerfile and its subsequent push to Docker Hub.

   **Integration with Sonarqube:**
      - Sonarqube was integrated into the pipeline to perform code analysis.

   **Docker Deployment:**
      - Docker was used to deploy the application to Tomcat.
