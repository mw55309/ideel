# ideel
Indels are not ideal - quick test for interrupted ORFs in bacterial/microbial genomes

# Dependencies:
* Snakemake
* Prodigal
* Diamond
* R

You will need a diamond index of UniProt TREMBL

# Install

Clone the repo.

```sh
git clone https://github.com/mw55309/ideel.git
```

Change directory into the repo folder

```sh
cd ideel
```

Put your genomes (with a ".fa" prefix) in folder genomes

Create all of the conda envs:

```sh
snakemake --use-conda --cores 1 --conda-create-envs-only
``` 

# download the reference DB

```sh
snakemake --use-conda --cores 1 create_ref
```

# run

```
snakemake --use-conda --cores 1 all
```
