require './SPDX_parser'
require './SPDXLite_generator'
require './SPDXLite_TagValue_generator'
require './SPDXLite_xlsx_generator'

require 'optparse'

params = {}
opt = OptionParser.new
opt.version = [1, 2]
opt.banner = 'Usage: SPDX2Lite.rb [option] YOURSPDXFILE'
opt.on('-x OUTPUTFILE', 'output xlsx file') # { |v| p v }
opt.on('-n PAD', 'define padding character(s)') # { |v| p v }

begin
  opt.parse!(ARGV, into: params)
# p ARGV
# p params
rescue OptionParser::ParseError => e
  puts "Error: #{e.message}"
  puts opt.help
  exit(-1)
end

if ARGV.length != 1
  puts opt.help
  exit(-2)
end

f = File.open(ARGV[0])
parser = SPDXParser.new(f)
g = if !params[:x].nil?
      filename = if File.extname(params[:x]) == ''
                   "#{params[:x]}.xlsx"
                 else
                   params[:x]
                 end
      pad = if !params[:n].nil?
              params[:n]
            else
              '-'
            end
      SPDXLiteXlsxGenerator.new(filename, pad)
    else
      SPDXLiteTagValueGenerator.new
    end

g.fill_value(parser.context, parser.tag, parser.value) until parser.parse.nil?
g.finalize
