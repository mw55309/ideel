shell.executable("/bin/bash")

IDS, = glob_wildcards("genomes/{id}.fa")

rule all: 
	input: expand("hists/{sample}.png", sample=IDS)
	
rule prodigal:
	input: "genomes/{id}.fa"
	output: "proteins/{id}.faa"
	shell: "prodigal -a {output} -q -i {input}"

rule diamond:
	input: "proteins/{id}.faa"
	output: "lengths/{id}.data"
	threads: 4
	params:
		db="uniprot_trembl.diamond.dmnd",
		of="6 qlen slen"
	shell: "diamond blastp --threads {threads} --max-target-seqs 1 --db {params.db} --query {input} --outfmt {params.of} --out {output}"	

rule hist:
	input: "lengths/{id}.data"
	output: "hists/{id}.png"
	shell: "scripts/hist.R {input} {output}"
