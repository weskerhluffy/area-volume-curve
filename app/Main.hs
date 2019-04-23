import Text.Printf
monomio::Int->Int->Double->Double
monomio coeficiente exponente x = (fromIntegral coeficiente)
                                 * (x
                                    ^^ (fromIntegral exponente))

polinomio::[(Int, Int)]->(Int->Int->Double->Double)->[(Double->Double)]->[(Double->Double)]
polinomio [] _ p = p
polinomio ((coef,expo):xs) f p = polinomio xs f (p ++ [f coef expo])

evalua_polimonio::[(Double->Double)]->Double->Double
evalua_polimonio p x = foldl (\acc m -> acc + (m x)) 0.0 p

crea_polinomio::[Int]->[Int]->[(Double->Double)]
crea_polinomio a b = polinomio (zip a b) monomio []

area::[(Double->Double)]->Double->Int->Int->Double
area p s l r = sum $ map (*s) $ map (evalua_polimonio p) $ takeWhile (<(fromIntegral r+hs)) [(fromIntegral l),(fromIntegral l)+s..]
  where hs=s/2

area_debug::[(Double->Double)]->Double->Int->Int->[Double]
--area_debug p s l r = map (*s) $ map (evalua_polimonio p) $ takeWhile (<(fromIntegral r)) [(fromIntegral l)+hs,(fromIntegral l)+s+hs..]
area_debug p s l r = map (evalua_polimonio p) $ takeWhile (<(fromIntegral r)) [(fromIntegral l)+hs,(fromIntegral l)+s+hs..]
--area_debug p s l r = takeWhile (<(fromIntegral r)) [(fromIntegral l)+hs,(fromIntegral l)+s+hs..]
  where hs=s/2

calcula_area::[Int]->[Int]->Double->Int->Int->Double
calcula_area coeficientes exponentes s l r = area p s l r
  where p = crea_polinomio coeficientes exponentes

calcula_area_debug::[Int]->[Int]->Double->Int->Int->[Double]
calcula_area_debug coeficientes exponentes s l r = area_debug p s l r
  where p = crea_polinomio coeficientes exponentes

  -- This function should return a list [area, volume].
solve :: Int -> Int -> [Int] -> [Int] -> [Double]
solve l r a b = [calcula_area a b 0.001 l r, 0.0]

show2Decimals :: Double -> String
show2Decimals x = printf "%+.2f" x

-- XXX: https://stackoverflow.com/questions/36705679/how-to-use-text-printf-on-entire-lists
showDoubleList :: [Double] -> String
showDoubleList xs = unlines (map show2Decimals xs)

  --Input/Output.
main :: IO ()
--main = getContents >>= mapM_ (printf "%.1f\n"). (\[a, b, [l, r]] -> solve l r a b). map (map read. words). lines
main = printf "%f\n" ( calcula_area [1,2,3,4,5] [6,7,8,9,10] 0.001 1 4 )
--main = printf "%s\n" ( showDoubleList $ calcula_area_debug [1,2,3,4,5] [6,7,8,9,10] 0.1 1 2 )
