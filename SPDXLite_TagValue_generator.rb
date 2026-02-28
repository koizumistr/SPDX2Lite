class SPDXLiteTagValueGenerator < SPDXLiteGenerator
  def initialize
    @license_decleared = nil
    @license_concluded = nil
    @output = false
  end

  def fill_value(context, tag, value)
    return if SPDXLitefield.find { |s| s == tag }.nil?

    print "\n" if tag == 'PackageName'
    @license_concluded = value if tag == 'PackageLicenseConcluded' && value.include?('LicenseRef-')
    @license_decleared = value if tag == 'PackageLicenseDeclared' && value.include?('LicenseRef-')

    if ['document creation', 'package'].include?(context)
      print tag, ': ', value, "\n"
    elsif context == 'none'
      #        p context, tag, value
      if tag == 'LicenseID'
        if [@license_decleared, @license_concluded].include?(value)
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
