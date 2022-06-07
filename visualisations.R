library("openxlsx") 
library("tidyverse")
library("igraph")
library("ggraph") 

file = readline(prompt="Enter the name of the file: ")
data=read.xlsx(file, 1)
create_edge_graph <- function(data) {
    data %>% select(author_id, parent_question_user_id) -> edges
    return(edge_graph=graph_from_data_frame(edges, directed=TRUE))
}

create_dot_plot <- function(data) {
    edge_graph = create_edge_graph(data)
    print("Creating dot plot...")
    plot(edge_graph, vertex.size=10, vertex.label=NA)
}

create_line_circle <- function(data) {
    edge_graph = create_edge_graph(data)
    ggraph(edge_graph, layout = 'circle') + geom_edge_link() + geom_node_point()
}

# create_dot_plot(data)
create_line_circle(data)
