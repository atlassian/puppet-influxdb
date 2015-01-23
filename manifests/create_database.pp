# == Type: influxdb::create_database
define influxdb::create_database (
  $api_url        = "${influxdb::params::hostname}:${influxdb::params::api_port}/db",
  $admin_user     = $influxdb::params::admin_user,
  $admin_password = $influxdb::params::admin_password,
) {

  exec { "create database ${title}":
    path      => '/bin:/usr/bin',
    command   => "curl -s -X POST '${api_url}?u=${admin_user}&p=${admin_password}'  -d '{\"name\": \"${title}\"}'",
    tries     => 3,
    try_sleep => 3,
    unless    => "curl -s -X POST '${api_url}?u=${admin_user}&p=${admin_password}' -d '{\"name\": \"${title}\"}' | grep -q 'exists'",
  }
}
