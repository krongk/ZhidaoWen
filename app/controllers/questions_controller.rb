class QuestionsController < ApplicationController
  before_filter :login_required, :except=>[:index,:show]
  # GET /questions
  # GET /questions.xml
  def index
    @questions = Question.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.xml
  def create
    #1.save the question
    @question = Question.new(params[:question])
     respond_to do |format|
    if @question.save
      #2.create a follow
      follow = Follow.new
      follow.question_id = @question.id
      follow.user_id = current_user.id
      follow.save
      flash[:notice] = '问题已添加关注.'
       Log.add("<a target='_blank' href='users/#{current_user.id}'>#{current_user.login}</a>在#{Time.now.to_s(:db)}"+
           "关注了问答:<a target='_blank' href='/show/?from=#{@question.from}&id=#{@question.url}'>#{@question.min_title}</a>")
      format.html { redirect_back_or_default(current_user) }
      #3.create a log
    else
       format.html { render :action => "new" }
      end
     end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        flash[:notice] = 'Question was successfully updated.'
        format.html { redirect_to(@question) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end
end
