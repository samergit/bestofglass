# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160522031448) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id"

  create_table "attachments", force: :cascade do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "attachment"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "attachments", ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id"

  create_table "auctions", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "active",           default: true
    t.boolean  "successful",       default: false
    t.string   "slug"
    t.string   "shipping_area"
    t.float    "buy_it_now_price"
    t.float    "price_increment",  default: 1.0
    t.float    "shipping_price",   default: 0.0
    t.float    "reserve",          default: 0.0
    t.integer  "length",           default: 1
    t.float    "starting_price",   default: 0.0
    t.float    "current_price",    default: 0.0
    t.float    "final_price",      default: 0.0
    t.integer  "highest_bidder"
    t.integer  "winner_id"
    t.boolean  "display_price",    default: true
    t.datetime "relist_time"
    t.boolean  "relisted",         default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "auctions", ["active"], name: "index_auctions_on_active"
  add_index "auctions", ["slug"], name: "index_auctions_on_slug", unique: true
  add_index "auctions", ["user_id"], name: "index_auctions_on_user_id"
  add_index "auctions", ["winner_id"], name: "index_auctions_on_winner_id"

  create_table "baggable_items", force: :cascade do |t|
    t.integer  "bag_id"
    t.integer  "baggable_id"
    t.string   "baggable_type"
    t.integer  "type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "baggable_items", ["bag_id"], name: "index_baggable_items_on_bag_id"
  add_index "baggable_items", ["baggable_type", "baggable_id"], name: "index_baggable_items_on_baggable_type_and_baggable_id"

  create_table "bags", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bags", ["user_id"], name: "index_bags_on_user_id"

  create_table "bids", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "amount"
    t.integer  "auction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bids", ["auction_id"], name: "index_bids_on_auction_id"
  add_index "bids", ["user_id"], name: "index_bids_on_user_id"

  create_table "billing_addresses", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country",        default: "US"
    t.string   "phone"
    t.integer  "b_addable_id"
    t.string   "b_addable_type"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "billing_addresses", ["b_addable_type", "b_addable_id"], name: "index_billing_addresses_on_b_addable_type_and_b_addable_id"

  create_table "card_payments", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.string   "ip_address"
    t.string   "last4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "card_payments", ["order_id"], name: "index_card_payments_on_order_id"
  add_index "card_payments", ["user_id"], name: "index_card_payments_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "read",             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sender_delete",    default: false
    t.boolean  "recipient_delete", default: false
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id"
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id"

  create_table "favorites", force: :cascade do |t|
    t.integer  "favoritable_id"
    t.string   "favoritable_type"
    t.integer  "user_id"
    t.integer  "type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "favorites", ["favoritable_type", "favoritable_id"], name: "index_favorites_on_favoritable_type_and_favoritable_id"
  add_index "favorites", ["type"], name: "index_favorites_on_type"
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id"

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.integer  "feedbackable_id"
    t.string   "feedbackable_type"
    t.integer  "score"
    t.text     "content"
    t.boolean  "seller_received",   default: false
    t.boolean  "buyer_received",    default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "feedbacks", ["buyer_id"], name: "index_feedbacks_on_buyer_id"
  add_index "feedbacks", ["feedbackable_type", "feedbackable_id"], name: "index_feedbacks_on_feedbackable_type_and_feedbackable_id"
  add_index "feedbacks", ["seller_id"], name: "index_feedbacks_on_seller_id"

  create_table "items", force: :cascade do |t|
    t.string   "title"
    t.string   "category"
    t.integer  "itemable_id"
    t.string   "itemable_type"
    t.integer  "user_id"
    t.string   "height"
    t.string   "joint"
    t.string   "perc"
    t.string   "pendant_length"
    t.string   "dry_pipe_style"
    t.string   "width"
    t.string   "hole_size"
    t.string   "accessory_type"
    t.string   "artist"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "items", ["category"], name: "index_items_on_category"
  add_index "items", ["itemable_type", "itemable_id"], name: "index_items_on_itemable_type_and_itemable_id"
  add_index "items", ["user_id"], name: "index_items_on_user_id"

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.boolean  "read",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "send_delete",      default: false
    t.boolean  "recipient_delete", default: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "month_totals", force: :cascade do |t|
    t.string   "month"
    t.float    "total"
    t.integer  "year_totals_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "month_totals", ["year_totals_id"], name: "index_month_totals_on_year_totals_id"

  create_table "monthly_overall_totals", force: :cascade do |t|
    t.integer  "total_id"
    t.float    "amount"
    t.string   "month"
    t.float    "sales_tax"
    t.integer  "transactions"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "monthly_overall_totals", ["total_id"], name: "index_monthly_overall_totals_on_total_id"

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.integer  "actor_id"
    t.string   "action"
    t.text     "content"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "notifications", ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id"
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "sellable_id"
    t.string   "sellable_type"
    t.string   "number"
    t.float    "amount"
    t.float    "shipping_amount"
    t.float    "sales_tax"
    t.float    "seller_cut"
    t.float    "final_amount"
    t.float    "our_cut"
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.boolean  "deposited_order",        default: true
    t.boolean  "paid",                   default: false
    t.boolean  "shipped",                default: false
    t.boolean  "delivered",              default: false
    t.boolean  "seller_preliminary_pay", default: false
    t.boolean  "seller_paid",            default: false
    t.boolean  "deposit_paid",           default: false
    t.boolean  "voided",                 default: false
    t.boolean  "abandoned",              default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "orders", ["sellable_type", "sellable_id"], name: "index_orders_on_sellable_type_and_sellable_id"

  create_table "pay_outs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.float    "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pay_outs", ["order_id"], name: "index_pay_outs_on_order_id"
  add_index "pay_outs", ["user_id"], name: "index_pay_outs_on_user_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "shipping_addresses", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country",        default: "US"
    t.string   "phone"
    t.integer  "s_addable_id"
    t.string   "s_addable_type"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "shipping_addresses", ["s_addable_type", "s_addable_id"], name: "index_shipping_addresses_on_s_addable_type_and_s_addable_id"

  create_table "shippings", force: :cascade do |t|
    t.string   "tracking"
    t.string   "carrier"
    t.integer  "order_id"
    t.integer  "shipper_id"
    t.integer  "buyer_id"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "shippings", ["order_id"], name: "index_shippings_on_order_id"

  create_table "totals", force: :cascade do |t|
    t.string   "year"
    t.float    "pending_revenue"
    t.float    "total_revenue"
    t.float    "cut"
    t.float    "sales_tax"
    t.float    "payout"
    t.integer  "transactions"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                         default: "",    null: false
    t.string   "encrypted_password",            default: "",    null: false
    t.string   "username",                      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                 default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "instagram"
    t.string   "avatar"
    t.date     "date_of_birth"
    t.boolean  "w9_submitted",                  default: false
    t.datetime "last_viewed_activity_page"
    t.datetime "last_viewed_notification_page"
    t.datetime "last_viewed_messages_page"
    t.datetime "last_received_message"
    t.datetime "last_received_notification"
    t.datetime "last_active_at"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "role"
    t.boolean  "approved",                      default: false
    t.boolean  "banned",                        default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "year_totals", force: :cascade do |t|
    t.string   "year"
    t.float    "total"
    t.integer  "transactions"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "year_totals", ["user_id"], name: "index_year_totals_on_user_id"

end
