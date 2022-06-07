library("openxlsx") 
library("tidyverse")
library("igraph") 

file = readline(prompt="Enter the name of the file: ")
data=read.xlsx(file, 1)
create_dot_plot <- function(data) {
    data %>% select(author_id, parent_question_user_id) -> edges
    edge_graph=graph_from_data_frame(edges, directed=TRUE)
    plot(edge_graph, vertex.size=10, vertex.label=NA)
}

create_dot_plot(data)
