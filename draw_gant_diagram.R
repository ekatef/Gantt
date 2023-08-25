library(ggplot2)
library(lubridate)
library(reshape2)
library(scico)

tasks <- c(
    "Step 1", 
        "Sub-step 1.1",
        "Sub-step 1.2",
    "Step 2",
        "Sub-step 2.1",
        "Sub-step 2.2",
    "Step 3",
        "Sub-step 3.1",
        "Sub-step 3.2"

)
dfr <- data.frame(
    name       = factor(tasks, levels = tasks),
    start.date = ymd(
        c(
            "2024-01-01", 
                "2024-01-01",
                "2024-06-01", 
            "2024-03-01",
                "2024-04-01",
                "2024-06-01",
            "2024-10-01",
                "2025-01-01",
                "2025-06-01"          
        )
    ),
    end.date   = ymd(
        c(
            "2024-12-31",
                "2024-12-31",
                "2025-06-01",
            "2024-12-31",
                "2024-12-31",
                "2024-12-31",
            "2025-12-31",
                "2025-06-01",
                "2025-12-31"          
        )
    ),
    # is.sub=c(FALSE, TRUE, TRUE, FALSE, FALSE)
    type = c(
        "main",
            "sub",
            "sub", 
        "main",
            "sub",
            "sub",
        "main",
            "sub",
            "sub"      
    )
)
mdfr <- melt(dfr, measure.vars = c("start.date", "end.date"))

pl <- ggplot(mdfr, aes(rev(value), rev(name), colour = rev(type)))+ 
    geom_line(size = 10)+
    xlab(NULL)+ 
    ylab(NULL)+
    scale_x_date(
        limits = range(mdfr$value), 
        date_breaks = "6 month",
        # breaks=mdfr$value,
        expand = c(0, 0),
        minor_breaks = "1 month",
        date_labels = "%d %b %Y",
        position = "top"
    )+
    scale_y_discrete(limits = rev)+
    # scale_color_discrete(name="")+
    scale_color_scico_d(
        # begin=0.3,
        # end=0.7,
        # palette="lajolla",

        # begin=0.1,
        # end=0.9,        
        # palette="berlin",

        # begin=0.3,
        # end=0.8,        
        # palette="buda",

        # begin=0.3,
        # end=0.8,        
        # palette="hawaii",

        begin = 0.75,
        end = 0.9,        
        palette = "tofino",

        name = ""
    )+    
    theme_bw()+
    theme(
        # text = element_text(size = 18, family = "mono"),
        # text = element_text(size = 18, family = "Times"),
        text = element_text(
            size = 24,
            family = "Helvetica-Narrow",
            face = "bold"
        ),
        panel.grid.major = element_line(colour = "grey10", size = 0.5),
        panel.grid.minor = element_line(colour = "grey10", size = 0.1)
    )

ggsave("draft_gant.pdf", width = 14, heigh = 12)