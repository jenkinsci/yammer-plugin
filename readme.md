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

## Obtain an Access Token

See: <https://github.com/yammer/yam#general-configuration>.

## Enable Yammer notifications for a job

In the job configuration, under Post-build Actions, select __Yammer Notification__:

![Enable Yammer Notifications for a job](https://github.com/mattriley/yammer-plugin-for-jenkins/raw/master/readme/enable_yammer_notifications_for_job.png)

The Access Token defaults to an environment variable named YAMMER_ACCESS_TOKEN under the assumption that the same access token will likely be the same for many, if not all jobs.
For example, you might create a Yammer user representing Jenkins that will act as the source of all Yammer notifications from Jenkins.

Global environment variables can be set from Jenkins at Manage Jenkins > Configure System > Global Properties:

![OAuth environment variables](https://github.com/mattriley/yammer-plugin-for-jenkins/raw/master/readme/oauth_environment_variables.png)

With the Access Token set, select whether to send success and/or failure notifications:

![Enable success notifications](https://github.com/mattriley/yammer-plugin-for-jenkins/raw/master/readme/enable_success_notifications.png)

Both success and failure notifications require a message and a group name. Environment variables are also allowed.

Please ensure that the Yammer user associated with the OAuth token has been added to the specified groups,
otherwise the post will result in a HTTP 403 Unauthorised error.

## Support

[Raise an issue](https://github.com/mattriley/yammer-plugin-for-jenkins/issues)

## Changelog

### Version 1.0.0 (March 15, 2013)

- Upgrade to OAuth 2.0 requiring only an access token.
- Yammer group name replaces group ID.

### Version 0.1.1 (March 15, 2013)

- Add support for Jenkins version 1.505. Thanks [Jörg Wendland](https://github.com/jwendland).
- Use better OAuth terminology (consumer instead of client). Thanks [mikec-bullhorn](https://github.com/mikec-bullhorn).

### Version 0.1.0 (June 24, 2012)

- Initial release.