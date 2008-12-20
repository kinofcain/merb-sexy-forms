require 'fileutils'

namespace :merb_sexy_forms do
  desc "Update assets for sexy forms"
  task :update_assets do
    assets = File.join(File.dirname(__FILE__), "../../assets")
    FileUtils.cp(File.join(assets, "stylesheets/sexy_forms.css"), "public/stylesheets/")
    FileUtils.mkdir_p("public/images/sexy_forms")
    FileUtils.cp(File.join(assets, "images/sexy_forms/fieldbg.gif"), "public/images/sexy_forms/")
  end
end