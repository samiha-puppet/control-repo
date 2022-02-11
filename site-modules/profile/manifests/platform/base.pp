# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include profile::platform::base
class profile::platform::base {
  class { 'motd':
    content => "Hello world!\n",
  }
}
