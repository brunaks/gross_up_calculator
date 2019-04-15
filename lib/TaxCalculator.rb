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
    taxes  = WashingtonPaidFamilyLeaveTax.new.calculate(employee)
    taxes.each do |tax|
      result.addTax(tax)
    end
    result
  end

end

class WashingtonPaidFamilyLeaveTax

  def calculate_total_premium(employee)
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
    taxes.push(WashingtonMedicalLeave.new.calculate(employee))
    taxes.flatten
  end

end

class WashingtonPaidFamilyLeave < WashingtonPaidFamilyLeaveTax

  def initialize
    @description = 'Paid Family Leave - Employee Premium'
    @tax_amount  = 0.00
  end

  def calculate(employee)
    tax = TaxInformation.new
    tax.description = @description
    tax.tax_amount = round_tax(calculate_total_premium(employee) * 0.3333)
    tax.taxable_amount = employee.gross
    tax
  end
end

class WashingtonMedicalLeave < WashingtonPaidFamilyLeaveTax

  def initialize
    @description_for_employee = 'Paid Medical Leave - Employee Premium'
    @description_for_employer = 'Paid Medical Leave - Employer Premium'
  end

  def calculate(employee)
    taxes = Array.new
    taxes.push(calculate_for_employee(employee))
    taxes.push(calculate_for_employer(employee))
    taxes
  end

  def calculate_for_employee(employee)
    tax = TaxInformation.new
    tax.description = @description_for_employee
    tax.tax_amount = round_tax(calculate_total_premium(employee) * 0.3000)
    tax.taxable_amount = employee.gross
    tax
  end

  def calculate_for_employer(employee)
    tax = TaxInformation.new
    tax.description = @description_for_employer
    tax.tax_amount = round_tax(calculate_total_premium(employee) * 0.3667)
    tax.taxable_amount = employee.gross
    tax
  end

end