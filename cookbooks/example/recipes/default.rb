nginx_site 'default' do
  enable false
end

nginx_site 'jenkins.conf' do
  config_path "/etc/nginx/sites-available/jenkins.conf"
  action :enable
end
