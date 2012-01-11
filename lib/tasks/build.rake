desc 'Build the zip for this project inside the build directory'
task :build do 
  # Make a temporary working directory.
  mkdir_p config[:working_dir]
  
  # Recursively copy the build directories.
  config[:build_dirs].each do |dir| 
   begin
     cp_r dir, config[:working_dir]
   rescue StandardError => err
   end
  end
  
  # Copy the single build files.
  cp config[:build_files], config[:working_dir]
  
  # Zip up the contents.
  sh %{ cd #{config[:tmp_dir]} && zip -r #{config[:project_name]}.zip #{config[:project_name]} }
  
  # Make the build directory if it doesn't exist.
  mkdir_p config[:build_dir]
  
  # Move the zip file to the build directory.
  mv File.join(config[:working_dir],"..","#{config[:project_name]}.zip"), config[:build_dir]
  
  # Remove the tmp directory which includes the working directory.
  rm_r config[:tmp_dir] 
end

def config
  return @config unless @config.nil?
  
  config_file = YAML.load_file(File.join(File.dirname(__FILE__),'config','build.yml'))
  
  if config_file == false
    config_file = Hash.new
  end
  
  build_dirs = nil
  unless config_file["directories"]
    build_dirs = FileList.new("blocks","controllers","css","elements","images","js","models","single_pages","themes","tools")
  else 
    build_dirs = FileList.new(config_file["directories"])
  end
  
  single_files = nil
  unless config_file["single_files"]
    single_files = FileList.new("controller.php","db.xml")
  else 
    single_files = FileList.new(config_file["single_files"])
  end
  
  @config = {
    :build_dirs   => build_dirs,
    :build_files  => single_files,
    :project_name => config_file["project_name"] || Dir.pwd.split(File::SEPARATOR)[-1],
    :tmp_dir      => config_file["tmp_dir"] || "tmp",
    :build_dir    => config_file["build_dir"] || "build"
  }
  @config[:working_dir] = File.join(@config[:tmp_dir], @config[:project_name])
  @config
end