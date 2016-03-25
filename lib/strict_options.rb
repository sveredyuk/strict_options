module StrictOptions
  def strict_options!(*opts, exception_class: ArgumentError,
                             exception_message: nil)
    @missings = []
    opts.each { |opt| @missings << ":#{opt}" unless @options[opt] }
    msg = exception_message || "option#{s} #{@missings.join(', ')} #{is_or_are} missing"
    raise exception_class, msg if @missings.size > 0
  end

  private

  def is_or_are
    return if @missings.empty?

    @missings.size > 1 ? 'are' : 'is'
  end

  def s
    return if @missings.empty?

    @missings.size > 1 ? 's' : ''
  end
end
