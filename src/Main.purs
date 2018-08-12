module Main where

import Prelude

import Effect (Effect)
import ExpectInferred (expectInferred)
import Prim.Boolean as Boolean
import Prim.Row as Row
import Type.Prelude (BProxy(..), Proxy(..), SProxy(..))

rowContains
  :: forall proxy row label result
   . Row.Contains label row result
  => SProxy label
  -> proxy row
  -> BProxy result
rowContains _ _ = BProxy

testA :: Unit
testA =
  let
    expected = Proxy :: Proxy (BProxy Boolean.True)
    actual = rowContains (SProxy :: SProxy "a") { a: 1 }
  in
    expectInferred expected actual

testB :: Unit
testB =
  let
    expected = Proxy :: Proxy (BProxy Boolean.False)
    actual = rowContains (SProxy :: SProxy "a") {}
  in
    expectInferred expected actual

main :: Effect Unit
main = pure unit
