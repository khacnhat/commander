
def cyber_dojo_sh
  help = [
    '',
    "Use: #{me} sh SERVICE",
    '',
    'Shells into a service container',
    "Example: #{me} sh web",
    "Example: #{me} sh storer"
  ]

  service = ARGV[1]
  if [nil,'--help'].include? service
    show help
    exit succeeded
  end

  if ARGV.size > 2
    show help
    exit failed
  end

  # [cyber-dojo] script does the actual [sh]

end
