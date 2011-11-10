class Quiz < ActiveRecord::Base
  def questions
    @questions ||= Question.from_json(read_attribute(:questions))
  end

  def questions=(_questions)
    @questions = Question.clean(_questions)
    write_attribute(:questions, Question.as_json(@questions).to_json)
  end

  def questions_attributes=(attrs)
    self.questions = attrs.values.map { |a| Question.new(a) }
  end

  def build_question
    self.questions = questions + [ Question.build ]
  end
end
