function toLog () {
    # usage: call this function with one of these parameters:
    # -S Indicates the message type is SUCCESS
    # -E Indicates the message type is ERROR
    # -I Indicates the message type is INFO
    # -A Indicates the message type is ACTION
    # Example:
    #    toLog -E "message"
    #  will create a line in the log file like this:
    # 20160331 211001 ERROR message
    #
    log_file="script.log"
    dt=$(date +"%Y%m%d")
    ts=$(date +"%H%M%S")
    msg_type_indicator="$1"
    msg_body="$2"
    case ${msg_type_indicator} in
        -S)
            msg_type="SUCCESS";;
        -E)
            msg_type="ERROR";;
        -I)
            msg_type="INFO";;
        -A)
            msg_type="ACTION";;
    esac
    if [ ! -f $log_file ]; then
       echo "$dt $ts INFO File created." > "$log_file"
    fi
    if [ "$print_log_messages_on_screen" == "yes" ]; then
       echo "$dt $ts $msg_type $msg_body" | tee -a "$log_file"
    else
       echo "$dt $ts $msg_type $msg_body" >> "$log_file"
    fi
}

