require 'digest'

class AdventCoin

  def initialize(passcode)
    @md5 = Digest::MD5.new
    @passcode = passcode
  end

  def find_adventcoin(num)
    adventcoin = false

    while !adventcoin
      new_string = "#{@passcode}#{num}"
      # puts new_string
      # @md5.update new_string
      md5_hash = @md5.hexdigest new_string

      if md5_hash.slice(0, 6) == "000000"
        puts md5_hash
        puts num
        adventcoin = true

      else
        num += 1
      end
    end

    num
  end

  def find_first_adventcoin
    adventcoin = find_adventcoin(0)

    puts adventcoin
  end

end

# AdventCoin.new('abcdef').find_adventcoin(609040)

AdventCoin.new('ckczppom').find_first_adventcoin
