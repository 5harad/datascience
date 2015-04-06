# load packages to workspace
library("ggplot")


# challenge answer
# 1
p <- ggplot() + 
  geom_point(data = mtcars, aes(x = mpg, y = hp, color=cyl), size = 3)
p

# 2
p <- ggplot() + 
  geom_point(data = mtcars, aes(x = mpg, y = hp, color=cyl), size = 3) + 
  geom_hline(yintercept = 200, linetype = 2) + 
  geom_vline(xintercept = 25, linetype = 2) +
  geom_point(data = mtcars[mtcars$hp > 200,] , aes(x = mpg, y = hp), color='darkred', shape = 4, size = 5)
p
