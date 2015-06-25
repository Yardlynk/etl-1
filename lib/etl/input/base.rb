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

module ETL::Input
  class Base

    attr_accessor :rows_processed

    def initialize
      @rows_processed = 0
    end

    # Reads each row from the input file and passes it to the specified
    # block. By default does nothing, which is likely an error.
    def each_row
      Rails.logger.warning("Called ETL::Input::Base::each_row()")
    end

    # Reads rows in batches of specified size from the input source and
    # passes them as an array to the specified block. By default we just
    # put a wrapper around each_row that collects rows into an array. 
    # Derived classes can implement more intelligent batching logic if the 
    # input source supports it.
    def each_row_batch(batch_size = 100)
      batch = []
      each_row do |row_in|
        batch << row_in
        if batch.length >= batch_size
          yield batch
          batch = []
        end
      end
      yield batch if batch.length > 0
    end
  end
end