class ChangeLevelOfCategory < ActiveRecord::Migration[5.2]
  def change
    Category.create(name:"食費")
    Category.create(name:"通信費")
    Category.create(name:"交通費")
    Category.create(name:"ファッション")
    Category.create(name:"美容")
    Category.create(name:"消耗品")
    Category.create(name:"学習")
    Category.create(name:"家賃")
    Category.create(name:"コンテンツ")
  end
end
