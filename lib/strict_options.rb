module StrictOptions
  def strict_options!(opts)
    @missings = []
    opts.each { |opt| @missings << ":#{opt}" unless @options[opt] }

    raise ArgumentError, "options #{@missings.join(', ')} #{is_or_are} missing" if @missings.size > 0
  end

  def is_or_are
    return if @missings.empty?

    @missings.size > 1 ? 'are' : 'is'
  end
end
