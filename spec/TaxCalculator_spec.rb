require_relative '../lib/TaxCalculator'
require_relative '../lib/employee'
require_relative '../lib/grossUpCalculator'
require_relative '../lib/Result'

describe TaxCalculator do

  context 'employee lives in Washington' do
    before do
      @expected_result = Result.new
      @employee = Employee.new
      @employee.work_state = 'WA'
    end

    context 'if employee has no wages' do
      it 'calculates no taxes' do
        @employee.gross = 0.00
        taxInformation = TaxInformation.new
        taxInformation.description = 'Paid Family Leave - Employee Premium'
        taxInformation.tax_amount = 0.00
        taxInformation.taxable_amount = 0.00
        @expected_result.addTax(taxInformation)

        taxInformation = TaxInformation.new
        taxInformation.description = 'Paid Medical Leave - Employee Premium'
        taxInformation.tax_amount = 0.00
        taxInformation.taxable_amount = 0.00
        @expected_result.addTax(taxInformation)

        taxInformation = TaxInformation.new
        taxInformation.description = 'Paid Medical Leave - Employer Premium'
        taxInformation.tax_amount = 0.00
        taxInformation.taxable_amount = 0.00
        @expected_result.addTax(taxInformation)

        tax_calculator = TaxCalculator.new
        result = tax_calculator.execute(@employee)
        expect(result.taxes[0]).to(eq(@expected_result.taxes[0]))
        expect(result.taxes[1]).to(eq(@expected_result.taxes[1]))
        expect(result.taxes[2]).to(eq(@expected_result.taxes[2]))
        #expect(result.taxes).to(eq(@expected_result.taxes))
      end
    end

    context 'if employee has wages' do

      it 'calculates taxes' do
        @employee.gross = 2500.00

        taxInformation = TaxInformation.new
        taxInformation.description = 'Paid Family Leave - Employee Premium'
        taxInformation.tax_amount = 3.33
        taxInformation.taxable_amount = 2500.00
        @expected_result.addTax(taxInformation)

        taxInformation = TaxInformation.new
        taxInformation.description = 'Paid Medical Leave - Employee Premium'
        taxInformation.tax_amount = 3.0
        taxInformation.taxable_amount = 2500.00
        @expected_result.addTax(taxInformation)

        taxInformation = TaxInformation.new
        taxInformation.description = 'Paid Medical Leave - Employer Premium'
        taxInformation.tax_amount = 3.67
        taxInformation.taxable_amount = 2500.00
        @expected_result.addTax(taxInformation)

        tax_calculator = TaxCalculator.new
        result = tax_calculator.execute(@employee)
        expect(result.taxes[0]).to(eq(@expected_result.taxes[0]))
        expect(result.taxes[1]).to(eq(@expected_result.taxes[1]))
        expect(result.taxes[2]).to(eq(@expected_result.taxes[2]))
      end

    end
  end
end