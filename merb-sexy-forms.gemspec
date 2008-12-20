# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{merb-sexy-forms}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Piotr Sarnacki"]
  s.date = %q{2008-12-20}
  s.description = %q{Merb plugin that provides extended builder for forms}
  s.email = %q{drogus@gmail.com}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/merb-sexy-forms.rb", "lib/merb-sexy-forms", "lib/merb-sexy-forms/builder.rb", "lib/merb-sexy-forms/merbtasks.rb", "lib/merb-sexy-forms/form.rb", "spec/fixture", "spec/fixture/app", "spec/fixture/app/controllers", "spec/fixture/app/controllers/application.rb", "spec/fixture/app/controllers/sexy_form.rb", "spec/fixture/app/controllers/specs_controller.rb", "spec/fixture/app/views", "spec/fixture/app/views/sexy_form_specs", "spec/fixture/app/views/sexy_form_specs/label_choice_class.html.erb", "spec/fixture/app/views/sexy_form_specs/with_labels.html.erb", "spec/fixture/config", "spec/fixture/config/init.rb.rb", "spec/fixture/config/environments", "spec/fixture/config/environments/development.rb", "spec/fixture/config/environments/production.rb", "spec/fixture/config/environments/test.rb", "spec/fixture/config/rack.rb", "spec/fixture/config/router.rb", "spec/merb_test.log", "spec/spec_helper.rb", "spec/merb-sexy-forms_spec.rb", "spec/merb-sexy-forms-form_spec.rb", "spec/merb.main.pid", "assets/stylesheets", "assets/stylesheets/sexy_forms.css", "assets/javascripts", "assets/images", "assets/images/sexy_forms", "assets/images/sexy_forms/fieldbg.gif"]
  s.has_rdoc = true
  s.homepage = %q{}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Merb plugin that provides extended builder for forms}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<merb>, [">= 1.0.6.1"])
    else
      s.add_dependency(%q<merb>, [">= 1.0.6.1"])
    end
  else
    s.add_dependency(%q<merb>, [">= 1.0.6.1"])
  end
end
