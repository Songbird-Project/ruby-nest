# frozen_string_literal: true

# Class used to store system configuration
class SystemConfig
  attr_reader :os_info
  attr_accessor :hostname

  def initialize
    @os_info = {}
    read_os_info

    @hostname = @os_info['id']
  end

  private

  def read_os_info
    File.open('/etc/os-release', 'r') do |file|
      file.each_line do |line|
        line = line.strip

        next if line.nil? || line.empty? || !line.include?('=')

        key, _, value = line.partition('=')
        value = value.delete("\"'")

        @os_info[key.downcase] = value
      end
    end
  end
end

puts "hostname,#{SystemConfig.new.hostname}"
