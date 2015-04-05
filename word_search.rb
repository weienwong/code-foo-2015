file = File.open('./word-search.txt', 'r').to_a

word_grid = []
words_to_find = []

i = 0
# get word grid from file
file.each do |line|
  if i <= 19
    line.delete! "\n"
    line.delete! " "
    word_grid << line

  elsif i >= 24 and i < 50
    line.delete! "\n"
    line.delete! " "
    words_to_find << line
  else
  end
  i += 1
end

#p word_grid
total = words_to_find.length
killcount = 0
height = word_grid.length
width = word_grid[0].length


p "Horizonal: left to right and right to left"
word_grid.each do |row|
  words_to_find.each do |word|
    if row[word] or row.reverse[word]
      p "found " + word
      killcount += 1
    end
  end
end

p "Vertical: top to bottom and bottom to top"
(0..width - 1).each do |w|
  
  vertical = ""
  
  (0..height - 1).each do |h|
     vertical += word_grid[h][w]
  end
  
  words_to_find.each do |word|
    if vertical[word] or vertical.reverse[word]
      p "found " + word
      killcount += 1
    end
  end
end

p "Diagonal: top left quadrant to bottom right quadrant"

(0..width - 1).each do |w|
  diagonal_top = ""
  diagonal_bottom = ""

  (0..height - 1).each do |h|

    if w + 1 > width
    elsif h + 1 > height 
    else
      diagonal_top = diagonal_top + word_grid[h][w]
      diagonal_bottom = diagonal_bottom + word_grid[w][h]
      h += 1
      w += 1
    end
  end

  words_to_find.each do |word|
    if diagonal_top[word] or diagonal_top.reverse[word] or diagonal_bottom[word] or diagonal_bottom.reverse[word]
      p "found " + word
      killcount += 1
    end
  end
end

p "Diagonal: bottom left to top right (bottom half)"

(0..width - 1).each do |w|
  diagonal_top = ""

  (height - 1).downto(0).each do |h|

    if w + 1 > width or h < 0
    else
      diagonal_top = diagonal_top + word_grid[h][w]
      h -= 1
      w += 1
    end
  end

  words_to_find.each do |word|
    if diagonal_top[word] or diagonal_top.reverse[word]
      p "found " + word
      killcount += 1
    end
  end
end
# get list of words from file

p "Diagonal: bottom left to top right (top half)"
(width - 1).downto(0).each do |w|
  diagonal = ""

  (0..height - 1).each do |h|
    if w < 0
    elsif h + 1 > height
    else
      diagonal = diagonal + word_grid[h][w]
      w -= 1
      h += 1
    end

  end

  words_to_find.each do |word|
    if diagonal[word] or diagonal.reverse[word]
      p "found " + word
      killcount += 1
    end
  end
end

if killcount == total
  p "found all the words!"
else
  p total - killcount
end
