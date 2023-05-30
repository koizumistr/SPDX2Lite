class SPDXLiteTagValueGenerator < SPDXLiteGenerator
  def initialize
    @license_decleared = nil
    @license_concluded = nil
    @output = false
  end

  def fill_value(context, tag, value)
    return if SPDXLitefield.find { |s| s == tag }.nil?

    print "\n" if tag == 'PackageName'
    if tag == 'PackageLicenseConcluded'
      if value.include? 'LicenseRef-'
        @license_concluded = value
      end
    end
    if tag == 'PackageLicenseDeclared'
      if value.include? 'LicenseRef-'
        @license_decleared = value
      end
    end
    if context == 'document creation' || context == 'package'
      print tag, ': ', value, "\n"
    elsif context == 'none'
      #        p context, tag, value
      if tag == 'LicenseID'
        if @license_decleared == value || @license_concluded == value
          print "\n"
          @output = true
        else
          @output = false
        end
      end

      print tag, ': ', value, "\n" if @output
    end
  end
end
