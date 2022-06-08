library("openxlsx") 
library("tidyverse")
library("igraph")

# file = readline(prompt="Enter the name of the file: ")

data=read.xlsx("data.xlsx", 1)

create_edge_graph <- function(data) {
    data %>% select(author_id, parent_question_user_id) -> edges
    return(edge_graph=graph_from_data_frame(edges, directed=TRUE))
}

create_table_graph <- function(edge_graph) {
    table_graph = as_tbl_graph(edge_graph)
    return(table_graph)
}

edge_graph = create_edge_graph(data)
table_graph = create_table_graph(edge_graph)

density <- function() {
    print("Calculating density...")  
    edge_density(edge_graph, loops=FALSE)
}

diameter <- function() {
    print("Calculating diameter...")
    with_graph(table_graph, graph_diameter())
}

reciprocity <- function() {
    print("Calculating reciprocity...")
    with_graph(table_graph, graph_reciprocity())
}

# Getting "Error in transitivity(edge_graph) : unused argument (edge_graph)"
# transitivity_custom <- function() {
#     print("Calculating transitivity...")
#     transitivity(edge_graph)
# }

average_path_length <- function() {
    print("Calculating average path length...")
    table_graph = create_table_graph(edge_graph)
    with_graph(table_graph, graph_mean_dist())
}

# Getting similar to transitivity
# betweenness_custom <- function() {
#     print("Calculating betweenness...")
#     betweenness()
# }

