module GitRevisionFilter
  def append_revision(input, separator = '?')
    sha = `git rev-parse HEAD`.strip
    "#{input}#{separator}#{sha}"
  end
end

Liquid::Template.register_filter(GitRevisionFilter)
