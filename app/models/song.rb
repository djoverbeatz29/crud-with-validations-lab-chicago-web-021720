class Song < ActiveRecord::Base
    validates_presence_of :title
    validate :release_logic

    def release_logic
        if !release_year
            if released
                errors.add(:release_year, "can't be null if the song was released, you goofy duck!")
            end
        elsif release_year > Time.now.year || release_year.class != Integer
            errors.add(:release_year, "can't be in the future, you silly goose!")
        elsif Song.where(title: title, release_year: release_year).count > 0
            errors.add(:title, "can't be released multiple times in the same year, you childish chicken!")
        end
    end

end