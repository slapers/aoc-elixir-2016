defmodule AdventOfCodeTest.Day7 do
  use ExUnit.Case
  alias AdventOfCode.Day7, as: D7


  test "has_abba? should return tru if abba is contained" do
    assert true == D7.has_abba?(~w(c b b c))
    assert true == D7.has_abba?(~w(a d o p m c c b d b b d c))
    assert true == D7.has_abba?(~w(a d o p m c c b d d b d c))
  end

  test "supports_tls? should follow the rules" do

    assert true == D7.supports_tls?("abba[zzaa]kkll[ab][az]")
    assert false == D7.supports_tls?("abba[zaaz]kkll[abbb]")
    assert true == D7.supports_tls?("aaaa[zaaa]kllk")
    assert false == D7.supports_tls?("[]")
    assert false == D7.supports_tls?("ab[ba]ab")
    assert false == D7.supports_tls?("xuabbxdwkutpsogcfea[tgetfqpgstsxrokcemk]cbftstsldgcqbxf[vwjejomptmifhdulc]ejeroshnazbwjjzofbe")

  end

  test "part 1 returns the correct answer" do
    assert 105 == D7.part1()
  end
end
