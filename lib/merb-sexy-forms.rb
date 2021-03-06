# make sure we're running inside Merb
if defined?(Merb::Plugins)

  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:merb_sexy_forms] = {
    :container_tag => "li"
  }
  
  Merb::BootLoader.before_app_loads do
    # require code that must be loaded before the application
  end
  
  Merb::BootLoader.after_app_loads do
    dir = File.dirname(__FILE__) / 'merb-sexy-forms'
    require dir + '/builder'
    require dir + '/form'
  end
  
  Merb::Plugins.add_rakefiles "merb-sexy-forms/merbtasks"
end
