# frozen_string_literal: true

module CodesHelper
  STATE_CODE_TYPE = 'STATE'
  GENDER_CODE_TYPE = 'GENDER'
  USER_ROLE_CODE_TYPE = 'USER_ROLE'

  def user_role_codes
    code_set(USER_ROLE_CODE_TYPE)
  end

  def user_role_desc(the_code)
    code_desc(USER_ROLE_CODE_TYPE, the_code)
  end

  def user_role_priority(the_code)
    integer_value(USER_ROLE_CODE_TYPE, the_code)
  end

  def state_codes
    code_set(STATE_CODE_TYPE)
  end

  def state_desc(state_code)
    code_desc(STATE_CODE_TYPE, state_code)
  end

  def gender_codes
    code_set(GENDER_CODE_TYPE)
  end

  def gender_desc(gender_code)
    code_desc(GENDER_CODE_TYPE, gender_code)
  end

  private

  def code_set(code_type)
    SystemCode.select(:code, :code_desc).where(code_type:).order('integer_value ASC, code ASC')
  end

  def code_desc(code_type, code)
    return unless code.present?

    system_code = SystemCode.find([code_type, code])
    system_code.code_desc
  end

  def alt_code_desc(code_type, code)
    return unless code.present?

    system_code = SystemCode.find([code_type, code])
    system_code.alt_desc
  end

  def integer_value(code_type, code)
    return unless code.present?

    system_code = SystemCode.find([code_type, code])
    system_code.integer_value
  end
end
