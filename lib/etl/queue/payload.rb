require 'json'
require 'etl/util/hash_util'
module ETL::Queue

  # Class representing the payload we are putting into and off the job queue
  class Payload
    attr_accessor :job_id, :batch

    def job_model
      ETL::Model::Job[@job_id]
    end
    
    def to_s
      "Payload[job_id=#{@job_id}, batch=#{@batch}]"
    end
    
    # encodes the payload into a string for storage in a queue
    def encode
      h = @batch.clone
      h[:job_id] = @job_id
      h.to_json.to_s
    end
    
    # creates a new Payload object from a string that's been encoded (e.g.
    # one that's been popped off a queue)
    def self.decode(str)
      h = ETL::HashUtil.symbolize_keys(JSON.parse(str))
      payload = ETL::Queue::Payload.new
      payload.job_id = params[:job_id]
      payload.batch = params[:batch]
      payload
  end
end
