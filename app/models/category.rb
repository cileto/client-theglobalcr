class Category < ApplicationRecord
    before_create :set_slug

    has_many :posts
    attribute :is_active, :boolean, default: true

    scope :active, -> { where(is_active: true) }

    private
        def set_slug
            self.slug = self.name.parameterize
        end
end
