
def cyber_dojo_update
  help = [
    '',
    "Use: #{me} update",
    '',
    'Updates all cyber-dojo server and language images and the cyber-dojo script file',
  ]

  if ARGV[1] == '--help'
    show help
    exit succeeded
  end

  # unknown arguments?
  args = ARGV[1..-1]
  args.each do |arg|
    STDERR.puts "FAILED: unknown argument [#{arg}]"
  end
  exit failed unless args == []

  cyber_dojo_update_server
  cyber_dojo_update_languages
  # cyber-dojo script updates itself
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - -

def cyber_dojo_update_server
  # I'd like to get these image names directly from docker-compose.yml
  # but there does not seem to be a simple way to do that :-(
  service_images = %w(
    nginx
    web
    runner-stateless
    starter
    saver
    mapper
    differ
    zipper
    prometheus
    grafana
  )
  service_images.each do |name|
    # use system() so pulls are visible in terminal
    system "docker pull cyberdojo/#{name}:latest"
  end
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - -

def cyber_dojo_update_languages
  cmd = "docker images --format '{{.Repository}}' | grep cyberdojofoundation"
  stdout = `#{cmd}`
  language_images = stdout.split("\n")
  language_images.each do |name|
    system "docker pull #{name}"
  end
end
