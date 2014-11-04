require 'rails_helper'
require 'smart_listing/helper'

module SmartListing::Helper
  class UsersController < ApplicationController
    include ControllerExtensions
    attr_writer :user
  end

  describe ControllerExtensions do
    describe '#resource_name' do
      it 'give the controller name' do
        expect(presenter.resource_name).to eq :users
      end
    end

    describe '#resource' do
      it 'give the resource' do
        user = double
        presenter.controller.user = user
        expect(presenter.resource).to eq user
      end
    end

    describe '#view_path' do
      it 'give the view path' do
        expect(presenter.view_path).to eq 'smart_listing/helper/users'
      end
    end

    describe '#view_item_path' do
      it 'give the path the view item template' do
        expect(presenter.view_item_path).to eq 'smart_listing/helper/users/user'
      end
    end

    describe '#view_form_path' do
      it 'give the path the view form template' do
        expect(presenter.view_form_path).to eq 'smart_listing/helper/users/form'
      end
    end

    def presenter
      @presenter ||= SmartListingPresenter.new(UsersController.new)
    end
  end
end
