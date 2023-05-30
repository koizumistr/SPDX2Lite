class SPDXParser
  attr_reader :context, :tag, :value

  def initialize(file)
    @spdxfile = file

    @context = 'document creation'
  end

  def parse
    @spdxfile.gets
    return nil if $_.nil?

#    p $_
    item = /(?<tag>[A-Za-z0-9]+):[ \t](?<value>.*)/.match($_)
    while item.nil?
      @spdxfile.gets
#      p $_
      return nil if $_.nil?

      item = /(?<tag>[A-Za-z0-9]+):[ \t](?<value>.*)/.match($_)
    end
    @tag = item[:tag]
    case @tag
    when 'PackageName'
      @context = 'package'
    when 'FileName'
      @context = 'file'
    when 'SnippetSPDXID'
      @context = 'snippet'
    when 'LicenseID'
      @context = 'none'
    end
    @value = item[:value]
    if item[:value].start_with?('<text>')
      unless item[:value].end_with?('</text>')
        @value += "\n" if @value.length > 6
        @value += $_ until @spdxfile.gets.end_with?("</text>\n")
        @value = @value.chomp + $_.chomp
      end
    end
    $_
  end
end
