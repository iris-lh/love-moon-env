require 'open3'
require 'yaml'

PWD = ENV['PWD']
DIST_DIR = "#{PWD}/dist"
SRC_DIR = "#{PWD}/src"



# desc 'Compile stacked moons into luas'
# task :compile do
#   Dir["#{SRC_DIR}/*"].map do |file|
#     build = convert_yaml "#{SRC_DIR}/build.yml"
#
#     compiled_lua = build['local'].map do |file_token|
#       compile_moon "#{SRC_DIR}/#{file_token}.moon"
#     end.join("\n\n------\n\n\n")
#
#     File.open("#{DIST_DIR}/main.lua", 'w') do |fh|
#       fh.write compiled_lua
#
#     end
#   end
# end

desc 'Compile moons into luas'
task :compile do
  Dir["#{SRC_DIR}/*"].map do |file|
    build = convert_yaml "#{SRC_DIR}/build.yml"

    compiled_lua = build['local'].map do |file_token|
      compile_moon "#{SRC_DIR}/#{file_token}.moon"
    end.join("\n\n------\n\n\n")

    File.open("#{DIST_DIR}/main.lua", 'w') do |fh|
      fh.write compiled_lua

    end
  end
end



def compile_moon(moon_file)
  stdout, stderr, status = Open3.capture3("cat #{moon_file} | moonc --")
  if stderr != ''
    message = "Failed to compile #{moon_file}"
    failed_to_compile = "#{'o-'+'-'*message.length + '-o'}\n| #{message} |\n#{'o-'+'-'*message.length + '-o'}"
    raise "\n\n#{failed_to_compile}\n\n#{stderr}
    "
  end
  stdout
end

def tokenize(file)
  file.gsub(/^.*\//, '').gsub(/\..*$/, '')
end

def convert_yaml(path)
  file = File.open("#{path}", "rb")
  contents = file.read
  YAML.load(contents)
end
