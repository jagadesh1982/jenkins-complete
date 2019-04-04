import hudson.model.*

def job = hudson.model.Hudson.instance.getJob("init-job")
hudson.model.Hudson.instance.queue.schedule(job, 0, causeAction, paramsAction)
