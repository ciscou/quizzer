class Answer
  attr_reader :answer

  def self.from_json(json)
    JSON.parse(json || "{}").values.map { |a| new(a) }
  end

  def self.as_json(answers)
    Hash[answers.each_with_index.map { |a, i| [ i.to_s, a.attributes ] }]
  end

  def self.build
    new({ "answer" => "" })
  end

  def initialize(attrs)
    @answer = attrs["answer"]
  end

  def attributes
    { "answer" => @answer }
  end

  def inspect
    attributes.inspect
  end
end
