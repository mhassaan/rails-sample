module ApplicationHelper

  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Ticketee").join('-')
      end
    end
  end

  # herer the block passed to this method is the code between do and end in the view where this method is called . block.call calls the block
  # if current_user.try returns true.
  def admins_only(&block)
    block.call if current_user.try(:admin?)
  end

end
