## for Josh and Cecilia
coin_flip <- function() {
  outcome <- sample(c("Josh win", "Cecilia win"), size = 1, prob = c(0.5, 0.5))
  return(outcome)
}

# Example usage:
coin_flip()

