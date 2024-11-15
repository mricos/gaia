eeg_gen_data(){
 echo "gen data"
}

eeg_record_for_milliseconds() {
    if [[ $# -ne 1 ]] || ! [[ $1 =~ ^[0-9]+$ ]]; then
        echo "Usage: record_for_milliseconds <milliseconds>"
        return 1
    fi

    local duration_seconds=$(bc <<< "scale=3; $1/1000")
    timeout "$duration_seconds" cat
}
