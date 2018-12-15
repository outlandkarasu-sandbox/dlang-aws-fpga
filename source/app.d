import std.stdio : writefln;
import cl = dcltk;

void main() {
    auto platformId = cl.loadOpenCl();
    writefln("loaded: %s %s %s(%s) %s [%s]",
        cl.getPlatformProfile(platformId),
        cl.getPlatformName(platformId),
        cl.getPlatformVersion(platformId),
        cl.getPlatformCLVersion(platformId),
        cl.getPlatformVendor(platformId),
        cl.getPlatformExtensions(platformId));

    auto context = cl.createDefaultContext(platformId);
    scope(exit) cl.releaseContext(context);
    auto deviceIds = cl.getContextDeviceIds(context);
    if(deviceIds.length <= 0) {
        throw new cl.OpenClException("device not found.");
    }

    auto device = deviceIds[0];
    writefln("device: %s %s gmem: %d, lmem: %d, cu: %d, w: %d, dim: %d %s",
        cl.getDeviceName(device),
        cl.getDeviceVersion(device),
        cl.getDeviceGlobalMemorySize(device),
        cl.getDeviceLocalMemorySize(device),
        cl.getDeviceMaxComputeUnits(device),
        cl.getDeviceMaxWorkGroupSize(device),
        cl.getDeviceMaxWorkItemDimensions(device),
        cl.getDeviceMaxWorkItemSizes(device));
    if(!cl.isGpuDevice(device)) {
        writefln("WARNING: device is not GPU!");
    }
}
