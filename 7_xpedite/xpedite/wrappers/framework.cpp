#include <xpedite/framework/Framework.H>

extern "C" {
    bool framework_initialize_await(const char* appInfoFile) {
        return xpedite::framework::initialize(appInfoFile, {xpedite::framework::AWAIT_PROFILE_BEGIN});
    }

    bool framework_initialize_with_ip_await(const char* appInfoFile, const char* listenerIp, int port) {
        return xpedite::framework::initialize(appInfoFile, listenerIp, port, {xpedite::framework::AWAIT_PROFILE_BEGIN});
    }
}
