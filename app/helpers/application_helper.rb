module ApplicationHelper
  def commas_separated_number(number)
    _number = ActiveSupport::NumberHelper.number_to_delimited(
      number,
      delimiter_pattern: /(\d+?)(?=(\d\d)+(\d)(?!\d))/
    )

    "Rs. #{_number}"
  end
end
