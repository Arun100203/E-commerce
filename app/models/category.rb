class Category < ApplicationRecord
    has_many :products
    has_and_belongs_to_many :types
    validates_presence_of :category

    # after_create do
    #     puts "after create"
    # end

    # after_save do
    #     puts "after save"
    # end

    # after_commit do
    #     puts "after commit"
    # end

    # after_rollback do
    #     puts "after rollback"
    # end

    # after_destroy do
    #     puts "after destroy"
    # end

    # after_update do
    #     puts "after update"
    # end

    # after_initialize do
    #     puts "after initialize"
    # end

    # after_find do
    #     puts "after find"
    # end

    # after_touch do
    #     puts "after touch"
    # end

    # after_validation do
    #     puts "after validation"
    # end

    # before_destroy do
    #     puts "before destroy"
    # end

    # before_update do
    #     puts "before update"
    # end

    # before_validation do
    #     puts "before validation"
    # end

    # before_save do
    #     puts "before save"
    # end

    # before_create do
    #     puts "before create"
    # end

    # around_save do |category, block|
    #     puts "around save before"
        
    #     puts "around save after"
    # end

    # around_create do |category, block|
    #     puts "around create before"
        
    #     puts "around create after"
    # end

    # around_update do |category, block|
    #     puts "around update before"
        
    #     puts "around update after"
    # end

    # around_destroy do |category, block|
    #     puts "around destroy before"
        
    #     puts "around destroy after"
    # end

    # before_add do
    #     puts "before add"
    # end

    # before_remove do
    #     puts "before remove"
    # end

    # after_add do
    #     puts "after add"
    # end

    # after_remove do
    #     puts "after remove"
    # end


    def self.ransackable_attributes(auth_object = nil)
        ["category", "created_at", "id", "id_value", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["products", "types"]
    end
end
