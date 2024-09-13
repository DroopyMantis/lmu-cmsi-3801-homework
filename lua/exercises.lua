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
    return setmetatable({a = a, b = b, c = c, d = d}, Quaternion)
end

-- Coefficients
function Quaternion:coefficients()
    return {self.a, self.b, self.c, self.d}
end

-- Addition
function Quaternion.__add(q1, q2)
    return Quaternion.new(
        q1.a + q2.a,
        q1.b + q2.b,
        q1.c + q2.c,
        q1.d + q2.d
    )
end

-- Multiplication
function Quaternion.__mul(q1, q2)
    return Quaternion.new(
        q1.a * q2.a - q1.b * q2.b - q1.c * q2.c - q1.d * q2.d,
        q1.a * q2.b + q1.b * q2.a + q1.c * q2.d - q1.d * q2.c,
        q1.a * q2.c - q1.b * q2.d + q1.c * q2.a + q1.d * q2.b,
        q1.a * q2.d + q1.b * q2.c - q1.c * q2.b + q1.d * q2.a
    )
end

-- Conjugate
function Quaternion:conjugate()
    return Quaternion.new(self.a, -self.b, -self.c, -self.d)
end

-- String representation
function Quaternion:__tostring()
    local str = ""
    if self.a ~= 0 then str = str .. tostring(self.a) end

    if self.b ~= 0 then
        if self.b > 0 and str ~= "" then str = str .. "+" end
        if self.b == -1 then
            str = str .. "-i"
        elseif self.b == 1 then
            str = str .. "i"
        else
            str = str .. tostring(self.b) .. "i"
        end
    end

    if self.c ~= 0 then
        if self.c > 0 and str ~= "" then str = str .. "+" end
        if self.c == -1 then
            str = str .. "-j"
        elseif self.c == 1 then
            str = str .. "j"
        else
            str = str .. tostring(self.c) .. "j"
        end
    end

    if self.d ~= 0 then
        if self.d > 0 and str ~= "" then str = str .. "+" end
        if self.d == -1 then
            str = str .. "-k"
        elseif self.d == 1 then
            str = str .. "k"
        else
            str = str .. tostring(self.d) .. "k"
        end
    end

    if str == "" then str = "0" end
    return str
end

-- Equality
function Quaternion.__eq(q1, q2)
    return q1.a == q2.a and q1.b == q2.b and q1.c == q2.c and q1.d == q2.d
end