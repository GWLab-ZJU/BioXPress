# Global `init.md`

This is the global `init.md`, containing instructions for initializing BioXPress ("*BioXP*" for short).

## The Idea of BioXPress

Aiming at building a flexible platform supporting all types of sequencing data and work load, we build this project. The following are some core ideas of this project, and you might be interested in peaking into some of them to make your process more fluently.

### The BioXPress is Module-Based.

The modules (so called "*wagons*" in this project) are the one of the center components of this project and can be flexibly organized.

We define three dependence relationship to each wagon, they are:

1. `bindep` are the binaries of the programs that a wagon depend on. For example, wagon `bwa` depends on binary `bwa` and `samtools`. To satisfy this dependency, you can add those binaries to your `$PATH` environment variable or specify their absolute path in `etc/bin.conf`.
2. `filedep` are the reference files that a wagon need. For example, wagon `bwa` depends on a folder named `bwaref`, which should be pointed to the `fasta` file of reference genome, with its `bwa` reference files in the same folder. You must define them in `etc/file.conf`.
3. `wagondep` (or `forward`), are the wagons that a specific wagon depend on. For example, wagon `bwa` can depend on wagon `origin`, `trimmomatic` or `cutadapt`. A wagon with no dependencies are considered to be `leading wagon` (For example, wagon `origin`.) and the number of which should be precisely one in one BioXPress. A wagon will also have incompatible wagons, for example,  `trimmomatic` and `cutadapt` is incompatible of each other.

`bindep` and `filedep` will be checked at the end of `configure` step (See below), but `wagondep` will be checked at `init` step.

### The BioXPress is Process-Driven

Another center component of BioXPress is process. The processing management machinery of BioXPress can be roughly demonstrated as follows:

1. The leading wagon started, with the wagons in the second step waiting.
2. The second wagon will initiate several sub-processes, one for each cluster (A *cluster* is a set of files satisfying the minimal of starting a process. For example, a cluster of wagon `fastqc` includes 1 `fastq` file, while a cluster of wagon `bwa` includes 2 `fastq` file). Then this sub-process will wait until the cluster is prepared by previous wagon.
3. The loop will continue until reaching the end or when error occurred.

The BioXPress might use an external job system. We currently support IBM LSF (`bsub`) and YuZJLab YLSJS (`ylsjs`). You may specify them in `etc/jobsys.conf`.

## BioXPress Workflow

1. List the wagons you'll use in `etc/wagons.conf` and execute `bioxp init` to initialize a project.
2. Add sequencing files \& configuration files to the folder of each wagons based on the instructions given by each wagon (see below) and execute `bioxp configure`.
3. Execute `bioxp start` to start the project. If the wagon is a `stop wagon`, the process will be stopped. An instruction will be give to help you restart the precess. If there's an error, the process will terminated instantly.

## Input for BioXPress

### General Rules

(Of course this "train" do not accept coal and water.)

Firstly, the input should be consisting of several set of samples.

A **SET OF SAMPLE** should consist of **ONE** normal sample with the name of `case_${num}_gremline` and several tumour sample naming after `case_${num}_tumour*`.

A **SAMPLE** should consist of 2 `fastq` file named `${sample_name}_1.fq.gz` and `${sample_name}_2.fq.gz`.

There should be a file named `etc/cases.conf` in the root directory of this pipeline indicating the relationship between filenames and sample names. For example,

```config
#FQ ID
#SRR3182418 case5_germline
SRR3182419 case2_germline
SRR3182420 case4_germline
SRR3182421 case3_germline
SRR3182422 case6_germline
SRR3182423 case1_germline
```

In fact the extension name of each file may not be exactly `fq.gz`; it can be one of `*.fq *.fastq *.fq.gz *.fastq.gz`! File with extension name other than `fq.gz` will be renamed and/or compressed automatically.

### The Input Wagon

The wagon `origin` is the wagon where you list all your input sequencing.

### Files from Online Databases

We also provide a script for downloading files online by `ascp` (which means that you must have it installed, or define it at `bin.conf`). To do this, you should prepare a file called `ENA-FQ.conf` which lists all Aspera URLs for the file you want to download. For example,

```
#A sample of file ENAFA
#fasp.sra.ebi.ac.uk:/vol1/fastq/SRR318/003/SRR3182423/SRR3182423_1.fastq.gz
#fasp.sra.ebi.ac.uk:/vol1/fastq/SRR318/003/SRR3182423/SRR3182423_2.fastq.gz
#fasp.sra.ebi.ac.uk:/vol1/fastq/SRR318/009/SRR3182419/SRR3182419_1.fastq.gz
#fasp.sra.ebi.ac.uk:/vol1/fastq/SRR318/009/SRR3182419/SRR3182419_2.fastq.gz
#fasp.sra.ebi.ac.uk:/vol1/fastq/SRR318/003/SRR3182433/SRR3182433_1.fastq.gz
#fasp.sra.ebi.ac.uk:/vol1/fastq/SRR318/003/SRR3182433/SRR3182433_2.fastq.gz
fasp.sra.ebi.ac.uk:/vol1/fastq/SRR318/007/SRR3182437/SRR3182437_1.fastq.gz
fasp.sra.ebi.ac.uk:/vol1/fastq/SRR318/007/SRR3182437/SRR3182437_2.fastq.gz
```

Lines starting with a `#` or not specified in `etc/cases.conf` will be ignored.

### Raw Sequencing Data

Waiting...

## Getting Help

For each wagon, you may find its help under its `doc` folder. It would also be shown in `init` step.

For each `bioxp` command, you may find its help by `bioxp [cmd] -h`. Use `bioxp list` to get a list of available command.

## See Also

 