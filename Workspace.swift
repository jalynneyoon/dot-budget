// Workspace.swift
import ProjectDescription

let workspace = Workspace(
    name: "DotBudget",
    projects: [
        "./App",
        "./Features/**",
        "./Core/**",
        "./Domain/**",
        "./Data/**",
        "./DI",
        "./Shared/**",
    ]
)
