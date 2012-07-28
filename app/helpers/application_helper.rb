module ApplicationHelper
  def alert_classname_for_flash(message_type)
    {
      :notice => 'alert alert-success',
      :alert => 'alert alert-info',
      :error => 'alert alert-error'
    }[message_type]
  end
end
