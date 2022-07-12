require './SPDX_parser'
require './SPDXLite_generator'
require './SPDXLite_TagValue_generator'
require './SPDXLite_xlsx_generator'

require 'optparse'

params = {}
opt = OptionParser.new
opt.version = [1, 2]
opt.banner = "Usage: SPDX2Lite.rb [option] YOURSPDXFILE"
opt.on('-x OUTPUTFILE', 'output xlsx file') # { |v| p v }
opt.on('-n PAD', 'define padding character(s)') # { |v| p v }

begin
  opt.parse!(ARGV, into: params)
#p ARGV
#p params
rescue
  puts opt.help
  exit(-1)
end

if ARGV.length != 1
  puts opt.help
  exit(-2)
end

f = File.open(ARGV[0])
parser = SPDXParser.new(f)
if not params[:x].nil?
  if File.extname(params[:x]) == ""
    filename = params[:x] + ".xlsx"
  else
    filename = params[:x]
  end
  if not params[:n].nil?
    pad = params[:n]
  else
    pad = '-'
  end
  g = SPDXLiteXlsxGenerator.new(filename, pad)
else
  g = SPDXLiteTagValueGenerator.new
end
until parser.parse.nil? do
  g.fill_value(parser.context, parser.tag, parser.value)
end
g.finalize
