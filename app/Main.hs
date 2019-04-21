import Text.Printf
monomio::Int->Int->Int->Double
monomio coeficiente exponente x = (fromIntegral coeficiente)
                                 * ((fromIntegral x)
                                    ^^ (fromIntegral exponente))

polinomio::[(Int, Int)]->(Int->Int->Int->Double)->[(Int->Double)]->[(Int->Double)]
polinomio [] _ p = p
polinomio ((coef,expo):xs) f p = polinomio xs f (p ++ [f coef expo])

evalua_polimonio::[(Int->Double)]->Int->Double
evalua_polimonio p x = foldl (\acc m -> acc + (m x)) 0.0 p

crea_polinomio::[Int]->[Int]->[(Int->Double)]->[(Int->Double)]
crea_polinomio [] _ p = p
crea_polinomio _ [] p = p
crea_polinomio a b p = polinomio (zip a b) monomio []

main :: IO ()
main = printf "%f\n" (monomio (-10) (-5) (31))
