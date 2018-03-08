# ideel
Indels are not ideal - quick test for interrupted ORFs in bacterial/microbial genomes

# Dependencies:
* Snakemake
* Prodigal
* Diamond
* R

You will need a diamond index of UniProt TREMBL

# run

Clone the repo.  Make a directory called "genomes", put assemblies in there with .fa file extension, then:

```
snakemake
```
