require 'rails_helper'
require 'smart_listing/helper'

module SmartListing::Helper
  class UsersController < ApplicationController
    include ControllerExtensions
    attr_writer :user

    attr_accessor :smart_listings

    def params
      { value: 'params' }
    end

    def cookies
      { value: 'cookies' }
    end
  end

  describe ControllerExtensions do
    describe "#smart_listing_create" do
      it "create a list with params and cookies" do
        controller = UsersController.new
        collection = double
        list = build_list(collection: collection)

        expect(list).to receive(:setup).with(controller.params,
                                             controller.cookies)

        controller.smart_listing_create(:users, collection)
      end

      it "assign a list in smart listings with the name" do
        controller = UsersController.new
        collection = double
        list = build_list(collection: collection)

        controller.smart_listing_create(:users, collection)

        expect(controller.smart_listings[:users]).to eq list
      end

      it 'return the collection of the list' do
        controller = UsersController.new
        collection1 = double
        collection2 = double
        build_list(collection: collection1)

        controller.smart_listing_create(:users, collection2)

        actual = controller.smart_listings[:users].collection
        expect(actual).to eq collection1
      end

      def build_list(collection: )
        double(collection: collection, setup: nil).tap do |list|
          allow(SmartListing::Base).to receive(:new).and_return(list)
        end
      end
    end

    describe '#smart_listing' do
      it 'give the list with name' do
        controller = UsersController.new
        list = double
        controller.smart_listings = { users: list }
        expect(controller.smart_listing).to eq list
      end
    end

    describe '#smart_listing_resource_name' do
      it 'give the controller name' do
        controller = UsersController.new
        expect(controller.smart_listing_resource_name).to eq :users
      end
    end

    describe '#smart_listing_resource' do
      it 'give the resource' do
        controller = UsersController.new
        user = double
        controller.user = user

        expect(controller.smart_listing_resource).to eq user
      end
    end

    describe '#smart_listing_view_path' do
      it 'give the view path' do
        controller = UsersController.new
        expect(controller.smart_listing_view_path).to eq 'smart_listing/helper/users'
      end
    end

    describe '#smart_listing_view_item_path' do
      it 'give the path the view item template' do
        controller = UsersController.new
        expect(controller.smart_listing_view_item_path).to eq 'smart_listing/helper/users/user'
      end
    end

    describe '#smart_listing_view_form_path' do
      it 'give the path the view form template' do
        controller = UsersController.new
        expect(controller.smart_listing_view_form_path).to eq 'smart_listing/helper/users/form'
      end
    end
  end
end
