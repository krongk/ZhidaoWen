require 'nokogiri'
require 'open-uri'
require 'iconv'

class WelcomeController < ApplicationController
  def index
    from = params[:from]
    @arr = []
    if from=="1"  #load from zhidao.baidu.com
      @arr =load_from("http://zhidao.baidu.com/browse/?lm","table#tl","http://zhidao.baidu.com","gb2312")
    elsif from=="2" #load from tianya.com
      @arr =load_from("http://wenda.tianya.cn/wenda/?tab=wtmtoc#wtmtc","div.wvtpCSS table.wpr2trCSS","http://wenda.tianya.cn",nil)
    elsif from=="3" #load from soso
      @arr =load_from("http://wenwen.soso.com/z/TopQuestion.e?sp=5","ul.question_list1","http://wenwen.soso.com",nil)
    elsif from=="4" #load from sogou
      @arr =load_from("http://wenda.sogou.com/cate/0.html?s=2","table.alist","","gbk")
    elsif from=="5" #load from iask.sina.com.cn
      @arr =load_from("http://iask.sina.com.cn/rank/finish_question.php","table","http://iask.sina.com.cn","gbk")
    elsif from=="6" #load from yahoo
      @arr =load_from("http://ks.cn.yahoo.com/dir/over.html","div.mqlist div.bd","http://ks.cn.yahoo.com",nil)
    else
       @logs = Log.all(:order=>"created_at desc",:limit=>30)
       render :file=>"tips/a",:layout=>'application'
    end
  end

  def show
    from = params[:from]
    id = params[:id]
    if from =='1'  # from zhidao.baidu.com
      #@arr= show_zhidao(id,"gb2312")
      @arr = load_show(:url=>"http://zhidao.baidu.com/question/#{id}",:parse_css=>["div.p90","div.wr"],:encoding=>'gb2312')
      @question = build_obj(:from=>from,:category=>'1',:url=>id,:original_url=>"http://zhidao.baidu.com/question/#{id}",:title_css=>"div#question_title")
    elsif from =='3'  # from soso
      @arr = load_show(:url=>"http://wenwen.soso.com/z/#{id}",:parse_css=>["div.question_wrap","div.sloved_answer_main","div.answer_main"],:encoding=>nil)
      @question = build_obj(:from=>from,:category=>'1',:url=>id,:original_url=>"http://wenwen.soso.com/z/#{id}",:title_css=>"div.question_main h3")
    elsif from =='5'  # from sina
      @arr = load_show(:url=>"http://iask.sina.com.cn/b/#{id}",:parse_css=>["div.qus_c","div.qus_c2","div.ans_c"],:encoding=>'gbk')
      @question = build_obj(:from=>from,:category=>'1',:url=>id,:original_url=>"http://iask.sina.com.cn/b/#{id}",:title_css=>"div.usr_qus strong")
    elsif from =='2'  # from tianya
      @arr = load_show(:url=>"http://wenda.tianya.cn/wenda/thread?tid=#{id}",:parse_css=>["div.wpcppmcCSS"],:encoding=>nil)
      @question = build_obj(:from=>from,:category=>'1',:url=>id,:original_url=>"http://wenda.tianya.cn/wenda/thread?tid=#{id}",:title_css=>"div.wpcpsCSS")
    elsif from =='4'  # from sogou 
      @arr = load_show(:url=>"http://wenda.sogou.com/question/#{id}",:parse_css=>["div.content"],:encoding=>'gbk')
      @question = build_obj(:from=>from,:category=>'1',:url=>id,:original_url=>"http://wenda.sogou.com/question/#{id}",:title_css=>"div.boxl2 h3")
     elsif from =='6'  # from yahoo
      @arr = load_show(:url=>"http://ks.cn.yahoo.com/question/#{id}",:parse_css=>["div.entrydetail"],:encoding=>nil)
       @question = build_obj(:from=>from,:category=>'1',:url=>id,:original_url=>"http://ks.cn.yahoo.com/question/#{id}",:title_css=>"div.entrydetail h3")
    else
      render :text =>"nothing"
    end
  end
  def do_follow
    render :text=>"glsdlf"
  end
  private
  #load from common url
  def load_from(from_url,parse_css,format_url,encoding)
    url =from_url
    doc =Nokogiri::HTML(open(url))
    arr =[]
    doc.css(parse_css).each do |line|
      arr << line
    end
    arr =arr.to_s.gsub(/href=\"\//,"href=\"#{format_url}\/").gsub(/src=\"\//,"src=\"#{format_url}\/").gsub(/\<table /,"\<table width=\"100%\" ")
    #arr =arr.gsub(/\n/," ")
    if encoding
      arr=Iconv.iconv("utf-8//IGNORE", encoding, arr.to_s)
    end
    arr
  end
  
  #load to show detail
  def load_show(*args)
    arr =[]
    args.each do |arg|
      url = arg[:url]
      doc = Nokogiri::HTML(open(url))    
      arg[:parse_css].each do |css|
        doc.css(css).each do |line|
          arr << line
        end
      end
      if arg[:encoding]
        arr=Iconv.iconv("utf-8//IGNORE", arg[:encoding], arr.to_s)
      end
    end # args block end
    arr
  end
  #build question object
  def build_obj(*args)
   question = Question.find(:first,:conditions=>["questions.from = ? and questions.url = ?",args[0][:from],args[0][:url]]) || Question.new
    args.each do |arg|   
      question.from = arg[:from]
      question.category = arg[:category]
      question.sort_id = 1
      question.is_display = true
      question.url = arg[:url]
      question.original_url = arg[:original_url]
        doc = Nokogiri::HTML(open(arg[:original_url]))
      question.min_title = doc.at_css(arg[:title_css]).content
    end #args block end
     question
  end

end
