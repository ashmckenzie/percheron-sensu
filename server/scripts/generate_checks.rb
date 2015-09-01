#!/usr/bin/env ruby

require 'json'

input_file = ARGV[0]
output_file = ARGV[1]

fail 'Valid input and output files required' if !output_file || !File.exist?(input_file)

output = { 'checks' => {} }
source = JSON.parse(File.read(input_file))

source['aggregate_checks'].each do |check_name, check_detail|
  check_detail.merge!("handle": false, "aggregate": true)

  aggregate_check_name = '%s_aggregate' % [ check_name ]
  aggregate_check_detail = check_detail.delete('aggregate')
  aggregate_check_detail['subscribers'] = check_detail.fetch('subscribers', []) unless aggregate_check_detail['subscribers']

  output['checks'][check_name] = check_detail
  output['checks'][aggregate_check_name] = aggregate_check_detail
end

File.open(output_file, 'w') { |f| f.write(JSON.pretty_generate(output)) }
