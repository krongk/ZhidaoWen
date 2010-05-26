# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def site n
    arr =[]
    arr << "all" << "baidu" << "tianya" << "soso" << "sogou" << "sina" << "yahoo"
    arr[n.to_i]
  end
end
