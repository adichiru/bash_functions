#    toLog - a function for bash scripts that builds log files
#
#    Copyright (C) 2016  Adi E. Chiru (adichiru@gmail.com)
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>
###########################################################################

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
    log_file="$(basename $0).log"
    dt=$(date +"%Y%m%d")
    ts=$(date +"%H%M%S")
    if [ $# -eq 2 ]; then
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
             *)
		echo "Error calling toLog function. Exiting..."
		exit 1
        esac
        if [ ! -f $log_file ]; then
           echo "$dt $ts INFO File created." > "$log_file"
        fi
        if [ "$print_log_messages_on_screen" == "yes" ]; then
           echo "$dt $ts $msg_type $msg_body" | tee -a "$log_file"
        else
           echo "$dt $ts $msg_type $msg_body" >> "$log_file"
        fi
    else
	echo "Error calling toLog function. Exiting..."
	exit 1
    fi
}

