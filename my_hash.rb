# frozen_string_literal: true

class MyHash
  def initialize
    @slots = []
  end

  def get(key)
    slot = @slots[hashf(key)] || return
    slot[1][slot[0].index(key) || return]
  end

  def set(key, value)
    slot = @slots[hashf(key)] ||= [[], []]
    slot[1][slot[0].index(key)] = value
  rescue TypeError
    slot[0] << key && slot[1] << value
  end

  private

  def hashf(key)
    key.bytes.size
  end
end
