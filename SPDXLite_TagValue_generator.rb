class SPDXLiteTagValueGenerator < SPDXLiteGenerator
  def initialize
    @license_decleared = nil
    @license_concluded = nil
    @output = false
  end

  def fill_value(context, tag, value)
    if SPDXLitefield.find {|s| s == tag} != nil
      if tag == "PackageName"
        print "\n"
      end
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
        print tag, ": ", value, "\n"
      elsif context == "none"
#        p context, tag, value
        if tag == "LicenseID"
          if (@license_decleared == value || @license_concluded == value)
            print "\n"
            @output = true
          else
            @output = false
          end
        end
        if @output 
          print tag, ": ", value, "\n"
        end
      end
    end
  end
end
