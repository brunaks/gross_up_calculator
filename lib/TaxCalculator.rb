class TaxCalculator

  def initialize
  end

  def execute(employee)
    taxCalculatorForWashington = TaxCalculatorForWashington.new
    result = taxCalculatorForWashington.execute(employee)
    result
  end

end

class TaxCalculatorForWashington

  def execute(employee)
    result = Result.new
    taxes  = WashingtonPaidFamilyAndMedicalLeaveTax.new.calculate(employee)
    taxes.each do |tax|
      result.addTax(tax)
    end
    result
  end

end

class WashingtonPaidFamilyAndMedicalLeaveTax

  def initialize
    @ceiling = 132900.00
  end

  def calculate_total_premium(employee)
    if employee.year_to_date_wages == 132900.00
      total_premium = 0.00
      return total_premium
    end
    total_premium = employee.gross * 0.004
    total_premium
  end

  def round_tax(amount)
    rounded_amount = amount.round(2)
    rounded_amount
  end

  def calculate(employee)
    taxes = Array.new
    taxes.push(WashingtonPaidFamilyLeave.new.calculate(employee))
    taxes.push(WashingtonPaidMedicalLeave.new.calculate(employee))
    taxes.flatten
  end

end

class WashingtonPaidFamilyLeave < WashingtonPaidFamilyAndMedicalLeaveTax

  EMPLOYEE_TAX_DESCRIPTION = 'Paid Family Leave - Employee Premium'

  def initialize
    @description = EMPLOYEE_TAX_DESCRIPTION
    @tax_amount  = 0.00
  end

  def calculate(employee)
    tax_amount = round_tax(calculate_total_premium(employee) * 0.3333)
    TaxInformation.new(@description, tax_amount, employee.gross)
  end
end

class WashingtonPaidMedicalLeave < WashingtonPaidFamilyAndMedicalLeaveTax

  EMPLOYEE_TAX_DESCRIPTION = 'Paid Medical Leave - Employee Premium'
  EMPLOYER_TAX_DESCRIPTION = 'Paid Medical Leave - Employer Premium'

  def initialize
    @description_for_employee = EMPLOYEE_TAX_DESCRIPTION
    @description_for_employer = EMPLOYER_TAX_DESCRIPTION
  end

  def calculate(employee)
    taxes = Array.new
    taxes.push(calculate_for_employee(employee))
    taxes.push(calculate_for_employer(employee))
    taxes
  end

  def calculate_for_employee(employee)
    tax_amount = round_tax(calculate_total_premium(employee) * 0.3000)
    TaxInformation.new(@description_for_employee, tax_amount, employee.gross)
  end

  def calculate_for_employer(employee)
    tax_amount = round_tax(calculate_total_premium(employee) * 0.3667)
    TaxInformation.new(@description_for_employer, tax_amount, employee.gross)
  end

end