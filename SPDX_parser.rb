class SPDXParser
  attr_reader :context, :tag, :value

  def initialize(file)
    @spdxfile = file

    @context = "document creation"
  end

  def parse
    @spdxfile.gets
    if $_.nil?
      return nil
    end
#    p $_
    item = /(?<tag>[A-Za-z0-9]+):[ \t](?<value>.*)/.match($_)
    until not item.nil?
      @spdxfile.gets
#      p $_
      if $_.nil?
        return nil
      end
      item = /(?<tag>[A-Za-z0-9]+):[ \t](?<value>.*)/.match($_)
    end
    @tag = item[:tag]
    case @tag
    when 'PackageName'
      @context = "package"
    when 'FileName'
      @context = "file"
    when 'SnippetSPDXID'
      @context = "snippet"
    when 'LicenseID'
      @context = "none"
    end
    if item[:value].start_with?("<text>")
      @value = item[:value]
      if not item[:value].end_with?("</text>")
        if  @value.length > 6
          @value = @value + "\n"
        end
        until @spdxfile.gets.end_with?("</text>\n")
          @value = @value + $_
        end
        @value = @value.chomp + $_.chomp
      end
    else
      @value = item[:value]
    end
    $_
  end
end
