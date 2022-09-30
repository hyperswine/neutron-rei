---
layout: math
title: Neutron (Rei)
nav_order: 1
---

## Design

Neutron tries to be as minimal as possible.

The syscalls neutron defines are a very small set of services that allow userspace sparx to regularly authenticate themselves and directly access system resources without kernel intervention. Thus allowing other processes/apps to do so completely in userspace through IPC and zero copy semantics.

## Maths

$$
50000 = 6 \times T
$$

## Diagrams

Here is one mermaid diagram:
<div class="mermaid">
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop Healthcheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts <br/>prevail!
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!
</div>
