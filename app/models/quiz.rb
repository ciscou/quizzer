class Quiz < ActiveRecord::Base
  def questions
    @questions ||= begin
      json = read_attribute(:questions)
      if json.present?
        Question.from_attributes(JSON.parse(json))
      else
        []
      end
    end
  end

  def questions=(_questions)
    @questions = Question.clean(_questions)
    write_attribute(:questions, Question.to_attributes(@questions).to_json)
  end

  def questions_attributes=(attrs)
    self.questions = attrs.values.map { |a| Question.new(a) }
  end

  def build_question
    self.questions = questions + [ Question.build ]
  end
end
