require './SPDX_parser'
require './SPDXLite_generator'
require './SPDXLite_TagValue_generator'
require './SPDXLite_xlsx_generator'

require 'optparse'

params = {}
opt = OptionParser.new
opt.on('-x VAL') # { |v| p v }
opt.on('-n pad') # { |v| p v }

opt.parse!(ARGV, into: params)
#p ARGV
#p params

if ARGV.length != 1
  puts "Usage: SPDX2Lite.rb [-x OUTPUTFILE] [-n PAD] YOURSPDXFILE"
  exit(false)
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
