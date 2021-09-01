#################################################################################
#                                                                               #
#                        Packets listener                                       #
#                               by:                                             #
#                             @idotek                                           #
#                                                                               #
#################################################################################
interface=toninterfaceici
ipv4=tonipici
old_b=$(grep $interface /proc/net/dev | cut -d : -f2 | awk '{print $1}')
old_pkt=$(grep $interface /proc/net/dev | cut -d : -f2 | awk '{print $2}')
max=50000
sleep 1

new_b=$(grep $interface /proc/net/dev | cut -d : -f2 | awk '{print $1}')
new_pkt=$(grep $interface /proc/net/dev | cut -d : -f2 | awk '{print $2}')

pps=$(($new_pkt - $old_pkt))
byte=$(($new_b - $old_b))

echo $pps pps at $(date +"%M-%H-%d-%m-%Y")
echo $byte b/ps
echo -----
if [ "$pps" -ge "$max" ]
then
        tcpdump dst $ipv4 -nnc 100000 -w capture-$(date +"%M-%H-%d-%m-%Y").pcap
fi
