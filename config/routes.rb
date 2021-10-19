Rails.application.routes.draw do
  get 'sales/show'
  post 'sales/addItem'
  get 'sales/removeItem'
  get 'sales/calculate'
  post 'sales/clear_session'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
