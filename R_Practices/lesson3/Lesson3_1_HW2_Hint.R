##
# Lecture 3
## HW2 Hints

#Sources:
  # https://plotly-r.com/d-charts


library(tidyverse)
library(dplyr)
library(lubridate)
library(ggplot2)
library(cowplot)
library(ggpubr)
library(lme4)
library(readr)
library(lmerTest)
library(lattice)
library(gridExtra)



file = "Lecture3_Dataset.csv"

all.df = read.csv(paste0(file), stringsAsFactors = F)
str(all.df)


summary(all.df)

nlevels(all.df$Activity)
unique(all.df$Activity)
all.df$Activity = factor(all.df$Activity, levels = c( "walking", "running"))
nlevels(all.df$Activity)
unique(all.df$Activity)

# find the NA rows in HR

all.df.HR.NAs = all.df[is.na(all.df$HR),]
nrow(all.df.HR.NAs)

# remove the NA rows in HR
all.df = all.df[!is.na(all.df$HR),]
all.df= all.df %>% group_by(Activity)

str(all.df)

#density functions

# - Filters
# 
#               CH1 (HR) 		CH2(Cadence)   Product(multip)
# Entity A (Wlk)
# 
# Entity B (Rnng)




# - Density functions
?density
tmp.d <- density(all.df$HR)
plot(tmp.d, main = "HR Density", col = "red")

# create a function / filter
?approxfun
# plot the function
tmm.p.d_fun1 <- approxfun(tmp.d$x, tmp.d$y)



tmm.p.d_fun1(100)
tmm.p.d_fun1(120)
tmm.p.d_fun1(140)



# - Density functions
?density
tmp.d1 <- density(all.df[all.df$Activity == "walking",]$HR)
plot(tmp.d1, main = "Walking HR Density")

# create a function / filter
#?approxfun
# plot the function
tmm.p.d_fun1 <- approxfun(tmp.d1$x, tmp.d1$y)
points(tmp.d1$x, tmp.d1$y, col = "red")



tmp.d2 <- density(all.df[all.df$Activity == "walking",]$Cadence)
plot(tmp.d2, main = "Walking Cadence Density")
# create a function / filter
tmm.p.d_fun2 <- approxfun(tmp.d2$x, tmp.d2$y)


tmp.d3 <- density(all.df[all.df$Activity == "running",]$HR)
plot(tmp.d3, main = "Running HR Density")
# create a function / filter
tmm.p.d_fun3 <- approxfun(tmp.d2$x, tmp.d2$y)

tmp.d4 <- density(all.df[all.df$Activity == "running",]$Cadence)
plot(tmp.d4, main = "Running Cadence Density")
# create a function / filter
tmm.p.d_fun4 <- approxfun(tmp.d4$x, tmp.d4$y)






all.df %>%
  mutate(walk_hr_density = tmm.p.d_fun1(HR),
         walk_cadence_density = tmm.p.d_fun2(Cadence),
         walk_multi = walk_hr_density * walk_cadence_density,
         run_hr_density = tmm.p.d_fun3(HR),
         run_cadence_density = tmm.p.d_fun4(Cadence),
         run_multi = run_hr_density * run_cadence_density 
         ) -> all.df


colnames(all.df)

# Ensure that Time is in POSIXct format
all.df$Time <- as.POSIXct(all.df$Time, format = "%H:%M:%S")




# With walking data ----

tmp_activity = "walking"
tmp.min = 0
tmp.max = 0.3





P11<-all.df %>%
  filter(Activity == tmp_activity) %>%
  ggplot() +
  geom_line( aes(x=Time, y = walk_hr_density) )   +
  theme_bw() +ylim(tmp.min,tmp.max) +
  labs(x = "", y = "") + ggtitle("Walking HR Filter")

P11

P12 <- all.df %>%
  filter(Activity == tmp_activity) %>%
  ggplot() +
  geom_line( aes(x=Time, y = walk_cadence_density) )+
  theme_bw() +ylim(tmp.min,tmp.max) +
  labs(x =  "", y = "") + ggtitle("Walk Cadence Filter")

P12

P13<-all.df %>%
  filter(Activity == tmp_activity) %>%
  ggplot() +
  geom_line( aes(x=Time, y = walk_multi) ) +
  theme_bw() +ylim(tmp.min,tmp.max) +
  labs(x =  "", y = "") + ggtitle("Combine Walking  Filter")

P13


# walking
tmp_activity = "walking"

P21<-all.df %>%
  filter(Activity == tmp_activity) %>%
  ggplot() +
  geom_line( aes(x=Time, y = run_hr_density) )  +
  theme_bw() +ylim(tmp.min,tmp.max) +
  labs(x = "", y = "") + ggtitle("Running HR Filter")

P21

P22<-all.df %>%
  filter(Activity == tmp_activity) %>%
  ggplot() +
  geom_line( aes(x=Time, y = run_cadence_density) ) +
  theme_bw() +ylim(tmp.min,tmp.max) +
  labs(x =  "", y = "") + ggtitle("Running Cadence Filter")

P22
P23<-all.df %>%
  filter(Activity == tmp_activity) %>%
  ggplot() +
  # geom_rect(aes(xmin = Time2,
  #               xmax = dplyr::lead(Time2),
  #               ymin = 0, ymax = Inf,
  #               fill = winner1), alpha = 1) +
  geom_line( aes(x=Time, y = run_multi) ) +
  theme_bw() +ylim(tmp.min,tmp.max) +
  labs(x =  "", y = "") + ggtitle("Combine Running Filter")

P23


Walking_final <- ggarrange(P11, P12, P13, P21, P22, P23,ncol = 3, nrow = 2, common.legend = TRUE, legend = "bottom") +
  ggtitle("Probabilistic filtering  on Walking") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = "none")

# With running data ----
  
tmp_activity = "running"
tmp.min = 0
tmp.max = 0.3


P11<-all.df %>%
  filter(Activity == tmp_activity) %>%
  ggplot() +
  geom_line( aes(x=Time, y = walk_hr_density) )   +
  theme_bw() +ylim(tmp.min,tmp.max) +
  labs(x = "", y = "") + ggtitle("Walk HR Filter")

P11

P12<-all.df %>%
  filter(Activity == tmp_activity) %>%
  ggplot() +
  geom_line( aes(x=Time, y = walk_cadence_density) )+
  theme_bw() +ylim(tmp.min,tmp.max) +
  labs(x =  "", y = "") + ggtitle("Walk Cadence Filter")

P12
P13<-all.df %>%
  filter(Activity == tmp_activity) %>%
  ggplot() +
  # geom_rect(aes(xmin = Time2,
  #               xmax = dplyr::lead(Time2),
  #               ymin = 0, ymax = Inf,
  #               fill = winner1), alpha = 1) +
  geom_line( aes(x=Time, y = walk_multi) ) +
  theme_bw() +ylim(tmp.min,0.005) +
  labs(x =  "", y = "") + ggtitle("Combine Walking Filter")

P13



P21<-all.df %>%
  filter(Activity == tmp_activity) %>%
  ggplot() +
  geom_line( aes(x=Time, y = run_hr_density) )  +
  theme_bw() +ylim(tmp.min,tmp.max) +
  labs(x = "", y = "") + ggtitle("Running HR Filter")

P21

P22<-all.df %>%
  filter(Activity == tmp_activity) %>%
  ggplot() +
  geom_line( aes(x=Time, y = run_cadence_density) ) +
  theme_bw() +ylim(tmp.min,tmp.max) +
  labs(x =  "", y = "") + ggtitle("Running Cadence Filter")

P22
P23<-all.df %>%
  filter(Activity == tmp_activity) %>%
  ggplot() +
  # geom_rect(aes(xmin = Time2,
  #               xmax = dplyr::lead(Time2),
  #               ymin = 0, ymax = Inf,
  #               fill = winner1), alpha = 1) +
  geom_line( aes(x=Time, y = run_multi) ) +
  theme_bw() + ylim(tmp.min,0.005) +
  labs(x =  "", y = "") + ggtitle("Combine Running  Filter")

P23


Running_final <- ggarrange(P11, P12, P13, P21, P22, P23,ncol = 3, nrow = 2, common.legend = TRUE, legend = "bottom") +
  ggtitle("Probabilistic filtering on Running Data") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = "none")









Final_final <- ggarrange(Walking_final, Running_final, ncol = 1, nrow = 2, common.legend = TRUE, legend = "bottom") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(legend.position = "none")


ggsave("Final_final.pdf", plot = Final_final, width = 10, height = 10, units = "in", dpi = 300)






#------------

# find the max label for each activity in product and save it's index to color background

# mycolors <- c(winner = "red", loser = "white")
# 
# all.df %>% 
#  mutate(max_ind = pmap_int(list(walk_multi, run_multi), ~which.max(c(...)))) 
# all.df
# 
# pmap_int(list(all.df$walk_multi, all.df$run_multi), ~which.max(c(...)))
# 
# sum(is.na(all.df$walk_multi))
# sum(is.na(all.df$run_multi))



#3D visualization
library(plotly)

# https://plotly-r.com/d-charts

# 1 D 
# all.df %>%
#   #filter(Activity == tmp_activity) %>%
#   plot_ly(x = ~HR ~Cadence,
#           color = ~Activity, colors = c("gray", "green", "brown", "orange", "cyan"),
#           #type = "mesh3d") %>%
#   #type = "scatter3d",
#   mode = "markers") %>%
#   layout(title = paste0("3D Visualization of Activities"),
#          scene = list(xaxis = list(title = "HR [BPM]"),
#                       yaxis = list(title = "Speed [km/h]"),
#                       zaxis = list(title = "Cadence [RPM]")) )


# 2 Dimensional Visualization  on time
all.df$Time2 =0

#1D
all.df %>%
  #filter(Activity == tmp_activity) %>%
  plot_ly(x = ~Time  , y = ~HR  ,
          color = ~Activity, colors = c("gray", "green", "brown", "orange", "cyan"),
          #type = "mesh3d") %>%
          #type = "scatter3d",
          mode = "markers") %>%
  layout(title = paste0("3D Visualization of Activities"),
         scene = list(xaxis = list(title = "Time"),
                      yaxis = list(title = "Speed [km/h]"),
                      zaxis = list(title = "Cadence [RPM]")) )

all.df %>%
  #filter(Activity == tmp_activity) %>%
  plot_ly(x = ~Time  , y = ~Cadence  ,
          color = ~Activity, colors = c("gray", "green", "brown", "orange", "cyan"),
          #type = "mesh3d") %>%
          #type = "scatter3d",
          mode = "markers") %>%
  layout(title = paste0("3D Visualization of Activities"),
         scene = list(xaxis = list(title = "Time"),
                      yaxis = list(title = "Speed [km/h]"),
                      zaxis = list(title = "Cadence [RPM]")) )




# 3D visualization

tmp_activity = "walking"
all.df %>%
  #filter(Activity == tmp_activity) %>%
  plot_ly(x = ~HR, y = ~Cadence, 
          color = ~Activity, colors = c("gray", "green", "brown", "orange", "cyan"),
  #        type = "mesh3d") %>%
  type = "scatter",mode = "markers") %>%
  layout(title = paste0("2D Visualization of Activities"),
         scene = list(xaxis = list(title = "HR [BPM]"),
                      yaxis = list(title = "Speed [km/h]"),
                      zaxis = list(title = "Cadence [RPM]")) )





browseURL("Lesson3_2_Inference.R")




