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
    sudo yum -y install @mysql
    sudo systemctl start mysqld
    sudo systemctl enable --now mysqld
    sudo systemctl status mysqld
    echo  "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root'; flush privileges;" > reset_pass.sql
    sudo mysql -u root < reset_pass.sql
    sudo mysql -uroot -proot -e "CREATE DATABASE demo"
    EOH
end
