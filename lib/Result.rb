class Result

  def initialize
    @taxes = Array.new
    @gross = 0.00
  end

  def gross
    @gross
  end

  def gross=(gross)
    @gross = gross
  end

  def taxes
    @taxes
  end

  def addTax(tax)
    @taxes.push(tax)
  end
end

class TaxInformation

  def initialize(description, tax_amount, taxable_amount)
    @description = description
    @tax_amount = tax_amount
    @taxable_amount = taxable_amount
  end

  def description
    @description
  end

  def tax_amount
    @tax_amount
  end

  def taxable_amount
    @taxable_amount
  end

  def ==(other)
    @description    == other.description  &&
    @tax_amount     == other.tax_amount   &&
    @taxable_amount == other.taxable_amount
  end

end
