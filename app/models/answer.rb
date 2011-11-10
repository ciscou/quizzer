class Answer
  attr_reader :answer, :_destroy

  def self.from_json(json)
    JSON.parse(json || "{}").values.map { |a| new(a) }
  end

  def self.as_json(answers)
    Hash[answers.each_with_index.map { |a, i| [ i.to_s, a.attributes ] }]
  end

  def self.build
    new({ "answer" => "", "_new" => true })
  end

  def self.clean(answers)
    answers.reject(&:destroy?)
  end

  def initialize(attrs)
    @answer   = attrs["answer"]
    @_destroy = attrs["_destroy"] == "1"
    @_new     = attrs["_new"]
  end

  def as_json
    { "answer" => @answer }
  end

  def attributes
    { "answer" => @answer }
  end

  def destroy?
    return true  if @_destroy
    return false if @_new
    @answer.blank?
  end

  def inspect
    attributes.inspect
  end
end
