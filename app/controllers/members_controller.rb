class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update]

  # получить всех членов
  def index
    @members = Member.all
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end


  # создание членства в группе
  def create
    @member = Member.new(group_id: params[:group_id], user_id: params[:user_id])
    if @member.save
      @joiner = Joiner.where(user_id: @member.user_id, group_id: @member.group_id).take
      @joiner.destroy
      redirect_to group_path(@member.group_id), notice: @member.user.name + ' добавлен в группу'
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member = Member.where(user_id: params[:user_id], group_id: params[:group_id]).take
    @member.destroy
    redirect_to root_path, notice: 'Вы удалились из группы'
  end

  private
    # устанавливаем члена группы
    def set_member
      @member = Member.find(params[:id])
    end

    # получение параметров для члена группы
    def member_params
      params.require(:member).permit(:group_id, :user_id)
    end
end
