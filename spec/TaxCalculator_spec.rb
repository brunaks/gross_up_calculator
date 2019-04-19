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
        result = TaxCalculator.new.execute(@employee)
        expect(result.taxes).to(eq([TaxInformation.new(WashingtonPaidFamilyLeave::EMPLOYEE_TAX_DESCRIPTION, 0.00, 0.00),
                                    TaxInformation.new(WashingtonPaidMedicalLeave::EMPLOYEE_TAX_DESCRIPTION, 0.00, 0.00),
                                    TaxInformation.new(WashingtonPaidMedicalLeave::EMPLOYER_TAX_DESCRIPTION, 0.00, 0.00)]))
      end
    end

    context 'if employee has wages' do

      it 'calculates taxes' do
        @employee.gross = 2500.00
        result = TaxCalculator.new.execute(@employee)
        expect(result.taxes).to(eq([TaxInformation.new(WashingtonPaidFamilyLeave::EMPLOYEE_TAX_DESCRIPTION, 3.33, 2500.00),
                                    TaxInformation.new(WashingtonPaidMedicalLeave::EMPLOYEE_TAX_DESCRIPTION, 3.00, 2500.00),
                                    TaxInformation.new(WashingtonPaidMedicalLeave::EMPLOYER_TAX_DESCRIPTION, 3.67, 2500.00)]))
      end

    end
  end
end