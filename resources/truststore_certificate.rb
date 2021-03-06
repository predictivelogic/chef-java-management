#
# Cookbook Name:: java-management
# Resource:: truststore_certificate
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

actions :import

attribute :alias, :kind_of => String, :name_attribute => true
attribute :file, :kind_of => String, :default => nil
attribute :certificate, :kind_of => String, :default => nil
attribute :keystore, :kind_of => String, :default => nil
attribute :keytool, :kind_of => String, :default => nil
attribute :storepass, :kind_of => String, :default => nil

def initialize(*args)
  super
  @action = :import
end
