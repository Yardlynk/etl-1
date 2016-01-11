module ETL::Job

  # Base class for all ETL jobs
  class Base
    attr_accessor :feed_name, :schema, :reader, :load_strategy, :batch

    def initialize(params = {})
      @reader = reader
      @schema = default_schema
      @load_strategy = :unknown if @load_strategy.nil?
      @batch = {} if @batch.nil?
      @feed_name = 'UNKNOWN' if @feed_name.nil?
    end
    
    # Returns the default schema for this job. Some derived jobs may be able
    # to determine a default schema based on the destination.
    def default_schema
      nil
    end
    
    # Returns the name of this job. By default we just use the feed name but
    # derived classes may want to override this.
    def name
      @feed_name
    end

    # Initialize the logger with our job and batch info
    def logger
      l = ETL.logger
      attrs = {
        job_name: name,
        feed_name: @feed_name,
        load_strategy: @load_strategy,
        job_class_name: model().class_name,
        input_rows_processed: @reader.nil? ? nil : @reader.rows_processed,
        input_name: @reader.nil? ? "N/A" : @reader.name,
      }
      # Add the batch prefix so we can find the batch id later
      @batch.each do |k, v|
        key = ETL::Logger::BATCH_PREFIX + k.to_s
        attrs[key.to_sym] = v
      end
      l.attributes = attrs
      l
    end

    # Returns string representation of batch suitable as an identifier
    # Concatenates batch data members separated by underscores. Sorts
    # keys before concatenation so we have deterministic batch ID regardless
    # of order keys were added to hash.
    def batch_id
      return nil if @batch.nil?
      
      # get batch values sorted by keys
      values = @batch.sort.collect { |x| x[1] }
      
      # clean up each value
      values.collect! do |x|
        x = "" if x.nil?
        x.downcase.gsub(/[^a-z\d]/, "")
      end
      
      # separate by underscores
      values.join("_")
    end

    # Runs the job for the batch, keeping the status updated and handling
    # exceptions.
    def run
      logger.info("Running...")
      result = run_internal()
      logger.info("Success! #{result.message}")
      return result
    end

    # Helper function for output schema definition DSL
    def define_schema
      @schema = ETL::Schema::Table.new if @schema.nil?
      yield @schema if block_given?
    end

    # Processes a row read from the input stream and returns a row that
    # has all the columns from schema
    def read_input_row(row)
      row_out = {}
      schema.columns.each do |name, col|
        # use nil if row doesn't exist in input
        row_out[name] = row.fetch(name, nil)
      end
      row_out 
    end
  end
end
