# Improving Intrusion Detection in Distributed Systems with Federated Learning

> [!WARNING]  
> The thesis has not been defended yet! The defense is scheduled for **October, 7th 2024** at **IMT Atlantique**, Rennes, France, at **1:30 PM**.


This repository hosts my PhD thesis, which studies the challenges and opportunities of using federated learning to build collaborative intrusion detection systems. 


## Thesis Map-of-Content

In addition to the manuscript itself, this PhD thesis has produced a number of artifacts that are available in open access. 

- [The manuscript]()
- [The slides]()
- [`eiffel`](https://github.com/leolavaur/eiffel): An evaluation framework collaborative intrusion detection systems leveraging federated learning.
- 

## Repository

The repository is organized as follows:
```plaintext
.
├── README.md
├── flake.nix  -> The Nix environment file
├── flake.lock
├── src/
│   ├── 
└── 
    
```

## Abstract

Collaboration between different cybersecurity actors is essential to fight against increasingly sophisticated and numerous attacks. However, stakeholders are often reluctant to share their data, fearing confidentiality and privacy issues and the loss of their competitive advantage, although it would improve their intrusion detection models. Federated learning is a recent paradigm in machine learning that allows distributed clients to train a common model without sharing their data. These properties of collaboration and confidentiality make it an ideal candidate for sensitive applications such as intrusion detection. While several applications have shown that it is indeed possible to train a single model on distributed intrusion detection data, few have focused on the collaborative aspect of this paradigm. In this manuscript, we study the use of federated learning to build collaborative intrusion detection systems. In particular, we explore (i) the impact of data quality in heterogeneous contexts, (ii) the exposure to certain types of poisoning attacks, and (iii) tools and methodologies to improve the evaluation of these types of algorithms.
