########################################################################
# Logging Variables
########################################################################
IF(CMAKE_BUILD_TYPE STREQUAL "Debug")
    SET(UHD_LOG_MIN_LEVEL "debug" CACHE STRING "Set UHD log level to {trace, debug, info, warning, error, fatal}")
    SET(UHD_LOG_CONSOLE_DISABLE "OFF" CACHE BOOL "Disable UHD logging to stderr")
    SET(UHD_LOG_FILE_LEVEL "trace" CACHE STRING "SET UHD file logging level to {trace, debug, info, warning, error, fatal}")
    SET(UHD_LOG_CONSOLE_LEVEL "debug" CACHE STRING "SET UHD file logging level to {trace, debug, info, warning, error, fatal}")
ELSE()
    SET(UHD_LOG_MIN_LEVEL "debug" CACHE STRING "Set UHD log level to {trace, debug, info, warning, error, fatal}")
    SET(UHD_LOG_CONSOLE_DISABLE "OFF" CACHE BOOL "Disable UHD logging to stderr")
    SET(UHD_LOG_FILE_LEVEL "info" CACHE STRING "SET UHD file logging level to {trace, debug, info, warning, error, fatal}")
    SET(UHD_LOG_CONSOLE_LEVEL "info" CACHE STRING "SET UHD file logging level to {trace, debug, info, warning, error, fatal}")
ENDIF()

FUNCTION(UHD_LOG_LEVEL_CONVERT ARG1 ARG2)
    string(TOLOWER "${ARG1}" LOG_LEVEL_LOWER)
    IF(LOG_LEVEL_LOWER STREQUAL "trace")
        ADD_DEFINITIONS(-D${ARG2}=0)
    ELSEIF(LOG_LEVEL_LOWER STREQUAL "debug")
        ADD_DEFINITIONS(-D${ARG2}=1)
    ELSEIF(LOG_LEVEL_LOWER STREQUAL "info")
        ADD_DEFINITIONS(-D${ARG2}=2)
    ELSEIF(LOG_LEVEL_LOWER STREQUAL "warning")
        ADD_DEFINITIONS(-D${ARG2}=3)
    ELSEIF(LOG_LEVEL_LOWER STREQUAL "error")
        ADD_DEFINITIONS(-D${ARG2}=4)
    ELSEIF(LOG_LEVEL_LOWER STREQUAL "fatal")
        ADD_DEFINITIONS(-D${ARG2}=5)
    ELSE()
        ADD_DEFINITIONS(-D${ARG2}=${ARG1})
    ENDIF()
ENDFUNCTION()

UHD_LOG_LEVEL_CONVERT(${UHD_LOG_MIN_LEVEL} "UHD_LOG_MIN_LEVEL")
UHD_LOG_LEVEL_CONVERT(${UHD_LOG_CONSOLE_LEVEL} "UHD_LOG_CONSOLE_LEVEL")
UHD_LOG_LEVEL_CONVERT(${UHD_LOG_FILE_LEVEL} "UHD_LOG_FILE_LEVEL")

IF(UHD_LOG_CONSOLE_DISABLE)
    ADD_DEFINITIONS(-DUHD_LOG_CONSOLE_DISABLE)
ELSE()
    IF(UHD_LOG_CONSOLE_TIME)
        ADD_DEFINITIONS(-DUHD_LOG_CONSOLE_TIME)
    ENDIF()
    IF(UHD_LOG_CONSOLE_THREAD)
        ADD_DEFINITIONS(-DUHD_LOG_CONSOLE_THREAD)
    ENDIF()
    IF(UHD_LOG_CONSOLE_SRC)
        ADD_DEFINITIONS(-DUHD_LOG_CONSOLE_SRC)
    ENDIF()
ENDIF()

SET(UHD_LOG_FILE "" CACHE FILE "Set UHD log file to a file in a existing directory")
IF(NOT UHD_LOG_FILE STREQUAL "")
    ADD_DEFINITIONS(-DUHD_LOG_FILE=${UHD_LOG_FILE})
ENDIF()

