library("openxlsx") 
library("tidyverse")
library("igraph")

file = readline(prompt="Enter the name of the file: ")
data=read.xlsx(file, 1)

create_edge_graph <- function(data) {
    data %>% select(author_id, parent_question_user_id) -> edges
    return(edge_graph=graph_from_data_frame(edges, directed=TRUE))
}

create_table_graph <- function(edge_graph) {
    table_graph = as_tbl_graph(edge_graph)
    return(table_graph)
}

edge_graph = create_edge_graph(data)
density <- function() {
    print("Calculating density...")  
    edge_density(edge_graph, loops=FALSE)
}

diameter <- function() {
    print("Calculating diameter...")
    table_graph = create_table_graph(edge_graph)
    with_graph(table_graph, graph_diameter())
}

