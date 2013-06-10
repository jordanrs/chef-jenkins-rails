# include_recipe 'apt' 

# gem_package 'bundler' do
#   gem_binary '/usr/local/bin/gem'
#   options '--no-ri --no-rdoc'
# end

app_name = 'practice_rails'

# rvm_gemset "ruby-1.9.3-p429@rails"


common = {:name => "#{app_name}", :app_root => "/u/apps/#{app_name}", :user => 'ubuntu', :group => 'ubuntu'}
# 
# # # we create new user that will run our application server
# user_account 'deployer' do
#   create_group true
#   ssh_keygen false
#   # ssh_keys 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCWZT6yHhbo7Tz0t+pKIynVlShW0hybMP+nITXrKRgrDeljBpvPyZzg+ABHY7GXDwcLm5mabzfKYIr/xafb+d27gypeVSeujMIPG/Ur8gpSZ+gws/OFdhcDTrL1Nv8p+mG2UGTjPx3IbF9LxuA4FBW/kEEnI6OyfBB7oEAL2ZfzuOBh68qvNaQLGcOVFFxSnMQ/7ZKMmRDvp/jDO0RhnjGvG3Vy13RxtG7onK25hdzt4C7BYFvsS4uZxlDR0/xpRaxEoNjlI1DSAyifPY+FWYkykcxAd5pxOagQMPaDiYFIFjzG3xNqOYz4kxrdwDL/wmq51CtXfgIT4EaYVGwGYDfF'
# end

group "ubuntu" do
  action :create
  members "ubuntu"
  append true
end

postgresql_connection_info = {:host => "localhost",
                              :port => node['postgresql']['config']['port'],
                              :username => 'postgres',
                              :password => node['postgresql']['password']['postgres']}
                              
postgresql_database app_name do
  connection postgresql_connection_info
  action :create
end

postgresql_database_user 'rails' do
  connection postgresql_connection_info
  password 'supersecret'
  action :create
end

postgresql_database_user 'rails' do
  connection postgresql_connection_info
  database_name app_name
  privileges [:all]
  action :grant
end

# 
# directory common[:app_root] do
#   owner common[:user] 
#   group common[:group] 
#   recursive true
# end
# 
# directory common[:app_root] + "/current" do
#   owner common[:user] 
#   group common[:group]
# end
# 
# directory common[:app_root] + "/releases" do
#   owner common[:user] 
#   group common[:group]
# end
# 
# directory common[:app_root] + "/shared" do
#   owner common[:user] 
#   group common[:group]
# end
# 
# directory '/etc/unicorn' do
#   owner common[:user] 
#   group common[:group]
# end
# # 
# %W(config log tmp sockets pids).each do |dir|
#   directory "#{common[:app_root]}/shared/#{dir}" do
#     owner common[:user] 
#     group common[:group]
#     recursive true
#     mode 0755
#   end
# end
# 
# nginx_config_path = "/etc/nginx/sites-available/#{common[:name]}.conf"
# 
# template nginx_config_path do
#   mode 0644
#   source "nginx.conf.erb"
#   variables common.merge(:server_names => "kayak.test")
#   notifies :reload, "service[nginx]"
# end
# 
# template "/etc/unicorn/#{common[:name]}.conf.rb" do
#   mode 0644
#   source "unicorn.conf.erb"
#   variables common
# end
# 
# nginx_site common[:name] + '.conf' do
#   config_path nginx_config_path
#   action :enable
# end