# If you ever see a Rakefile, run
#
#   rake -T
#
# to get a list of all available "rake commands."

require 'rake'

def prompt(msg)
  print "#{msg} (y/n) "

  case STDIN.gets.chomp.downcase
  when 'y', 'yes'
    :yes
  when 'n', 'no'
    :no
  end
end

desc 'Start IRB with application environment loaded'
task :console do
  exec 'irb -r./setup -r./database -r./app'
end
