BEGIN { FS = ","; }
NR > 1 {
    for (i=1; i<=NF; i++) {
        max[i] = (length($i) > max[i] ? length($i) : max[i]);
    }
}
END {
    for (i=1; i<=NF; i++) {
        printf("%d%s", max[i], (i == NF ? RS : FS))
    }
}