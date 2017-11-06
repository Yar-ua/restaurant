class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:new, :create]
  before_action :set_joiners, only: [:show]

  include CurrentCart
  before_action :set_group_cart, only: [:show]


  # просмотр всех групп
  def index
    #@groups = Group.all
    @groups = Group.joins(:members).where(user_id: current_user.id)
  end

  # показ группы
  def show
  end

  # создаем новую группу
  def new
    @new_group = @user.groups.build
  end

  # редактирование группы
  def edit
  end

  # создание новой группы
  def create
    @new_group = @user.groups.build(group_params)
    respond_to do |format|
      if @new_group.save
        # создателя группы также записываем в члены группы
        @user.members.create(group_id: @new_group.id, user_id: @user.id)
        format.html { redirect_to @new_group, notice: 'Группа создана! Вы можете ей управлять' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @new_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # обновление параметров группы
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Группа обновлена' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  
  # удаление группы
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Группа успешно удалена' }
      format.json { head :no_content }
    end
  end

  private
    # устанавливаем группу
    def set_group
      @group = Group.find(params[:id])
    end

    # установить параметры группы через белый список
    def group_params
      params.require(:group).permit(:name)
    end

    def set_user
      @user = current_user
    end


    # выбираем юзеров, пославших уведомление на вступление в группу
    def set_joiners
      @joiners = Joiner.where(group_id: @group.id)
    end


end
