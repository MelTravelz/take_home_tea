class ErrorSerializer
  include JSONAPI::Serializer

  def initialize(exception, status)
    @exception = exception
    @status = status
  end

  def serializable_hash
    {
      errors: [
        {
          status: @status.to_s,
          title: @exception.class.to_s,
          detail: @exception.message
        }
      ]
    }
  end
end