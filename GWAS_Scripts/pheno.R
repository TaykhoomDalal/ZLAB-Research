# Extract relevant columns from ukbb phenotype file; put into PLINK format 
#   for performing association.
# Author: Kathy Burch
# =============================================================================
library(data.table)
library(dplyr, quietly = TRUE)
library(magrittr)

#' Main function
main <- function() {

  # Read command-line arguments
  trait <- "height"
  pheno_id <- "f.50.0.0"
  pc_id <- paste0("f.22009.0.", c(1:20))
  ethnic_id <- "f.22006.0.0"
  covar_id <- NA
  #trait <- args[[1]]
  #pheno_id <- args[[2]]
  #pc_id <- args[[3]]
  #covar_id <- args[[4]]

  indiv_id <- "f.eid"
  age_id <- "f.21003.0.0"
  sex_id <- "f.31.0.0"

  # Make output directory
  out_dir <- paste0("/u/scratch/t/taykhoom/")
  dir.create(file.path(out_dir, trait), showWarnings = FALSE)
  out_dir %<>% paste0(., trait, "/")

  keeps <- c(indiv_id, pheno_id, age_id, sex_id, ethnic_id)
  if (sum(is.na(pc_id)) == 0) {
    keeps <- c(keeps, pc_id)
  }
  if (sum(is.na(covar_id)) == 0) {
    keeps <- c(keeps, covar_id)
  }

  # Read only relevant columns of phenotype file
  pheno_file <- "~/project-ukbiobank/33127/ukb21970.tab" %>%
    fread(., header = T, select = keeps)

  # Convert female sex from 0 to 2 for plink
  pheno_file[get(sex_id) == 0, (sex_id) := 2]

  # Create main phenotype file for plink
  pheno_out <- data.table(
    FID = pheno_file$f.eid, 
    IID = pheno_file$f.eid, 
    pheno = unlist(select(pheno_file, pheno_id))
  )

  # Rank inverse normal transformation of phenotypes (exclude NA phenotypes)
  pheno_out[!is.na(pheno), pheno := rank_inv_normal_transform(pheno)]

  # Create covariate file for plink
  covar_out <- data.table(
    FID = pheno_file$f.eid, 
    IID = pheno_file$f.eid, 
    sex = unlist(pheno_file[, get(sex_id)]),
    age = unlist(pheno_file[, get(age_id)]),
    age_squared = unlist(pheno_file[, get(age_id)])*unlist(pheno_file[, get(age_id)]),
    sex_age = unlist(pheno_file[, get(age_id)])*unlist(pheno_file[, get(sex_id)]),
    sex_age_squared = unlist(pheno_file[, get(age_id)])*unlist(pheno_file[, get(age_id)])*unlist(pheno_file[, get(sex_id)]),
    ethnicity = unlist(pheno_file[, get(ethnic_id)])
  )
  if (sum(is.na(pc_id)) == 0) {
    covar_out %<>% cbind(., select(pheno_file, pc_id))
  }
  if (sum(is.na(covar_id)) == 0) {
    covar_out %<>% cbind(., select(pheno_file, covar_id))
  }

  # Fill missing values with -9
  pheno_out[is.na(pheno), pheno := -9]
  covar_out[is.na(covar_out), ] <- -9

  # Output plink files
  paste0(out_dir, trait, ".pheno") %>%
    fwrite(pheno_out, 
      file = ., 
      col.names = T, 
      quote = F, 
      row.names = F, 
      sep = " "
    )
  paste0(out_dir, trait, ".covar") %>%
    fwrite(covar_out, 
      file = ., 
      col.names = T, 
      quote = F, 
      row.names = F, 
      sep = " "
    )
}

#' Rank inverse normal transformation of phenotypes
#' @param pheno Vector of numeric phenotypes
#' @return Transformed phenotypes
#' 
rank_inv_normal_transform <- function(pheno) {
  pheno_rank <- rank(pheno, ties.method = "average")
  N <- length(pheno)
  c <- 3 / 8
  deno <- N - (2 * c) + 1
  transformed <- (pheno_rank - c) / deno
  norm_vars <- qnorm(transformed)
  return(norm_vars)
}

main()

