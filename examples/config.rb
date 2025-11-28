# frozen_string_literal: true

# This will be replaced with `require 'nest'` upon full release
require_relative 'nest'

def gen_info
  File.open("#{ENV['NEST_AUTOGEN']}genInfo.md", 'w') do |file|
    file.write('Hello')
  end
end

def pre_build; end

def post_build
  gen_info
end

config = SystemConfig.new
config.hostname = 'vaelixd-pc'
config.timezone = 'Australia/Sydney'
config.kernels = %w[linux-zen linux linux-lts]
config.bootloader = 'refind'
config.initramfs_generator = 'dracut'
config.pre_build = :pre_build
config.post_build = :post_build

locale = Locale.new
locale.lang = 'en_US.UTF-8'
locale.address = 'en_AU.UTF-8'

config.locale = locale

vaelixd = User.new
vaelixd.full_name = 'vaelixd'
vaelixd.user_name = 'vaelixd'
vaelixd.home_dir = '/home/vaelixd'
vaelixd.manage_home = true
vaelixd.groups = %w[wheel]

dds = User.new
dds.user_name = 'dds'

config.users = [
  vaelixd,
  dds
]

config.return_config
