
import logging

# temporary dirname when process each smali file
TEMP_DIR_NAME = "tmpclass/" 
LIB = "./lib"
BENIGN_CLASS_DIR = "./modules/benign_classes"

# define logger
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.INFO)

# DEFINED COMMAND: preserve original functionality
STRING         = "python2 strp.py -f {1}.apk string -c no;"
VARIABLE       = "python2 strp.py -f {1}.apk variable -c no;"
PCM            = "python2 pcm.py  -f {1}.apk package -c no;"
BYTECODE       = "python2 pcm.py  -f {1}.apk insbyte -c no;" 
BENIGN_CLASS   = "python2 pcm.py  -f {1}.apk bclass -c no;"
RESOURCE_IMAGE = "python2 res.py  -f {1} image -c no;"
RESOURCE_XML   = "python2 res.py  -f {1} resxml -c no -n yes;"
API_INTER      = "python2 api.py  -f {1}.apk inter -a android -c no;"
BEN_PERMISSION = "python2 api.py  -f {1}.apk bpermission -c no;"
API_REFLECTION = "python2 refl.py -f {1}.apk reflect -c no;"

ANTI_DATAFLOW  = "WILL RELEASE AFTER ACADEMIC SUBMISSION PROCESS"
COMPONENT_DIV  = "WILL RELEASE AFTER ACADEMIC SUBMISSION PROCESS"
FAMILY_CHANGER = "WILL RELEASE AFTER ACADEMIC SUBMISSION PROCESS"
POLY_STR_ENC   = "WILL RELEASE AFTER ACADEMIC SUBMISSION PROCESS"


# DESTRUCTIVE OBFUSCATIONS: only for inferring feature's impact
RM_RESOURCE_PAYLOAD = "python2 res.py   -f {1} payload -c no;"
RM_APIS             = "python2 rmapi.py -f {1}.apk rmall -c no;"
RM_PERMISSION       = "python2 api.py   -f {1}.apk permission -c no;"


# Obfuscation Group for individual APK disguise
#OBFUSCATION_LIST = [PCM]
OBFUSCATION_LIST = [VARIABLE]
#OBFUSCATION_LIST = [API_REFLECTION]

# Inferring Group
INFERRING_LIST  = [API_REFLECTION, STRING, VARIABLE, PCM, BENIGN_CLASS, \
                   RESOURCE_IMAGE+RESOURCE_XML, RM_PERMISSION]
#INFERRING_LIST = [RESOURCE_IMAGE+RESOURCE_XML]

BLACKLIST_STRING = []  # e.g., '134-333-1234', 'http://mal.com'
BLACKLIST_API    = []  # e.g., 'toString'
