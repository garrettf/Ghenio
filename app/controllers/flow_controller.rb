class FlowController < ApplicationController
  def status
    @connected = current_account.synchronizations.length > 0
  end
end
