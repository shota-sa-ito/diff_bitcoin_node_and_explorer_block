require 'net/http'
require 'json'
require_relative './bitcoinrpc'

class BitcoindLatestBlockNumber
    def get_block_number
        client = BitcoinRPC.new('http://ss:ss@bitcoind-node:8332')
        result = client.getblockcount
        return result
    end
end

class ExplorerLatestBlockNumber
    def get_block_number
        response = JSON.parse(Net::HTTP.get(URI.parse('https://blockchain.info/latestblock')))
        return response["height"]
    end
end
