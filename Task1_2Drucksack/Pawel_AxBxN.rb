# frozen_string_literal: true


def maxItems(a, b, elements)
  bests = Array.new(a +1)
  for i in 0..a
    bests[i] = Array.new(b + 1, 0)
  end
  elements.each do |ele_a, ele_b|
    for iterA in (a).downto(ele_a)
      for iterB in (b).downto(ele_b)
        if (bests[iterA - ele_a][iterB - ele_b] + 1 > bests[iterA][iterB])
          bests[iterA][iterB] = bests[iterA - ele_a][iterB - ele_b] + 1
        end
      end
    end
  end
  bests
end

def nicePrint(array2d)
  array2d.each { |array| puts array.join(' ') }
end

def solveWithPrint(a, b, inputSmall)
  puts 'Matrix'
  bests = maxItems(a, b, inputSmall)
  nicePrint(bests)
  puts "Result is = #{bests[a][b]}"
end

def solve(a, b, inputSmall)
  maxItems(a, b, inputSmall)[a][b]
end
