package panels

commonGaugeSpec: {
    spec: {
        calculation: "last-number",
        format: unit: "percent",
        max: 100,
        thresholds: {
            steps: [
                { color: "rgba(50, 172, 45, 0.97)", value: 0 },
                { color: "rgba(237, 129, 40, 0.89)", value: 80 },
                { color: "rgba(245, 54, 54, 0.9)", value: 90 }
            ]
        }
    }
}