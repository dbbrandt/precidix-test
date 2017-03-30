
require 'rubygems'
require 'cucumber/rake/task'


desc "List of available tags for tags for specific features"
task :tag_help do
  @help_string = <<-EOF
    List of available tags for testing specific features
    coach
  EOF
  puts @help_string
end

desc "Run a test for a specific tag"
task :tag_run, :tag, :format do |t, args|
  tag = args[:tag] || 'coach'
  format = args[:format] || 'html'
  time = Time.new
  result_time = time.strftime("%y%m%d")
  Cucumber::Rake::Task.new(:run) do |t|
    t.cucumber_opts = "features/*
             --format #{format} -o results/#{tag}_#{result_time}.#{format}
             --no-source
             --tag @#{tag}"
  end
  Rake::Task[:run].invoke()
end

task :default => :tag_run