function change(amount)
  if math.type(amount) ~= "integer" then
    error("Amount must be an integer")
  end
  if amount < 0 then
    error("Amount cannot be negative")
  end
  local counts, remaining = {}, amount
  for _, denomination in ipairs({25, 10, 5, 1}) do
    counts[denomination] = remaining // denomination
    remaining = remaining % denomination
  end
  return counts
end

-- Write your first then lower case function here
function first_then_lower_case(arr, predicate)
  if #arr == 0 then -- Check if the array is empty
      return nil
  end

  for _, value in ipairs(arr) do -- Find first element that satisfies predicate
      if predicate(value) then
          return string.lower(value)
      end
  end

  return nil -- Nil if no element satisfies predicate
end

-- Write your powers generator here
function powers_generator(base, limit)
  return coroutine.create(function() -- Create the coroutine
      local power = 1 -- Initialize power
      while power <= limit do 
          coroutine.yield(power) 
          power = power * base -- Yeilds power until limit is reached
      end
  end)
end

-- Write your say function here
function say(word)
  local words = {} -- Empty table to store words
  
  if word then
      table.insert(words, word)
  else
    return ""
  end -- Store argument in table or return "" if no words passed

  return function(next_word)
      if next_word then
          table.insert(words, next_word)
          return say(table.concat(words, " ")) -- Continue the chain
      else
          return table.concat(words, " ") -- End the chain and return the sentence
      end
  end
end
  
-- Write your line count function here
function meaningful_line_count(filename)
  local file, err = io.open(filename, "r")
  if not file then
      error("No such file" .. err) -- Throws error
  end

  local count = 0
  for line in file:lines() do
      if line:match("%S") and not line:match("^%s*#") then -- Check if line is non-empty, not whitespace only, and doesn't start with '#'
          count = count + 1
      end
  end

  file:close()
  return count
end

-- Write your Quaternion table here
Quaternion = {}
Quaternion.__index = Quaternion

-- Constructor
function Quaternion.new(a, b, c, d)
    local self = setmetatable({}, Quaternion)
    self.a = a
    self.b = b
    self.c = c
    self.d = d
    return self
end

-- Addition (q1 + q2)
function Quaternion.__add(q1, q2)
    return Quaternion.new(
        q1.a + q2.a,
        q1.b + q2.b,
        q1.c + q2.c,
        q1.d + q2.d
    )
end

-- Multiplication (q1 * q2)
function Quaternion.__mul(q1, q2)
    local a = q1.a * q2.a - q1.b * q2.b - q1.c * q2.c - q1.d * q2.d
    local b = q1.a * q2.b + q1.b * q2.a + q1.c * q2.d - q1.d * q2.c
    local c = q1.a * q2.c - q1.b * q2.d + q1.c * q2.a + q1.d * q2.b
    local d = q1.a * q2.d + q1.b * q2.c - q1.c * q2.b + q1.d * q2.a
    return Quaternion.new(a, b, c, d)
end

-- Equality (q1 == q2)
function Quaternion.__eq(q1, q2)
    return q1.a == q2.a and q1.b == q2.b and q1.c == q2.c and q1.d == q2.d
end

-- Coefficients
function Quaternion:coefficients()
    return {self.a, self.b, self.c, self.d}
end

-- Conjugate
function Quaternion:conjugate()
    return Quaternion.new(self.a, -self.b, -self.c, -self.d)
end

-- String representation
function Quaternion:__tostring()
    local parts = {}
    if self.a ~= 0 then
        table.insert(parts, tostring(self.a))
    end
    if self.b ~= 0 then
        table.insert(parts, (self.b > 0 and "+" or "") .. tostring(self.b) .. "i")
    end
    if self.c ~= 0 then
        table.insert(parts, (self.c > 0 and "+" or "") .. tostring(self.c) .. "j")
    end
    if self.d ~= 0 then
        table.insert(parts, (self.d > 0 and "+" or "") .. tostring(self.d) .. "k")
    end
    if #parts == 0 then
        return "0"
    end
    return table.concat(parts)
end

-- Quaternion not finished, still failing 4 testers 