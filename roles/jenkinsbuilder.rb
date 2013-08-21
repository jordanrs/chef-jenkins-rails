name "jenkinsbuilder"
description "basic example"
run_list(
  "recipe[apt]",
  
  "recipe[postgresql]",
  "recipe[postgresql::ruby]",
  "recipe[postgresql::server]",
  
  "recipe[build-essential]",
  "recipe[git]",
  
  "recipe[nginx::source]",
  
  'recipe[nodejs::install_from_package]',
 
  'recipe[jenkins]',
  'recipe[jenkins::proxy_nginx]',
  'recipe[libqt4]',
  "recipe[xvfb]",
  "recipe[example]"
)

default_attributes(
  "node" => {
    'package' => 'package'
  },
  'postgresql' => {
    'password' => {
      'postgres' => 'supersupersecure'
    } 
   },
   'jenkins' => {
     'server' => {
       'plugins' => ['ruby', 'git']
     }
   }
)  
