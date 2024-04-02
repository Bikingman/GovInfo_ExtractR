create_df <- function(url){
  create_nested <- function(n, final_text, title, original_node, original_location=NULL, text=NULL){
    nn = n+1
    tryCatch({
    if(is.na(nodes[nn] %>% html_element('cap-smallcap') %>% html_text()) & grepl("statutory", nodes[n] %>% html_attr('class'))){
      final_text = paste0(final_text, '\n', nodes[nn] %>% html_text() )
      t <- nodes[nn] %>% html_text()
      create_nested(nn, final_text, title, original_node, original_location, text=t)
    } else {
      if(!is.null(text)){
        t <- nodes[original_node + 1] %>% html_text()
        current_location <- paste0(
          gsub(current_statutory, "", original_location),
          str_extract_all(substr(t, 1, 10), "\\([^()]+\\)")[[1]], 
          '-', 
          str_extract_all(substr(text, 1, 10), "\\([^()]+\\)")[[1]] 
        )
      } else {
        current_location <-  gsub(current_statutory, "", original_location)
        
      }
      
      df <- rbind(df, 
                  data.frame(
                    law = title,
                    statuatory = current_statutory,
                    location = current_location,
                    text = final_text
                  ))
      return(list(n, final_text, df))
    }
    }, error = function(cond){
      print(nodes[n])
    })
  }
  preceeding_value <- ''
  current_location = ''
  current_statutory = ''
  sec = ''
  sec_1em = ''  
  sec_2em = ''
  sec_3em = ''
  sec_4em = ''
  
  sec_node = ''
  sec_1em_node = ''  
  sec_2em_node = ''
  sec_3em_node = ''
  sec_4em_node = ''
  
  sec_caps = FALSE
  sec_1em_caps = FALSE  
  sec_2em_caps = FALSE
  sec_3em_caps = FALSE
  sec_4em_caps = FALSE
  
  location = ''
  location_1em = ''  
  location_2em = ''
  location_3em = ''
  location_4em = ''
  
  final_text <-  ''
  currentn <- 1
  number = 0
  
  df <- data.frame()
  html <- read_html(url)
  
  nodes <- html_nodes(html,"p")
  
  # get the tiutle of the page
  title <- paste0(html_text(html_nodes(html, "title")), '; ', 
                  html_text(html_nodes(html, xpath = paste("//h3[@class='section-head']", sep=""))))
  title <- str_replace_all(title, "[^[:alnum:] ]", "")
  
  
  for (n in 1:length(nodes)){
    
    if (grepl("statutory", nodes[n] %>% html_attr('class')) & n >= currentn ) {
      text = nodes[n] %>% html_text()
      final_text =  text
      
      if(!is.na(nodes[n] %>% html_element('cap-smallcap') %>% html_text())){
        
        if(nodes[n] %>% html_attr('class') == 'statutory-body'){
          current_statutory = nodes[n]%>%
            html_children() %>%
            html_text() %>% 
            str_replace_all("[^[:alnum:] ]", "")
          
          sec <- str_extract_all(substr(text, 1, 10), "\\([^()]+\\)")[[1]] 
          location <- paste0(current_statutory, sec)
          current_location = location
        }
        if(nodes[n] %>% html_attr('class') == 'statutory-body-1em'){
          sec_1em <- str_extract_all(substr(text, 1, 10), "\\([^()]+\\)")[[1]] 
          location_1em <- paste0(current_statutory, sec, sec_1em)
          current_location = location_1em
        }
        if(nodes[n] %>% html_attr('class') == 'statutory-body-2em'){
          sec_2em <- str_extract_all(substr(text, 1, 10), "\\([^()]+\\)")[[1]] 
          location_2em <- paste0(current_statutory, sec, sec_1em, sec_2em)
          current_location = location_2em
        }
        if(nodes[n] %>% html_attr('class') == 'statutory-body-3em'){
          sec_3em <- str_extract_all(substr(text, 1, 10), "\\([^()]+\\)")[[1]] 
          location_3em <- paste0(current_statutory, sec, sec_1em, sec_2em, sec_3em)
          current_location = location_3em
        }
        if(nodes[n] %>% html_attr('class') == 'statutory-body-4em'){
          sec_4em <- str_extract_all(substr(text, 1, 10), "\\([^()]+\\)")[[1]] 
          location_4em = paste0(current_statutory, sec, sec_1em, sec_2em, sec_3em, sec_4em)
          current_location = location_4em
        }
        
        f = create_nested(n, final_text, title, n, current_location)
        df <- f[[3]]
        final_text <- f[[2]]
        currentn <- f[[1]]
      } 
    }
    
  }
  
  return(df)
}
