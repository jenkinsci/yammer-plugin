# Yammer Plugin for Jenkins

The Yammer Plugin for Jenkins enables notifications to be sent to a Yammer group on the success or failure of a build.

This is an example of a successful build notification sent to the __Build Notifications__ group:

![Success notification in Yammer](https://github.com/mattriley/yammer-plugin-for-jenkins/raw/master/readme/success_notification_in_yammer.png)

## Installation

### Easy install

Install the plugin from the Jenkins Plugin Manager. It should be listed as __Yammer Plugin__ under __Build Notifiers__.

### Manual install

1. Install the ruby-runtime plugin.
2. Install the [Token Macro Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Token+Macro+Plugin). It may already be installed.
3. Download the latest Yammer Plugin .hpi file from: [http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/ruby-plugins/yammer](http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/ruby-plugins/yammer).
4. Upload the .hpi file into Jenkins from Plugin Manager > Advanced.
5. Restart Jenkins.

## Obtain an OAuth Token from Yammer

The Yammer API uses OAuth for user authentication.
As a result, the plugin requires 4 OAuth parameters which can be obtained by following the steps below.

### Register a New Application

To obtain a __Client Key__ and a __Client Secret__, [register the plugin as a Yammer application](https://www.yammer.com/client_applications/new).

An example application name could be: Company XYZ Build Notifications.

### Obtain an OAuth Token

To obtain an __OAuth Token__ and an __OAuth Secret__, download and run [get_auth.rb](https://github.com/jenkinsci/yammer-plugin/blob/master/get_auth.rb) using Ruby.
get_auth.rb is a helper script that will request your Client Key and Secret, and walk through the process of obtaining an OAuth Token and Secret.

When prompted to authorise the application, ensure Yammer is logged in with the user you want the notifications to be sent __from__.

Consider creating Yammer user representing Jenkins that will act as the source of all Yammer notifications from Jenkins.

See [Yammer API Documentation for OAuth](https://developer.yammer.com/api/#oauth) for more information.

## Enable Yammer notifications for a job

In the job configuration, under Post-build Actions, select __Yammer Notification__:

![Enable Yammer Notifications for a job](https://github.com/mattriley/yammer-plugin-for-jenkins/raw/master/readme/enable_yammer_notifications_for_job.png)

The OAuth parameters default to environment variables in case the same parameters are used across many jobs.
For example, you might create a Yammer user representing Jenkins that will act as the source of all Yammer notifications from Jenkins.

Global environment variables can be set from Jenkins at Manage Jenkins > Configure System > Global Properties:

![OAuth environment variables](https://github.com/mattriley/yammer-plugin-for-jenkins/raw/master/readme/oauth_environment_variables.png)

If the OAuth parameters are specific to the job, simply replace the default values with the specific parameters.

With the OAuth parameters set, select whether to send success and/or failure notifications:

![Enable success notifications](https://github.com/mattriley/yammer-plugin-for-jenkins/raw/master/readme/enable_success_notifications.png)

Both success and failure notifications require a message and a group ID. Environment variables are also allowed.

The group ID is the feedId parameter in the group URL:

![Group ID in URL](https://github.com/mattriley/yammer-plugin-for-jenkins/raw/master/readme/group_id_in_url.png)

Please ensure that the Yammer user associated with the OAuth token has been added to the specified groups,
otherwise the post will result in a HTTP 403 Unauthorised error.

## Feedback

Thanks for your interest in the Yammer Plugin for Jenkins.

Your feedback is valuable. To provide feedback, [raise an issue](https://github.com/mattriley/yammer-plugin-for-jenkins/issues)
or send an email to matthew-github@matthewriley.name.


