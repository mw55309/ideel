shell.executable("/bin/bash")

IDS, = glob_wildcards("genomes/{id}.fa")

rule all: 
	input: expand("hists/{sample}.png", sample=IDS)

rule create_ref:
	input: "uniref50.dmnd"

rule download_and_create_ref:
	output: "uniref50.dmnd"
	conda: "envs/diamond.yaml"
	shell:
		'''
		wget https://ftp.uniprot.org/pub/databases/uniprot/uniref/uniref50/uniref50.fasta.gz
		diamond makedb --in uniref50.fasta.gz -d uniref50
		'''
	
rule prodigal:
	input: "genomes/{id}.fa"
	output: "proteins/{id}.faa"
	conda: "envs/prodigal.yaml"
	shell: "prodigal -a {output} -q -i {input}"

rule diamond:
	input: 
		pro="proteins/{id}.faa",
		ref="uniref50.dmnd"
	output: "lengths/{id}.data"
	threads: 4
	params:
		of="6 qlen slen"
	conda: "envs/diamond.yaml"
	threads: 16
	shell: "diamond blastp --threads {threads} --max-target-seqs 1 --db {input.ref} --query {input.pro} --outfmt {params.of} --out {output}"

	
rule hist:
	input: "lengths/{id}.data"
	output: "hists/{id}.png"
	conda: "envs/rbase.yaml"
	shell: "scripts/hist.R {input} {output}"
