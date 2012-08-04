require 'stiki'
require 'stiki/authenticate'

module Stiki::Authenticate::Devise
  def self.included(base)
    if Stiki.auth_mapping
      auth_required = Stiki.auth_mapping[base.controller_name.to_sym]
      if auth_required
        if auth_required == :all
          base.before_filter "authenticate_#{Stiki.user_class.constantize.name.underscore}!".to_sym
        else
          base.before_filter "authenticate_#{Stiki.user_class.constantize.name.underscore}!".to_sym, auth_required
        end
      end
    else
      raise "Stiki.auth_mapping was nil"
    end
  end 
end