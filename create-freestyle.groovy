#!groovy

import jenkins.model.Jenkins;
import hudson.model.WorkflowJob;
import hudson.tasks.Shell;
import hudson.triggers.SCMTrigger;

def jenkins = Jenkins.getInstance();
def initJob = jenkins.createProject(WorkflowJob, 'init-job');

initJob.setDescription('This is a dummy project');
