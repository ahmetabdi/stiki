require 'friendly_id'

module Stiki
  class Page < ActiveRecord::Base
    self.table_name = "stiki_pages"
    
    extend ::FriendlyId
    friendly_id :title, use: :slugged
    
    belongs_to :space
    has_many :authors, :as => :authorable do
      def <<(*authors)
        # prevent duplicate authors
        existing_users = proxy_association.owner.authors.map(&:user_id)
        super( authors.select { |auth| !existing_users.include?( auth.user_id ) } )
      end
    end
    
    attr_accessible :body, :title
    
    validates :title, :uniqueness => {:scope => :space_id}, :presence => true
    validates :body, :presence => true
    
    def mark_badges
      if authors.size > 1
        # XXX: need revisions to determine last edit and most edits
        #last = authors.order( 'updated_at DESC' ).first
        #authors.where( ["#{Stiki::Author.table_name}.id != ?", last.id] ).update_all( :last_edit => false );
        #authors.where( ["#{Stiki::Author.table_name}.id = ?", last.id] ).update_all( :last_edit => true );
      end
    end
  end
end
