module StrictOptions
  def strict_options!(*opts)
    @missings = []
    opts.each { |opt| @missings << ":#{opt}" unless @options[opt] }

    raise ArgumentError, "option#{s} #{@missings.join(', ')} #{is_or_are} missing" if @missings.size > 0
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
