
grep -rl "'package:infinity_core\/" | xargs sed -i "" "s/'package:infinity_core\//'package:ume_kit_monitor\//g"
