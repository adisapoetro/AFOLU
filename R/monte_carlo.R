






distribution.in.tibble = function(mu, sigma, length = 1000) {
  v = carray(numeric(), c(nrow(data), 2, length))
  data = c(data$mu, data$sigma)
  distribution = array(numeric(), c(nrow(data), 1, length))
  for (j in 1:ncol(data)) {
    for (i in 1:nrow(data)) {
      new.data[i,j,] = value.to.distribution(data[i, mu.col], data[i, sigma.col], length=length)
    }
    new.data[,,i] = data.frame()value.to.distribution(data[i,mu.col],data[i,sigma.col],length=length)
  }
  return(new.data)
}


value.to.distribution = function(mu, sigma, length = 1000, type = "Normal") {
  alpha = (mu^2 - mu^3 - mu * sigma^2) / sigma^2
  beta = (mu - 2 * mu^2 + mu^3 - sigma^2 + mu * sigma^2 ) / sigma^2
  if(type == "Normal") dist = rnorm(length, mu, sigma)
  if(type == "Beta") dist = rbeta(length, alpha, beta)
  return(dist)
}