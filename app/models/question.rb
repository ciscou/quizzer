class Question
  attr_reader :question, :answers

  def self.from_json(json)
    JSON.parse(json || "{}").values.map { |q| new(q) }
  end

  def self.as_json(questions)
    Hash[questions.each_with_index.map { |q, i| [ i.to_s, q.as_json ] }]
  end

  def self.build
    new({ "question" => "", "answers" => {} })
  end

  def initialize(attrs)
    @question = attrs["question"]
    @answers  = attrs["answers"].values.map { |a| Answer.new(a) }
  end

  def as_json
    { "question" => @question, "answers" => Answer.as_json(@answers) }
  end

  def attributes
    { "question" => @question, "answers" => @answers.map(&:attributes) }
  end

  def inspect
    attributes.inspect
  end

  def build_answer
    @answers = @answers + [ Answer.build ]
  end
end
