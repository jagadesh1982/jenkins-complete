# Starting off with the Jenkins base Image
FROM jenkins/jenkins:latest
 
# Installing the plugins we need using the in-built install-plugins.sh script
RUN install-plugins.sh pipeline-graph-analysis:1.9 \
	cloudbees-folder:6.7 \
	docker-commons:1.14 \
	jdk-tool:1.2 \
	script-security:1.56 \
	pipeline-rest-api:2.10 \
	command-launcher:1.3 \
	docker-workflow:1.18 \
	structs:1.17 \
	workflow-step-api:2.19 \
	scm-api:2.4.0 \
	workflow-api:2.33 \
	jsch:0.1.55 \
	bouncycastle-api:2.17 \
	junit:1.27 \
	workflow-job:2.32 \
	antisamy-markup-formatter:1.5 \
	token-macro:2.7 \
	build-timeout:1.19 \
	credentials:2.1.18 \
	git-client:2.7.6 \
	ssh-credentials:1.15 \
	plain-credentials:1.5 \
	git-server:1.7 \
	credentials-binding:1.18 \
	timestamper:1.9 \
	workflow-cps-global-lib:2.13 \
	workflow-support:3.2 \
	github-api:1.95 \
	durable-task:1.29 \
	workflow-durable-task-step:2.29 \
	matrix-project:1.14 \
	resource-disposer:0.12 \
	ws-cleanup:0.37 \
	ant:1.9 \
	git:3.9.3 \
	gradle:1.31 \
	pipeline-milestone-step:1.3.1 \
	display-url-api:2.3.1 \
	jquery-detached:1.2.1 \ 
	jackson2-api:2.9.8 \
	github:1.29.4 \
	ace-editor:1.1 \
	workflow-scm-step:2.7 \
	workflow-cps:2.65 \
	mailer:1.23 \
	pipeline-input-step:2.10 \
	pipeline-stage-step:2.3 \
	handlebars:1.1.1 \
	momentjs:1.1.1 \
	branch-api:2.2.0 \
	pipeline-stage-view:2.10 \
	pipeline-build-step:2.8 \
	workflow-multibranch:2.21 \
	pipeline-model-api:1.3.7 \
	pipeline-model-extensions:1.3.7 \
	apache-httpcomponents-client-4-api:4.5.5-3.0 \
	authentication-tokens:1.3 \
	workflow-basic-steps:2.15 \
	pipeline-stage-tags-metadata:1.3.7 \
	pipeline-model-declarative-agent:1.1.1 \
	pipeline-model-definition:1.3.7 \
	lockable-resources:2.5 \
	workflow-aggregator:2.6 \
	github-branch-source:2.4.5 \
	pipeline-github-lib:1.0 \
	mapdb-api:1.0.9.0 \
	subversion:2.12.1 \
	ssh-slaves:1.29.4 \
	matrix-auth:2.3 \
	pam-auth:1.4 \
	ldap:1.20 \
	email-ext:2.66 \ 
	javadoc:1.5 \
	maven-plugin:3.2 \
	docker-java-api:3.0.14 \
	docker-plugin:1.1.6
 
# Setting up environment variables for Jenkins admin user
ENV JENKINS_USER admin
ENV JENKINS_PASS admin
 
# Skip the initial setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
 
# Start-up scripts to set number of executors and creating the admin user
COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/
 
#VOLUME /var/jenkins_home

#RUN chown -R jenkins:jenkins /var/jenkins_home

# Name the jobs  
ARG job_name_1="sample-maven-job"  
RUN mkdir -p /usr/share/jenkins/ref/jobs/${job_name_1}/latest/builds/1
COPY ${job_name_1}_config.xml /usr/share/jenkins/ref/jobs/${job_name_1}/config.xml
COPY credentials.xml /usr/share/jenkins/ref/

# Create the job workspaces  
#RUN mkdir -p "$JENKINS_HOME"/workspace/${job_name_1}  
#RUN mkdir -p "$JENKINS_HOME"/jobs/${job_name_1}
#RUN mkdir -p "$JENKINS_HOME"/jobs/${job_name_1}/latest
#RUN mkdir -p "$JENKINS_HOME"/jobs/${job_name_1}/latest/builds
#RUN mkdir -p "$JENKINS_HOME"/jobs/${job_name_1}/latest/builds/1

# Create the jobs folder recursively  
#RUN mkdir -p "$JENKINS_HOME"/jobs/${job_name_1}  
#RUN mkdir -p "$JENKINS_HOME"/jobs/${job_name_1}/latest/
#RUN mkdir -p "$JENKINS_HOME"/jobs/${job_name_1}/builds/1/

# Add the custom configs to the container  
#COPY ${job_name_1}_config.xml "$JENKINS_HOME"/jobs/${job_name_1}/config.xml  

RUN id

USER root
RUN chown -R jenkins:jenkins "$JENKINS_HOME"/
RUN apt-get update -qq \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common 
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update  -qq \
    && apt-get install docker-ce=17.12.1~ce-0~debian -y
RUN usermod -aG docker jenkins

# docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

USER jenkins
# Create build file structure  
#USER jenkins 
#RUN chown -R jenkins:jenkins "$JENKINS_HOME"/jobs/${job_name_1}/latest/



