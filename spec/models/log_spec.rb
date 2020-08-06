require 'rails_helper'

RSpec.describe Log, type: :model do
  let!(:log) { create(:log) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(log).to be_valid
    end

    it "article_idがなければ無効な状態であること" do
      log = build(:log, article_id: nil)
      expect(log).not_to be_valid
    end
  end
end
