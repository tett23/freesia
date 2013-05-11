module Freesia
  class App < Padrino::Application
    register SassInitializer
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Admin::AccessControl

    enable :sessions
    enable :authentication
    enable :store_location

    use OmniAuth::Builder do
      provider :twitter,  '0qYBaZfMRCkfAs44GZ2rFQ', '1AztDbMwghIRlR01PBoIMafLfaD45WZf7OsvAnWv4c'
    end

    set :login_page, '/sessions/login'

    access_control.roles_for :any do |role|
      role.protect '/'
      role.allow '/sessions'
      role.allow '/auth'
    end

    access_control.roles_for :users do |role|
      role.allow '/sessions'
    end

    before do
      take_snapshot_instance_variables()

      if logged_in?
        @notebooks = Notebook.list(current_account.id)
        add_breadcrumbs('freesia', url('/'))
      end
    end
  end
end
