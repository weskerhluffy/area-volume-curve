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

area::[(Double->Double)]->Int->Int->Double
area p l r = sum $ map (evalua_polimonio p) $ takeWhile (<(fromIntegral r)) [(fromIntegral l)+0.05::Double,(fromIntegral l)+(0.1::Double)..]

calcula_area::[Int]->[Int]->Int->Int->Double
calcula_area coeficientes exponentes l r = area p l r
  where p = crea_polinomio coeficientes exponentes

main :: IO ()
-- main = printf "%f\n" (monomio (-10) (-5) (31))
main = printf "%f\n" (monomio (-10) (-5) (31))
