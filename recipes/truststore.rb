#
# Cookbook Name:: java-management
# Recipe:: truststore
#
# Copyright 2012-2013
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

def make_certfile(certalias, options)
  certificate_filename = "#{node['java']['java_home']}/jre/lib/security/truststore-#{certalias}.pem"

  file certificate_filename do
    action :create
    owner 'root'
    group 'root'
    mode 0644
    content options['certificate']
  end

  certificate_filename
end

begin
  truststore_data_bag = data_bag(node['java-management']['truststore']['data_bag'])
rescue
  Chef::Log.info("Java truststore data bag (#{node['java-management']['truststore']['data_bag']}) not found.")
ensure
  truststore_data_bag ||= []
end

truststore_data_bag.each do |certalias|
  options = data_bag_item(node['java-management']['truststore']['data_bag'], certalias)

  certificate_filename = make_certfile(certalias, options)

  java_management_truststore_certificate certalias do
    file certificate_filename
    keystore options['keystore'] if options['keystore']
    keytool options['keytool'] if options['keytool']
    storepass options['storepass'] if options['storepass']
  end
end

node['java-management']['truststore']['certificate_files'].each_pair do |certalias, options|
  if options.is_a?(String)
    certificate_filename = options
  else
    # If cert filename not provided, assume that certificate text is provided in options['certificate'].
    certificate_filename = options['file'] || make_certfile(certalias, options)
  end

  java_management_truststore_certificate certalias do
    file certificate_filename
    keystore options['keystore'] if options['keystore']
    keytool options['keytool'] if options['keytool']
    storepass options['storepass'] if options['storepass']
  end
end
