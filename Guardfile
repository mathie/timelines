directories %w(app lib config spec)

guard :bundler do
  watch('Gemfile')
end

guard :rspec, cmd: 'bin/rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }

  watch(%r{spec/(spec|rails)_helper.rb})  { "spec" }

  watch(%r{^app/controllers/(.+)_controller\.rb$}) do |m|
    [
      "spec/routing/#{m[1]}_controller_routing_spec.rb",
      "spec/controllers/#{m[1]}_controller_spec.rb",
      "spec/features/#{m[1]}_spec.rb"
    ]
  end

  watch(%r{^spec/fixtures/(.+)s\.yml$}) do |m|
    [
      "spec/features/#{m[1]}s_spec.rb",
      "spec/models/#{m[1]}_spec.rb",
      "spec/controllers/#{m[1]}s_controller_spec.rb"
    ]
  end

  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }

  watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$}) { |m| "spec/features/#{m[1]}_spec.rb" }
end

