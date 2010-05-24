require 'nokogiri'
require 'open-uri'
require 'iconv'

class WelcomeController < ApplicationController
  def index
    from = params[:from]
    @arr = []
    if from=="1"  #load from zhidao.baidu.com
      @arr =load_from("http://zhidao.baidu.com/browse/81","table#tl","http://zhidao.baidu.com","gb2312")
    elsif from=="2" #load from tianya.com
      @arr =load_from("http://wenda.tianya.cn/wenda/label?lid=4b8154b02b483acd&clk=cts_ls","div.wvtpCSS table.wpr2trCSS","http://wenda.tianya.cn",nil)
    elsif from=="3" #load from soso
      @arr =load_from("http://wenwen.soso.com/z/c1191182336.htm","ul.question_list1","http://wenwen.soso.com",nil)
    elsif from=="4" #load from sogou
      @arr =load_from("http://women.wenda.sogou.com/cate/13.html","table.alist","","gbk")
    elsif from=="5" #load from iask.sina.com.cn
      @arr =load_from("http://iask.sina.com.cn/c/6.html","div#questionlist","http://iask.sina.com.cn","gbk")
    elsif from=="6" #load from yahoo
      @arr =load_from("http://ks.cn.yahoo.com/dir/ask.html","div.mqlist div.bd","http://ks.cn.yahoo.com",nil)
    else
     # render :text=>from
    end
  end

  def show
  end
  private
  #load from zhidao.baidu.com
  def load_from(from_url,parse_css,format_url,encoding)
    url =from_url
    doc =Nokogiri::HTML(open(url))
    arr =[]
    doc.css(parse_css).each do |line|
      arr << line
    end
    arr =arr.to_s.gsub(/href=\"\//,"href=\"#{format_url}\/").gsub(/src=\"\//,"src=\"#{format_url}\/").gsub(/\<table /,"\<table width=\"100%\" ")
    if encoding
      arr=Iconv.iconv("utf-8//IGNORE", encoding, arr.to_s)
    end
    arr
  end
end
