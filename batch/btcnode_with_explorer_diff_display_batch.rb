require_relative './latest_block_number'
require_relative './messaging_service'

class BtcnodeWithExplorerDiffDisplayBatch
  def perform(*args)
    puts '--- start ---'
    bitcoind = BitcoindLatestBlockNumber.new
    btc_block_num = bitcoind.get_block_number
    explorer = ExplorerLatestBlockNumber.new
    explorer_block_num = explorer.get_block_number

    if is_diff_or_more_3(btc_block_num, explorer_block_num) then
      message_service = MessagingService.new
      message = "bitcondとexplorerの差分の±3 block以上のDiffあります"
      message_service.send(message)
    end

    puts '--- fin ---'
  end

  def is_diff_or_more_3(btc_block_num, explorer_block_num)
    diff = btc_block_num - explorer_block_num
    return diff.abs >= 3
  end
end
