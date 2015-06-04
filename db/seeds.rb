###############################################################################
# Copyright (C) 2015 Chuck Smith
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
###############################################################################

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



### JobRunStatus ###
[
  { label: :new, name: "New" },
  { label: :blocked, name: "Blocked on Dependencies" },
  { label: :ready, name: "Ready to Run" },
  { label: :running, name: "Running" },
  { label: :success, name: "Success" },
  { label: :error, name: "Error" },
].each do |v|
  jrs = JobRunStatus.find_by(label: v[:label])
  jrs = JobRunStatus.new if jrs.nil?
  jrs.label = v[:label]
  jrs.name = v[:name]
  jrs.save
end
