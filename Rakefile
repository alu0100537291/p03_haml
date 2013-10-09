desc "Arracar aplicación"
task :default => :server

desc "run server"
task :server do	
sh "rackup"
end

# Arractar el servidor con 'rake'
# En una nueva terminal, 'rake rock', 'rake paper', 'rake scissors'
desc "run the client with rock"
task :rock do
  sh %{curl -v 'http://localhost:9292?choice=rock'}
end

desc "run the client with paper"
task :paper do
  sh %q{curl -v 'http://localhost:9292?choice=paper'}
end

desc "run the client with scissors"
task :scissors do
  sh %q{curl -v 'http://localhost:9292?choice=scissors'}
end