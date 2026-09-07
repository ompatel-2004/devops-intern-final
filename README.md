\# DevOps Intern Final Assessment



\[!\[CI Pipeline](https://github.com/ompatel-2004/devops-intern-final/actions/workflows/ci.yml/badge.svg)](https://github.com/ompatel-2004/devops-intern-final/actions/workflows/ci.yml)



\- \*\*Name:\*\* Om Patel

\- \*\*Date:\*\* September 2026

\- \*\*Role:\*\* DevOps Intern

\- \*\*Repository:\*\* https://github.com/ompatel-2004/devops-intern-final



\---



\## 1. Architecture Overview



This project implements an end-to-end DevOps pipeline for a containerized NGINX application.



The application is built from source, validated through GitHub Actions, published to GitHub Container Registry (GHCR), and designed for deployment through HashiCorp Nomad with Consul health checking.



Application logs are exposed through the container's standard output/error streams and collected by Promtail for Loki-based aggregation and Grafana-based exploration.



\### End-to-End Flow



```text

Developer

&#x20;   |

&#x20;   v

GitHub Repository

&#x20;   |

&#x20;   v

GitHub Actions

&#x20;   |

&#x20;   +--> ShellCheck / Hadolint

&#x20;   |

&#x20;   +--> Docker Build

&#x20;   |

&#x20;   +--> Application Health Test

&#x20;   |

&#x20;   v

GitHub Container Registry

&#x20;   |

&#x20;   v

HashiCorp Nomad

&#x20;   |

&#x20;   +--> Docker Driver

&#x20;   |

&#x20;   +--> Consul Service Registration

&#x20;   |

&#x20;   +--> /healthz Health Check

&#x20;   |

&#x20;   v

NGINX Application

&#x20;   |

&#x20;   +--> stdout/stderr

&#x20;           |

&#x20;           v

&#x20;        Promtail

&#x20;           |

&#x20;           v

&#x20;          Loki

&#x20;           |

&#x20;           v

&#x20;         Grafana

