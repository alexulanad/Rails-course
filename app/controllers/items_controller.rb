class ItemsController < ApplicationController
  #layout false
  #skip_before_action :verify_authenticity_token

  # перед выполнение action: show, edit, update, destroy вызывает метод find_item 
  # из которого возвращается найденный элемент модели item  
  before_action :find_item, only: %i[show edit update destroy upvote]
  # для контроллеров new..destroy проходит предварительную проверку на наличие admin в params
  before_action :admin?, only: %i[destroy] # new create edit update добавить в [] по необходимости
  after_action :information, onli: [:index] # вызывается после выполнения action-а index

  def index
    @items = Item.all.sort_by {|key| key[:id]} # Все элементы из таблицы Items сортируем по ключу :id элементов
  end

  def new
    @item = Item.new
  end

  def upvote # метод дял голосования
    @item.increment! :votes_count # увеличить число по ключу votes_count на 1
    redirect_to items_path
  end

  def expensive
    @items = Item.where('price > 50') # price: > 50 не заработало бы, поэтому формляется, как запрос SQL в виде строки
    render :index # отрендерить представление view, без перезагрузки контроллера, если сделать redirect_to :index то он подгрузит контроллер index и переменной @items передадутся все элементы таблицы
  end

  def create
    if params[:name] == "Запись"
      item = Item.new(
        name: params[:name], 
        price: params[:price], 
        weight: params[:weight], 
        description: params[:description])
      item.save
      redirect_to items_path
    else
      item = Item.create(item_params)
      if item.persisted? # если item сохранен то
        redirect_to items_path # перееаправить на страницу всех объектов Item
      #render json: item.name, status: :created
      #render json: "Данные сохранены" # рендер в формате json
      else # если item не прошел валидацию и не сохранился
        render json: item.errors # рендер в формате json ошибки items
      end
    end    
  end

  def show
    # Rails переходит на метод show, после того, как перехватывает из браузера маршрут вида /items/:id где :id - номер записи в базе данных, и сохраняет этот id в хеше params для дальнейшего использования
    # Поиск записи в базе данных по id, переданного в хеше params. Сохраняет в переменной экземпляра массив с хешем данных найденного объекта                    
    render body: "Страницы не существует", status: 404 unless @item # если @item нет выведет сообщение об ошибке
  end

  def edit    
    render body: "Страницы не существует", status: 404 unless @item # если @item нет выведет сообщение об ошибке
  end

  def update        
    if @item.update(item_params)
      redirect_to item_path
    else
      render json: item.errors, status: :unprocessable_entity # необработанный объект
    end 
  end

  def destroy    
    if @item.destroy.destroyed?    
      redirect_to items_path
    else
      render json: item.errors, status: :unprocessable_entity # необработанный объект
    end    
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :weight, :description)
    #params.permit(:name, :price, :weight, :description)
  end

  def find_item
    @item = Item.where(id: params[:id]).first # найти элемнт, где id = params.id первый из списка
    #@item = Item.find(params[:id])
    render_404 unless @item # рендерит метод главного контроллера render_404 если @item не найден    
  end

  def admin? # приватный метод для проверки на админа (вызывается из before_action)
    #true
    # если в строке браузера передать дополнительную ключ в paramsс в виде ?admin=1
    # то доступ будет открыт, в противном случае выведет сообщение "Доступ запрещен"    
    #render json: 'Доступ запрещен', status: :forbidden unless params[:admin]
    render_403 unless params[:admin]
  end

  def information
    puts "Страница загружена"
  end
end