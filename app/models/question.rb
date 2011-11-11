class Question
  attr_reader :question, :answers, :_destroy

  def self.from_attributes(attributes)
    attributes.values.map { |q| new(q) }
  end

  def self.to_attributes(questions)
    Hash[questions.each_with_index.map { |q, i| [ i.to_s, q.attributes ] }]
  end

  def self.build
    new({ "question" => "", "answers" => {}, "_new" => true })
  end

  def self.clean(questions)
    questions.reject(&:destroy?).map { |q| q.tap(&:clean) }
  end

  def initialize(attrs)
    @question = attrs["question"]
    @answers  = attrs["answers"].values.map { |a| Answer.new(a) }
    @_destroy = attrs["_destroy"] == "1"
    @_new     = attrs["_new"]
  end

  def attributes
    { "question" => @question, "answers" => Answer.to_attributes(@answers) }
  end

  def build_answer
    @answers = @answers + [ Answer.build ]
  end

  def clean
    @answers = Answer.clean(@answers)
  end

  def destroy?
    return true  if @_destroy
    return false if @_new
    return false unless @answers.all?(&:destroy?)
    @question.blank?
  end
end
