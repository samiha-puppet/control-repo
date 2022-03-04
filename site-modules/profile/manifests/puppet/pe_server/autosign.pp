
# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include profile::puppet::pe_server::autosign
class profile::puppet::pe_server::autosign (
  String $logfile     = '/var/log/puppetlabs/puppetserver/autosign.log',
  String $journalfile = '/etc/puppetlabs/puppetserver/autosign.journal',
  String $confdir     = '/etc/puppetlabs/puppet',
  String $password    = 'Puppetlabs!'

){

  class { '::autosign':
    ensure => 'present',
    config => {
      'general'       => {
      'loglevel' => 'INFO',
      'logfile'  => $logfile,
      },
      'jwt_token'     => {
      'secret'      => fqdn_rand_string(10),
      'validity'    => '7200',
      'journalfile' => $journalfile,
      },
      'password_list' => {
        'password' => $password,
      },
    },
  }

  ini_setting {'policy-based autosigning':
    setting => 'autosign',
    path    => "${confdir}/puppet.conf",
    section => 'master',
    value   => '/opt/puppetlabs/puppet/bin/autosign-validator',
    notify  => Service['pe-puppetserver'],
    require => Class['::autosign'],
  }
}
