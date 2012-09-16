class Comment
  def self.for(type, id)
    Comment.all(:commentable_type => type.to_s,
                :commentable_id => id.to_s)
  end
end

class Act
  def comments
    Comment.for(:act, @number)
  end
end
