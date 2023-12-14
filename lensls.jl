#!/bin/env julia

import Base.∘

#lens definition
struct Lens
    up::Function
    out::Function
end

#lens composition
∘(M::Lens, N::Lens) = Lens((s, i) -> N.up(s, M.up(N.out(s), i)), M.out ∘ N.out)

#lens parallel product
⊗(M::Lens, N::Lens) =
    Lens((s, i) -> (M.up(s[1], i[1]), N.up(s[2], i[2])), (s) -> (M.out(s[1]), N.out(s[2])))
