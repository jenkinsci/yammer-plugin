require 'erb'
require File.expand_path(File.dirname(__FILE__) + '/confluence')

class YammerPluginWikiPage

  def post(username, password)
    confluence = Confluence.new
    confluence.post content, 'Yammer Plugin', 'JENKINS', username, password, 'wiki.jenkins-ci.org'
  end

  private

  def content
    template = ERB.new template_as_text
    readme = readme_as_wiki
    template.result(binding)
  end

  def readme_as_wiki
    `markdown2confluence readme.md`
  end

  def template_as_text
    IO.read 'Rakelib/yammer_plugin_wiki_page.erb'
  end

end