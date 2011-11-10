class Quiz < ActiveRecord::Base
  def questions
    @questions ||= Question.from_json(read_attribute(:questions))
  end

  def questions=(_questions)
    @questions = _questions
    self.questions_attributes = Question.as_json(_questions)
  end

  def questions_attributes=(attrs)
    write_attribute(:questions, attrs.to_json)
  end

  def build_question
    self.questions = questions + [ Question.build ]
  end
end
