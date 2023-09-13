# java_sql




**Application Setup:**
- You initiated the Employee Management System application.

**AWS EC2 Instance Creation:**
- An AWS EC2 instance was created for hosting your application.

**PostgreSQL Installation and Configuration:**
- PostgreSQL was installed on the EC2 instance.
- You set up a password for the PostgreSQL user "postgres."
- The "employee_app" database was created to support the application.
- Within the "employee_app" database, you defined a table named "employees" with attributes like id, firstname, lastname, and email.

**EBS Volume Addition:**
- For the data reliability, i attached an additional Elastic Block Store (EBS) volume to the EC2 instance and configured the necessary mounting.
- Automation of backups was implemented using crontab, with the backup script available in your GitHub repository.

**PostgreSql Configuration:**
- Configuration details, including the database URL, username, and password, were added to the application's properties.

**Maven Build:**
- The application was packaged into a JAR file using Maven.

**Docker**
- I created a Dockerfile to generate a Docker image from your application.

- Dockerfile is given in the files

- The Docker image was pushed to Docker Hub for convenient sharing and distribution.

**Kubernetes**
- A Kubernetes cluster was established, featuring two worker nodes.

- The initial setup included the automatic deployment of default pods within the Kubernetes cluster.

- Deployment and Service configurations were applied to Kubernetes using kubectl to deploy your application.These files are also given 

**AWS**
- You configured an AWS target group to manage traffic routing to the application for the worker nodes .

- An AWS Application Load Balancer was created and linked to the target group to distribute traffic effectively.

- Created the security group that aws needeed for the application

**Jenkins Pipeline**
   
<img src="https://github.com/j-rin/java_sql/new/Screenshot from 2023-09-13 17-02-26.png" width="600" height="300">

- Automation was introduced via a Jenkins pipeline using a declarative pipeline script.

  **GitHub Repository Integration:**
      - The pipeline was set up to clone your GitHub repository.

  **Build and Packaging:**
      - Maven was employed within the pipeline for building the project using "mvn clean package."

   **Docker Image Creation and Push:**
      - The pipeline included the creation of a Docker image from the Dockerfile and its subsequent push to Docker Hub.

   **Integration with Sonarqube:**
      - Sonarqube was integrated into the pipeline to perform code analysis.

   **Docker Deployment in Tomcat:**
      - Docker was used to deploy the application within a Tomcat container.
