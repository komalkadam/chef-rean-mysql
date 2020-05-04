#
# Cookbook:: chef-rean-mysql
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
root_password = node['chef-rean-mysql']['root_password']
default_database = node['chef-rean-mysql']['default_database']
bash 'Install Java Open JDK 1.8' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    cd /tmp
    sudo yum -y install @mariadb
    sudo systemctl start mariadb
    sudo systemctl enable --now mariadb
    sudo systemctl status mariadb
    echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('root'); flush privileges;" > reset_pass.sql
    sudo mysql -u root < reset_pass.sql
    sudo mysql -uroot -proot -e "CREATE DATABASE demo"
    EOH
end
