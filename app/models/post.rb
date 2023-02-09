class Post < ApplicationRecord
    before_save :set_slug
    before_save :set_published_at, :if => :status_changed?
    
    belongs_to :category, :class_name => 'Category', :foreign_key => 'category_id'

    module Status
        PUBLISHED = 'published'
        DRAFT = 'draft'
    end

    attribute :status, :string, default: Status::DRAFT

    scope :published, -> { where(status: Status::PUBLISHED) }
    scope :draft, -> { where(status: Status::DRAFT) }
    scope :recent, -> { order(published_at: :desc) }
    scope :featured, -> { where(is_featured: true) }
    scope :search, -> (query) { where("lower(title) ILIKE ?", "%#{query}%") }

    # mount_uploader :cover, TheglobalcrCoverUploader

    private
        def set_slug
            self.slug = self.title.parameterize
        end

        def set_published_at
            if self.status == Status::PUBLISHED and self.published_at.blank?
                self.published_at = DateTime.now
            end
        end
end