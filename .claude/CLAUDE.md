# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## What this is

**`erepublik.fr`** — site statique une page, portail historique de la communauté française du jeu eRepublik (eFrance), restauré en mai 2026 depuis les archives de la Wayback Machine.

## Stack

HTML5 statique + CSS vanilla, aucun framework ni build (pas de `package.json`). Matomo pour les analytics.

## Commands

Aucun build. Déploiement : push sur `main` → pull automatique par Plesk via webhook (voir README, section Déploiement).

## Architecture

Voir `.claude/ARCHITECTURE.md`.

## Files never to modify

Aucun fichier généré ou vendored dans ce repo.

## Git workflow

Default branch : `main`.

## Pointers

- **Always loaded** : `.claude/rules/cache-busting.md`.
- **Architecture** : `.claude/ARCHITECTURE.md`.
- **Skills** (à la demande) : aucun pour l'instant.
