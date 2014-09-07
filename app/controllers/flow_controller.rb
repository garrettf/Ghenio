class FlowController < ApplicationController
  def status
    @synchros = current_account.synchronizations
    @connected = @synchros.length > 0
  end
end
