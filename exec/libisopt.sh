#LIBISOPT V1P3
function isopt() {
    case "${1:-}" in
    -? | --* | -?\:* | --*\:*)
        return 0
        ;;
    *)
        return 1
        ;;
    esac
}
