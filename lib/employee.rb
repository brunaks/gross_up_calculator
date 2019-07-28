class Employee

  def initialize
    @gross = 0.00
    @year_to_date_wages = 0.00
  end

  def net= net
  end

  def work_state= state
  end

  def gross=(gross)
    @gross = gross
  end

  def year_to_date_wages=(year_to_date_wages)
    @year_to_date_wages = year_to_date_wages
  end

  def taxable_amount(ceiling)
    if @year_to_date_wages == ceiling
      0.00
    else
      [@gross, (ceiling - @year_to_date_wages)].min
    end
  end

end