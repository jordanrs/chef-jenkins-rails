name "jenkinsbuilder"
description "basic example"
run_list(
  "recipe[apt]",
  
  "recipe[postgresql]",
  "recipe[postgresql::ruby]",
  "recipe[postgresql::server]",
  
  "recipe[build-essential]",
  "recipe[nginx::source]",
  'recipe[rvm::system]',
  'recipe[nodejs::install_from_package]',
 
  'recipe[jenkins]',
  'recipe[jenkins::proxy_nginx]',
  
  "recipe[example]"

)

default_attributes(
  "rvm" => {
    'default_ruby' => 'ruby-1.9.3-p429',
    'global_gems' => [
        { 'name'    => 'bundler' },
        { 'name'    => 'rake' }
      ], 
      'rubies' => [
        'ruby-2.0.0-p247'
      ]
  },
  "node" => {
    'package' => 'package'
  },
  'postgresql' => {
    'password' => {
      'postgres' => 'supersupersecure'
    } 
   }
)  
