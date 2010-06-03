# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def site n
    arr =[]
    arr << "all" << "baidu" << "tianya" << "soso" << "sogou" << "sina" << "yahoo"
    arr[n.to_i]
  end

  #该方法用于动态设置导航的css显示
  def active(n)
    if n.to_s==params[:from]
      "active"
    else
      ""
    end
  end
  #def the pretty title
  def title(page_title)
    content_for(:title){page_title}
  end
end
