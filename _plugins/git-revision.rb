module GitRevisionFilter
  def append_revision(input)
    sha = `git rev-parse HEAD`
    "#{input}#{sha}"
  end
end

Liquid::Template.register_filter(GitRevisionFilter)
