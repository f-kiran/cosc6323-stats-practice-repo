
require(tidyverse)
require(ggpubr)
require(reshape2) 

condition <- c("a", "a", "a", "b", "b", "b", "c", "c", "c", "c")
binary_1 <- c(0,0,0,0,0,1,1,1,1,1)
binary_2 <- c(1,1,1,1,1,1,0,0,0,0)
binary_3 <- c(0,1,1,1,1,1,1,1,0,0)
binary_4 <- c(1,1,1,0,0,0,0,0,0,0)


df <- data.frame(condition, binary_1, binary_2, binary_3, binary_4)
df

gg_df <- df %>%
  mutate(binary_1 = as.factor(binary_1), binary_2 = as.factor(binary_2), binary_3 = as.factor(binary_3), binary_4 = as.factor(binary_4))
?melt

#gg_melt <- melt(gg_df)
gg_melt <- gg_df

my_theme <- theme_bw() + 
  xlab("Condition") + 
  ylab("Number of Participants") +
  theme(plot.title = element_text(size = 10, face="bold", hjust = 0.5),
        aspect.ratio = 1.,
        legend.title=element_text(size=10, face = "bold"), axis.title = element_text(size=10, face = "bold"), axis.text = element_text(size=10),
        legend.position = "center"
        
  ) 



gg_1 <- ggplot(gg_melt, aes(x=condition, fill = binary_1)) +
  geom_bar(stat="count") +
  ggtitle("Binary 1") +
  scale_fill_manual(values = c("#FDAE61", "#9E0142"), name = "Behaviour Observed", labels = c("0" = "Absent", "1" = "Present")) +
  scale_x_discrete(labels = c(a = " A", b = " B", c = " C")) +
  xlab("Condition") + 
  ylab("Number of Participants") +
  theme(plot.title = element_text(size = 10, face="bold", hjust = 0.5),
        aspect.ratio = 1.,
        legend.title=element_text(size=10, face = "bold"), axis.title = element_text(size=10, face = "bold"), axis.text = element_text(size=10),
        legend.position = "center"
        
  ) 

gg_2 <- ggplot(gg_melt, aes(x=condition, fill = binary_2)) +
  geom_bar(stat="count") +
  scale_fill_manual(values = c("#FDAE61", "#9E0142"), name = "Behaviour Observed", labels = c("0" = "Absent", "1" = "Present")) +
  scale_x_discrete(labels = c(a = " A", b = " B", c = " C")) +
  xlab("Condition") + 
  ylab("Number of Participants") +
  ggtitle("Binary 2") +
  theme(plot.title = element_text(size = 10, face="bold", hjust = 0.5)) +
  theme(aspect.ratio = 1) +
  theme(legend.title=element_text(size=10, face = "bold"), axis.title = element_text(size=10, face = "bold"), axis.text = element_text(size=10))+
  theme(legend.box.just = "center")

gg_3 <- ggplot(gg_melt, aes(x=condition, fill = binary_3)) +
  geom_bar(stat="count") +
  scale_fill_manual(values = c("#FDAE61", "#9E0142"), name = "Behaviour Observed", labels = c("0" = "Absent", "1" = "Present")) +
  scale_x_discrete(labels = c(a = " A", b = " B", c = " C")) +
  xlab("Condition") + 
  ylab("Number of Participants") +
  ggtitle("Binary 3") +
  theme(plot.title = element_text(size = 10, face="bold", hjust = 0.5)) +
  theme(aspect.ratio = 1) +
  theme(legend.title=element_text(size=10, face = "bold"), axis.title = element_text(size=10, face = "bold"), axis.text = element_text(size=10))+
  theme(legend.box.just = "center")

gg_4 <- ggplot(gg_melt, aes(x=condition, fill = binary_4)) +
  geom_bar(stat="count") +
  scale_fill_manual(values = c("#FDAE61", "#9E0142"), name = "Behaviour Observed", labels = c("0" = "Absent", "1" = "Present")) +
  scale_x_discrete(labels = c(a = " A", b = " B", c = " C")) +
  xlab("Condition") + 
  ylab("Number of Participants") +
  ggtitle("Binary 4") +
  theme(plot.title = element_text(size = 10, face="bold", hjust = 0.5)) +
  theme(aspect.ratio = 1) +
  theme(legend.title=element_text(size=10, face = "bold"), axis.title = element_text(size=10, face = "bold"), axis.text = element_text(size=10))+
  theme(legend.box.just = "center")









figure <- ggarrange(gg_1, gg_2, gg_3, gg_4,
                    labels = NULL,
                    ncol = 2, nrow = 4,
                    common.legend = TRUE, legend = "bottom",
                    align = "hv",
                    font.label = list(size = 10, color = "black", face = "bold", family = NULL, position = "top"))


filename = "Lesson2_Test_1.pdf"
full_path <- file.path( filename)
#ggsave(full_path, figure, width = 8, height = 4, units = "in", dpi = 300)





require(grid)   # for the textGrob() function

figure <- ggarrange(gg_1 + rremove("ylab") + rremove("xlab"), 
                    gg_2 + rremove("ylab") + rremove("xlab"), 
                    gg_3 + rremove("ylab") + rremove("xlab"), 
                    gg_4+ rremove("ylab") + rremove("xlab"), # remove axis labels from plots
                    labels = NULL,
                    ncol = 2, nrow = 2,
                    common.legend = TRUE, legend = "bottom",
                    align = "hv", 
                    font.label = list(size = 10, color = "black", face = "bold", family = NULL, position = "top"))


ann.fig = annotate_figure(figure, left = textGrob("Common y-axis", rot = 90, vjust = 1, gp = gpar(cex = 1.3)),
                          bottom = textGrob("Common x-axis", gp = gpar(cex = 1.3)))

filename = "Lesson2_Test_2.pdf"
full_path <- file.path( filename)
#ggsave(full_path, ann.fig, width = 8, height = 4, units = "in", dpi = 300)
```



#Plot using facet_wrap


ggplot(gg_melt, aes(x=condition, fill = binary_1)) +
  geom_bar(stat="count") +
  scale_fill_manual(values = c("#FDAE61", "#9E0142"), name = "Behaviour Observed", labels = c("0" = "Absent", "1" = "Present")) +
  scale_x_discrete(labels = c(a = " A", b = " B", c = " C")) + 
  xlab("Condition") + 
  ylab("Number of Participants") #+
#facet_wrap(~condition, ncol = 3) 


```