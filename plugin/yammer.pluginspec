Jenkins::Plugin::Specification.new do |plugin|
  plugin.name = 'yammer'
  plugin.display_name = 'Yammer Plugin'
  plugin.version = '1.1.0'
  plugin.description = 'Sends build notifications to Yammer.'
  plugin.url = 'https://wiki.jenkins-ci.org/display/JENKINS/Yammer+Plugin'
  plugin.developed_by 'matthewriley', 'Matthew Riley <matthew@matthewriley.name>'
  plugin.uses_repository :github => 'jenkinsci/yammer-plugin'
  plugin.depends_on 'ruby-runtime', '0.12'
  plugin.depends_on 'token-macro', '1.8'
end