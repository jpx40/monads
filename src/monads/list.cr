require "./maybe"
require "./monad"

module Monads
  struct List(T) < Monad(T)
    include Comparable(List)
    include Indexable(T)

    # create new List
    #
    # ```
    # Monads::List[1,2,3] == Monads::List.new([1,2,3])
    # ```
    macro [](*args)
      %array = Monads::List.new({{args}}.to_a)
      %array
    end

    def initialize(@value : Array(T))
    end

    def <=>(rhs : List)
      @value <=> rhs.to_a
    end

    def unsafe_fetch(index : Int)
      @value.unsafe_fetch(index)
    end

    def size
      @value.size
    end

    def fmap(lambda : T -> U) forall U
      List.new(@value.map { |value| lambda.call(value) })
    end

    def bind(lambda : T -> List(U)) forall U
      @value.map { |value| lambda.call(value) }.sum(List.new([] of U))
    end

    def +(rhs : List) : List
      List.new(@value + rhs.to_a)
    end

    def head : Maybe(T)
      return Nothing(T).new if @value.size == 0
      Just.new(@value.first)
    end

    def tail : List(T)
      return List.new(Array(T).new) if @value.size < 2
      List.new(@value[1..-1])
    end
  end
end
