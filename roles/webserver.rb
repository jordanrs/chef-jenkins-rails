name "webserver"
description "basic example"
run_list(
  "recipe[apt]",

  # "recipe[database::postgresql]",
  "recipe[postgresql]",
  "recipe[postgresql::ruby]",
  "recipe[postgresql::server]",
  
  # "recipe[build-essential]",
  # "recipe[nginx]",
  # 'recipe[rvm::system]',
  # 'recipe[nodejs::install_from_package]',
  # 'recipe[user]',
  "recipe[example]"

)

default_attributes(
  # "rvm" => {
  #   'default_ruby' => 'ruby-1.9.3-p429',
  #   'global_gems' => [
  #       { 'name'    => 'bundler' },
  #       { 'name'    => 'rake' }
  #     ]
  # },
  # "node" => {
  #   'package' => 'package'
  # },
  'postgresql' => {
    'password' => {
      'postgres' => 'supersupersecure'
    } 
   }
)  
