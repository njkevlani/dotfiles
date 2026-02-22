import hid
import sys

# VIA/QMK Raw HID constants
VIA_USAGE_PAGE = 0xFF60
VIA_USAGE = 0x61
RAW_REPORT_SIZE = 32

# VIA command IDs (QMK protocol v12)
ID_CUSTOM_SET_VALUE = 0x07
ID_CUSTOM_GET_VALUE = 0x08
ID_UNHANDLED = 0xFF

# VIA channel IDs
CHANNELS_BY_PRIORITY = [
    3,  # RGB Matrix
    2,  # RGB Light
    1,  # Backlight
    5,  # LED Matrix
]

ID_BRIGHTNESS = 0x01


def find_via_device():
    """Finds the first device matching QMK/VIA Raw HID usage."""
    for device_dict in hid.enumerate():
        if device_dict['usage_page'] == VIA_USAGE_PAGE and device_dict['usage'] == VIA_USAGE:
            return device_dict
    return None

def send_via_command(device_info, command_data):
    """Sends a 32-byte VIA command and returns the 32-byte response."""
    dev = hid.Device(path=device_info['path'])

    # hid.Device.write expects a bytes-like object
    request = bytes([0x00] + command_data + [0] * (RAW_REPORT_SIZE - len(command_data)))
    dev.write(request)

    response = dev.read(RAW_REPORT_SIZE)
    dev.close()
    return response


def detect_brightness_channel(device_info):
    """Returns the first supported VIA brightness channel."""
    for channel in CHANNELS_BY_PRIORITY:
        res = send_via_command(device_info, [ID_CUSTOM_GET_VALUE, channel, ID_BRIGHTNESS])
        if res and res[0] != ID_UNHANDLED:
            return channel
    return None

def get_brightness(device_info, channel):
    """Gets brightness as a percent (0-100)."""
    command = [ID_CUSTOM_GET_VALUE, channel, ID_BRIGHTNESS]
    res = send_via_command(device_info, command)
    if not res or res[0] == ID_UNHANDLED:
        return None

    # VIA returns brightness in data[3] as a 0-255 value.
    raw = res[3]
    return round(raw * 100 / 255)

def set_brightness(device_info, channel, percent):
    """Sets brightness from percent (0-100)."""
    percent = max(0, min(100, percent))
    raw = round(percent * 255 / 100)
    command = [ID_CUSTOM_SET_VALUE, channel, ID_BRIGHTNESS, raw]
    send_via_command(device_info, command)

def parse_int(value):
    try:
        return int(value)
    except (TypeError, ValueError):
        return None


def main():
    args = sys.argv[1:]

    device = find_via_device()
    channel = detect_brightness_channel(device)
    if device is None:
        return 0

    command = args[0]
    if command == "print":
        current = get_brightness(device, channel)
        print(current)
        return 0
    elif command == "up":
        amount = parse_int(args[1])
        assert amount is not None
        current = get_brightness(device, channel)
        set_brightness(device, channel, current + amount)
        return 0

    elif command == "down":
        amount = parse_int(args[1])
        assert amount is not None
        current = get_brightness(device, channel)
        set_brightness(device, channel, current - amount)
        return 0

    return 1


if __name__ == "__main__":
    raise SystemExit(main())
