require 'axlsx'

class SPDXLiteXlsxGenerator < SPDXLiteGenerator
  DCIfield = [
    'SPDXVersion',	#	SPDX Version
    'DataLicense',	#	Data License
    'SPDXID',		#	SPDX Identifier
    'DocumentName',	#	Document Name
    'DocumentNamespace',	#	SPDX Document Namespace
    'Creator',		#	Creator
    'Created',		#	Created
  ]

  Packagefield = [
    'PackageName',	#	Package Name
    'SPDXID',		#	Package SPDX Identifier
    'PackageVersion',	#	Package Version
    'PackageFileName',	#	Package File Name
    'PackageDownloadLocation',	#	Package Download Location
    'FilesAnalyzed',	#	Files Analyzed
    'PackageHomePage',	#	Package Home Page
    'PackageLicenseConcluded',	#	Concluded License
    'PackageLicenseDeclared',	#	Declared License
    'PackageLicenseComments',	#	Comments on License
    'PackageCopyrightText',	#	Copyright Text
    'PackageComment',	#	Package Comment
  ]

  ExtraLicensefield = [
    'LicenseID',	#	License Identifier
    'ExtractedText',	#	Extracted Text
    'LicenseName',	#	License Name
    'LicenseComment',	#	License Comment
  ]

  Empty_col = [
    nil,	#	SPDX Version
    nil,	#	Data License
    nil,	#	SPDX Identifier
    nil,	#	Document Name
    nil,	#	SPDX Document Namespace
    nil,	#	Creator
    nil, 	#	Created
  ]

#   Empty_row = [
#     nil,	#	Package Name
#     nil,	#	Package SPDX Identifier
#     nil,	#	Package Version
#     nil,	#	Package File Name
#     nil,	#	Package Download Location
#     'true',	#	Files Analyzed
#     nil,	#	Package Home Page
#     nil,	#	Concluded License
#     nil,	#	Declared License
#     nil,	#	Comments on License
#     nil,	#	Copyright Text
#     nil,	#	Package Comment
#     nil,	#	Package Comment#ModificationRecord
#     nil,	#	Package Comment#CompileOptions
#     nil,	#	Package Comment#Any other sub-tags
#     nil,	#	Package Comment#LinkMethodology
#     nil,	#	License Identifier
#     nil,	#	Extracted Text
#     nil,	#	License Name
#     nil,	#	License Comment
#   ]

  def initialize(fn, pad)
    @filename = fn
    @nd = pad

    @license_decleared = nil
    @license_concluded = nil
    @output = false

    @row = nil

    @p = Axlsx::Package.new
    @wb = @p.workbook

    s = @wb.styles
#    @datestyle = s.add_style format_code: 'yyyy-mm-dd"T"hh:mm:ss"Z"'
    title = s.add_style bg_color: 'AACCFF'
    @sheet_dci = @wb.add_worksheet(name: 'Document Creation Information')
    @sheet_dci.add_row ['License Info. (tag)', 'value'], style: title
    @sheet_pkg = @wb.add_worksheet(name: 'Package Information')
    @sheet_pkg.add_row ['PackageName',
                        'Package SPDX Identifier',
                        'Package Version',
                        'PackageFileName',
                        'PackageDownloadLocation',
                        'Files Analyzed',
                        'PackageHomePage',
                        'Concluded License',
                        'Declared License',
                        'Comments on License',
                        'Copyright Text',
                        'Package Comment',
                        nil,
                        nil,
                        nil,
                        nil,
                        'License Identifier',
                        'Extracted Text',
                        'License Name',
                        'License Comment' ], style: title
    @sheet_pkg.add_row [nil, nil, nil, nil, nil, nil,
                        nil, nil, nil, nil, nil, nil,
                        'ModificationRecord',
                        'CompileOptions',
                        'LinkMethodology',
                        'Any other sub-tags',
                        nil, nil, nil, nil
                       ], style: title
    @col = {}
  end

  def make_empty_row
    row = []
    5.times { row.push(@nd) }
    row.push('true')
    14.times { row.push(@nd) }
    row
  end

  def fill_value(context, tag, value)
    return if SPDXLitefield.find { |s| s == tag }.nil?

    case context
    when 'document creation'
      if DCIfield.find { |d| d == tag } != nil
        if @col[tag].nil?
          @col[tag] = value
        else
          @col[tag] = @col[tag] + "\n" + value
        end
      end
    when 'package'
      if (idx = Packagefield.find_index { |d| d == tag }) != nil
        if tag == 'PackageName'
          if @row.nil?
            @sheet_dci.add_row ['SPDX Version', @col['SPDXVersion']]
            @sheet_dci.add_row ['Data License', @col['DataLicense']]
            @sheet_dci.add_row ['SPDX Identifier', @col['SPDXID']]
            @sheet_dci.add_row ['Document Name', @col['DocumentName']]
            @sheet_dci.add_row ['SPDX Document Namespace', @col['DocumentNamespace']]
            @sheet_dci.add_row ['Creator', @col['Creator']]
#              @sheet_dci.add_row ['Created', @col['Created']], style: [nil, @datestyle]
            @sheet_dci.add_row ['Created', @col['Created']]
          else
            @sheet_pkg.add_row @row
          end
          @row = make_empty_row
        end
        @row[idx] = value
#          p @row
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
      end
    when 'none'
#        p context, tag, value
      if tag == 'LicenseID'
        if @license_decleared == value || @license_concluded == value
          @output = true
          @sheet_pkg.add_row @row
          @row = make_empty_row
        else
          @output = false
        end
      end
      if @output
        @row[ExtraLicensefield.find_index { |d| d == tag } + Packagefield.length + 4] = value
        @row[5] = @nd
      end
    end
  end

  def finalize
    @sheet_pkg.add_row @row
    @p.serialize @filename
  end
end
