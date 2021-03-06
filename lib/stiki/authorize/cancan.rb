require 'stiki/authorize'

module Stiki::Authorize::Cancan
  def self.included(base)
    require 'cancan'
    require 'cancan/ability'
    base.load_and_authorize_resource base.class.name, :if => lambda {|c| Stiki.authorize_by == :cancan }
  end 
end