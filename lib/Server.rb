require 'sinatra'
require_relative '../lib/TaxCalculator'
require_relative '../lib/employee'
require_relative '../lib/Result'

set :public_folder, File.dirname(__FILE__) + '/static'

get '/' do
  redirect 'index.html'
end

post '/calculate' do
  employee = Employee.new
  employee.gross = params[:gross].to_f
  result = TaxCalculator.new.execute(employee)
  erb :result_page, :locals => {:result => result}
end