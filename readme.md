# Yammer Plugin for Jenkins

The Yammer Plugin for Jenkins enables notifications to be sent to a Yammer group on the success or failure of a build.

This is an example of a successful build notification sent to the __Build Notifications__ group:

![Success notification in Yammer](https://github.com/mattriley/yammer-plugin-for-jenkins/raw/master/readme/success_notification_in_yammer.png)

## Installation

The plugin is not currently listed in Jenkins, but is expected to be soon. Until then:

1. Install the ruby-runtime plugin.
2. Install the [Token Macro Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Token+Macro+Plugin). It may already be installed.
3. Download the latest Yammer Plugin .hpi file from: [http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/ruby-plugins/yammer](http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/ruby-plugins/yammer).
4. Upload the .hpi file into Jenkins from Plugin Manager > Advanced.
5. Restart Jenkins.

## Obtain an OAuth token from Yammer

The plugin requires 4 OAuth parameters: Client Key, Client Secret, Token Key, Token Secret.

See [Yammer API Documentation for OAuth](https://developer.yammer.com/api/#oauth) for more information.

TODO: Expand this section. To have this section expanded sooner, please contact: matthew-github@matthewriley.name.

## Enable Yammer notifications for a job

In the job configuration, under Post-build Actions, select __Yammer Notification__:

![Enable Yammer Notifications for a job](https://github.com/mattriley/yammer-plugin-for-jenkins/raw/master/readme/enable_yammer_notifications_for_job.png)

The OAuth parameters default to environment variables in case the same parameters are used across many jobs.
For example, you might create a user in Yammer representing Jenkins that will act as the source of all Yammer notifications from Jenkins.

Global environment variables can be set from Jenkins at Manage Jenkins > Configure System > Global Properties:

![OAuth environment variables](https://github.com/mattriley/yammer-plugin-for-jenkins/raw/master/readme/oauth_environment_variables.png)

If the OAuth parameters are specific to the job, simply replace the default values with the specific parameters.

With the OAuth parameters set, select whether to send success and/or failure notifications:

![Enable success notifications](https://github.com/mattriley/yammer-plugin-for-jenkins/raw/master/readme/enable_success_notifications.png)

Both success and failure notifications accept a message and a group ID, both of which are required.
The group ID is the feedId parameter in the group URL:

![Group ID in URL](https://github.com/mattriley/yammer-plugin-for-jenkins/raw/master/readme/group_id_in_url.png)
