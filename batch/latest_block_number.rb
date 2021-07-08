require 'net/http'
require 'json'

class BitcoindLatestBlockNumber
    def get_block_number
        # response = JSON.parse(`bitcoin-cli getblockcount`)
        return 0
    end
end

class ExplorerLatestBlockNumber
    def get_block_number
        response = JSON.parse(Net::HTTP.get(URI.parse('https://blockchain.info/latestblock')))
        return response["height"]
    end
end
