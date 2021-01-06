class PdfsChannel < ApplicationCable::Channel
  def subscribed
    puts params
    stream_from "pdfs_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
