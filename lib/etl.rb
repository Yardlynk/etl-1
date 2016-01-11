module ETL
  # The root directory of the etl code tree
  def ETL.root
    File.expand_path('../..', __FILE__)
  end
end

# Set up application context
require 'etl/context'

# Process our configuration files
require 'etl/config'
    
# Include the rest of code needed for ETL system
require 'etl/core'

# Create objects that exist in ETL module
require 'etl/init'
