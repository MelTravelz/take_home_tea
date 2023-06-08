# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

@user1 = FactoryBot.create(:user)
@user2 = FactoryBot.create(:user)

@sub1 = FactoryBot.create(:subscription)
@sub2 = FactoryBot.create(:subscription)
@sub3 = FactoryBot.create(:subscription)

@tea1 = FactoryBot.create(:tea_type)
@tea2 = FactoryBot.create(:tea_type)
@tea3 = FactoryBot.create(:tea_type)

@subs1_tea1 = FactoryBot.create(:tea_type_subscription, subscription: @sub1, tea_type: @tea1)
@subs1_tea2 = FactoryBot.create(:tea_type_subscription, subscription: @sub1, tea_type: @tea2)

@subs2_tea2 = FactoryBot.create(:tea_type_subscription, subscription: @sub2, tea_type: @tea2)
@subs2_tea3 = FactoryBot.create(:tea_type_subscription, subscription: @sub2, tea_type: @tea3)

@subs3_tea3 = FactoryBot.create(:tea_type_subscription, subscription: @sub3, tea_type: @tea3)
@subs3_tea1 = FactoryBot.create(:tea_type_subscription, subscription: @sub3, tea_type: @tea1)

@user_1_sub = FactoryBot.create(:user_subscription, user: @user1, subscription: @sub3, status: 1)
@user_2_sub = FactoryBot.create(:user_subscription, user: @user1, subscription: @sub1, status: 1, frequency: 2)
@user_3_sub = FactoryBot.create(:user_subscription, user: @user1, subscription: @sub2, status: 1, frequency: 2)
@user_4_sub = FactoryBot.create(:user_subscription, user: @user1, subscription: @sub1)