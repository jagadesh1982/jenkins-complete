# Starting off with the Jenkins base Image
FROM jenkins/jenkins:latest
 
# Installing the plugins we need using the in-built install-plugins.sh script
RUN install-plugins.sh git matrix-auth workflow-aggregator docker-workflow blueocean credentials-binding
 
# Setting up environment variables for Jenkins admin user
ENV JENKINS_USER admin
ENV JENKINS_PASS admin
 
# Skip the initial setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
# ENV JAVA_OPTS="-XX:PermSize=1024m -XX:MaxPermSize=512m"

 
# Start-up scripts to set number of executors and creating the admin user
COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY create-freestyle.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY trigger-job.groovy  /usr/share/jenkins/ref/init.groovy.d/

 
VOLUME /var/jenkins_home
