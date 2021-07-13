class ApplicationController < ActionController::Base
  def render_403
    # метод главного контроллера для вывода страницы 403 (доступ запрещен или status: :forbidden)
    render file: 'public/403.html', status: :forbidden # рендер файла 403 (Rails сделает это и без этой записи)
  end

  def render_404
    # метод главного контроллера для вывода страницы 404 (страница не найдена или status: 404)
    render file: 'public/404.html', status: :not_found  # рендер файла 404 (Rails сделает это и без этой записи)
  end
end
