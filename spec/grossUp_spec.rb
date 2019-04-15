require_relative '../lib//grossUpCalculator.rb'
require_relative '../lib/employee.rb'

describe GrossUpCalculator do
  context 'When employee has no taxes' do
    it 'returns the gross equal to net' do
      employee = Employee.new
      employee.net = 5000.00
      gross_up_calculator = GrossUpCalculator.new(employee)
      result = gross_up_calculator.execute
      expect(result.gross).to(eq(5000.00))
    end
  end
end


