import Text.Printf
monomio::Int->Int->Int->Double
monomio coeficiente exponente x = (fromIntegral coeficiente)
                                 * ((fromIntegral x)
                                    ^^ (fromIntegral exponente))

-- polinomio::[(Int, Int)]->(Int->Int->Int->Double)->[(Int->Double)]
-- polinomio [] _ p = p
-- polinomio (coef, exp):xs f p = polinomio xs f p:(f coef exp)

polinomio::[(Int, Int)]->(Int->Int->Int->Double)->[(Int->Double)]->[(Int->Double)]
polinomio [] _ p = p
polinomio ((coef,expo):xs) f p = polinomio xs f (p ++ [f coef expo])

main :: IO ()
main = printf "%f\n" (monomio (-10) (-5) (31))
