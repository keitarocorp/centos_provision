require 'pathname'
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', Pathname.new(__FILE__).realpath)

require 'rubygems'
require 'bundler/setup'

class Installer
  INSTALLER_ROOT = File.expand_path(File.dirname(__FILE__) + '/../')
  INSTALLER_CMD = 'install.sh'
  DEFAULT_DOCKER_IMAGE = 'centos'

  attr_accessor :env, :args, :prompts_with_values, :docker_image
  attr_reader :stdout, :stderr, :ret_value

  def initialize(env: {}, args: '', prompts_with_values: {}, docker_image: DEFAULT_DOCKER_IMAGE)
    @env, @args, @prompts_with_values, @docker_image = env, args, prompts_with_values, docker_image
  end

  def call
    Dir.mktmpdir('', '/tmp') do |current_dir|
      Dir.chdir(current_dir) do
        FileUtils.copy("#{INSTALLER_ROOT}/bin/#{INSTALLER_CMD}", './')
        invoke_installer_cmd(current_dir)
      end
    end
  end

  def self.docker_installed?
    system("sh -c 'command -v docker > /dev/null'")
  end

  private

  def invoke_installer_cmd(current_dir)
    Open3.popen3(installer_cmd(current_dir)) do |stdin, stdout, stderr, wait_thr|
      stdout.sync = true
      stdin.sync = true

      @stdout = emulate_interactive_io(stdin, stdout)
      @stderr = Thread.new { stderr.read }.value
      @ret_value =  wait_thr.value
    end
  end

  def installer_cmd(current_dir)
    "docker run #{docker_env} -i --rm -v #{current_dir}:/data -w /data #{docker_image} ./#{INSTALLER_CMD} #{args}"
  end

  def docker_env
    env.map { |key, value| "-e #{key}=#{value}"}.join(' ')
  end

  def emulate_interactive_io(stdin, stdout)
    out = ''
    reader_thread = Thread.new {
      begin
        stdout_chunk = read_stream(stdout)
        break if stdout_chunk.nil?

        out << stdout_chunk
        prompt = stdout_chunk.split("\n").last
        stdin.puts(prompts_with_values[prompt])
      end while true
    }
    reader_thread.join
    out
  end

  def read_stream(stdout)
    buffer = ''

    begin
      char = stdout.getc
      return if char.nil?

      buffer << char
    end while char != '>'

    buffer << stdout.getc
    buffer
  end
end

begin
  unless Installer.docker_installed?
    puts 'You need to install the docker for running this specs'
  end
end

