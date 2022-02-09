# frozen_string_literal: true

require 'rails_helper'

describe UserStatCountUpdater do
  fab!(:user) { Fabricate(:user) }
  fab!(:user_stat) { user.user_stat }
  fab!(:post) { Fabricate(:post) }

  before do
    @orig_logger = Rails.logger
    Rails.logger = @fake_logger = FakeLogger.new
  end

  after do
    Rails.logger = @orig_logger
  end

  it 'should log the exception when a negative count is inserted' do
    UserStatCountUpdater.decrement!(post, user_stat: user_stat)

    expect(@fake_logger.warnings.first).to include("PG::CheckViolation")
  end
end
