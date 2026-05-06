Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74290CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 07:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB18E10E186;
	Wed,  6 May 2026 07:46:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.b="psdv8u8z";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 818BD10E186
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 07:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1778053610; x=1778658410; i=w_armin@gmx.de;
 bh=nozYKYXOWaYrdGXZ6qq6b+Nj4+DcUSMnEFSPjIjblqA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=psdv8u8zLV1cG//+xKVLV1VkJHwc+r29zrmGeJpDyIiqazhvfi2c+2sXs2eDiheX
 YePKXFfXBXWkbUGpMGTHHQcQDNXx0+uub0dIXPUevEBOUfWuAsGutvzDJtWBpzdD9
 nuUd81KbQyyYZBwPvylEFAUsret7q90/etxkUPf72KQlO/UVnIsqppME7HM0ptFW/
 iK5hRlN843FgiybzXne7nD+Wg26ntCWRMDdPliplBniZ3IAnpSq402LJ1FAMXgNs4
 XyFUc/2hrfjCeHceyNybunXcRu8tTLs8d42hSnDEycQl3gnRtPldOx1vSLQzyNl7O
 IAu1FxEW3+LacCNshA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGr8-1vnyeC25xm-00L8Rq; Wed, 06
 May 2026 09:46:50 +0200
Message-ID: <8542a7cd-2be7-4c51-b843-658d312ad1c8@gmx.de>
Date: Wed, 6 May 2026 09:46:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Plan to fix nvidia_wmi_ec backlight issues, help wanted
To: Daniel Dadap <ddadap@nvidia.com>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 linux-fbdev@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
References: <f10c039b-e9ef-4aae-8291-8f1e71074586@oss.qualcomm.com>
 <afoR5jUHLPXpYJ8a@ddadap-lakeline.nvidia.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <afoR5jUHLPXpYJ8a@ddadap-lakeline.nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WbZ1P23ppBRf9xFe+duDwYpfBqmwaq1aRDIkXYEd9ibNBEGgiHG
 PRRjiQYyt70971iUoN5M1dvnP9+vGTP1trxqRPMokJH0ZiVd6gUB2XxQRLSY0c+rNqS64fY
 QAWID+f8IzA+81wvlKkgs4WJ4XC21vgK/fBQkp4NTadmtMg6IDn6P5DBx7rBGmQMqXYYsPi
 fDdBbB9i/0Nb70vyTsxoQ==
UI-OutboundReport: notjunk:1;M01:P0:5yi0TzAPTQw=;QdsK3UZ82g6w3wAQRi2ATNtMrcG
 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
 4tu61SyVipPv4QG0Ko6v8JYxxUc=
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Am 05.05.26 um 17:51 schrieb Daniel Dadap:
> Thanks, Hans -
>=20
> On Tue, May 05, 2026 at 11:52:55AM +0200, Hans de Goede wrote:
>> <resend adding pdx86 list, sorry>
>>
>> Hi All,
>>
>> A while ago Nvidia introduced a new Nvidia specific firmware method
>> for controlling the backlight on laptops with runtime switchable
>> Nvidia hybrid graphics.
>>
>> This is supported through the nvidia-wmi-ec-backlight driver, but has
>> never worked 100%.
>>
>> The new WMI firmware interface has a method to ask the firmware if
>> the backlight is controlled though the EC and this the new WMI interfac=
e
>> should be used; or if it is directly controlled by the GPU and the GPU
>> driver's native backlight support should be used.
>>
>> There are several bugs in the implementation of this on various laptops=
:
>>
>> 1. The method to get the backlight control source sometimes does not
>> report the correct value.
>>
>> 2. On some laptop models which method (native-gpu vs nvidia-wmi) works
>> changes at runtime, e.g. when plugging in a charger.
>>
>> Known affected laptop models/bug reports about this:
>> - Acer Predator PH315-55: needs acpi_backlight=3Dnative
>> - Dell G15 5515 with RTX 3050: *needs* acpi_backlight=3Dnative
>> - Dell G15 5515 with RTX 3060: *breaks* with acpi_backlight=3Dnative
>> - Lenovo Legion Slim 7 2021
>> - https://bugzilla.kernel.org/show_bug.cgi?id=3D217026
>> - https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/work_items/784
>> - https://gitlab.freedesktop.org/drm/amd/-/issues/4512
>> - https://bugzilla.suse.com/show_bug.cgi?id=3D1217750
>=20
> I believe there were also a couple of cases where different builds of th=
e
> same notebook (as far as DMI quirks tables could detect) would be driven
> by different methods, exacerbating problem (1) because adding a quirtk t=
o
> fix one notebook would break other versions of the "same" notebook. (Oh,
> maybe that's the two G15 5515 bugs linked above.)
>=20
>>
>> It turns out that under Windows both a WMI backlight driver and a GPU
>> native backlight driver get installed and Windows simply always calls
>> both when the backlight changes working around these kind of firmware
>> bugs.
>>
>=20
> Yes, it's frustrating that so many notebooks have implementations of thi=
s
> interface that have bugs that get masked by Windows always using both of
> the interfaces. I wonder whether Windows behaves this way because bugs o=
f
> this type are so prevalent, or if the bugs are prevalent because Windows
> always behaved that way so nobody noticed.

I suspect that both scenarios apply :(

That being said, i am asking myself if "both interfaces" also includes=20
the backlight interface from the iGPU. If not then we could simply use a=
=20
notifier to dynamically tie the WMI device to the Nvidia GPU backlight=20
interface.

>> When this first came up, about 2 years ago, I came up with the below
>> plan to fix this. Nvidia was supposed to work in implementing this,
>> but so far an implementation of this plan has not happened.
>>
>> Note I do not have time to work on this myself. I'm posting this here
>> in the hope that either Nvidia will pick this up after all; or that
>> someone else can make this happen.
>>
>> I'm more then happy to help answering any questions which may come up
>> while implementing this; and to review the resulting patches.
>>
>=20
> Sorry about that - I totally forgot about this proposal. I'm still happy
> to help here, although if someone else is especially eager to implement
> these changes, I'm also happy to answer questions, test, review, and hel=
p
> in other ways as bandwidth allows. I have some clarifying questions abou=
t
> the plan - it's been some time since we talked about this, so I apologiz=
e
> if I've already asked these questions and you've already answered them.
>  =20
>>
>> The plan
>> =3D=3D=3D=3D=3D=3D=3D=3D
>>
>> 1. Modify the core backlight code to allow registering a backlight-devi=
ce
>> for in kernel use only, disabling the registering of a class device und=
er
>> /sys/class/backlight .
>>
>> 2. Add a new backlight-aggregate.c backlight driver, which exports a
>> devm_backlight_aggregate_register_or_add() function. Drivers can call
>> this passing in an existing backlight-device (with its sysfs interface
>> disabled). This either creates a singleton /sys/class/backlight/aggrega=
te
>> device, or adds the passed in backlight to the existing singleton insta=
nce
>> if it already exists.
>>
>> This new driver always exposes a range of 0-255 to userspace. This acts
>> as a proxie for any backlight-devices registered to be part of
>> the aggregate, forwarding any brightness set calls to all backlights,
>> scaled to their actual range. For reads this will report the last set
>> brightness value (starting with the value of the first registered
>> backlight-device).
>>
>> 3. Add a new nvidia_wmi_ec_and_native type to drivers/acpi/video_detect=
.c
>> for both DMI quirks and commandline handling.
>>
>=20
> So by default both the native and GPU drivers would register a "normal"
> backlight handler, and if the "both" quirk is set (or if requested via
> kernel command line) they'll register with the aggregate device?
>=20
> Would it make sense to make this more generic, with a parameter which
> can be set via command line or quirks for which backlight devices to
> aggregate? And then maybe instead of a new "nvidia_wmi_ec_and_native"
> backlight type in video_detect.c, it could be called "aggregate" or
> something else along those lines, used in combination with the list of
> backlight types to aggregate.
>=20
> Have we seen systems where both the iGPU and dGPU register their own
> native handlers? I vaguely recall seeing such a system, but I do not
> keep careful notes about this sort of thing, so I'm not certain. If
> there are indeed such systems, then "native" might not be specific
> enough, and it may be necessary to explicitly name backlight drivers
> individually in order to aggregate them.
>>
>> 4. Modify acpi_video_backlight_use_native() to also return true if
>> the __acpi_video_get_backlight_type() call there returns the new
>> acpi_backlight_nvidia_wmi_ec_and_native.
>=20
>> 5. Add a new devm_backlight_device_register_native() helper which
>> calls __acpi_video_get_backlight_type(true, NULL) and if that returns
>> the new nvidia_wmi_ec_and_native type then registers the passed in
>> backlight with the flag to not register a sysfs class interface and
>> then on success calls the new devm_backlight_aggregate_register_or_add(=
)
>> with the just registered backlight device; and if the returned type
>> instead is acpi_backlight_native register the passed in backlight
>> normally through devm_backlight_device_register()
>>
>> 5. Modify the i915 and amdgpu drivers to use the new
>> devm_backlight_device_register_native() helper. Since this new helper
>> checks the backlight-type itself, drop acpi_video_backlight_use_native(=
)
>> checks *if* the registration is the only thing guarded by that check.
>>
>> 6. drivers/platform/x86/nvidia-wmi-ec-backlight.c to not return
>> early from probe when acpi_video_get_backlight_type() returns
>> the new nvidia_wmi_ec_and_native type and for that type make it
>> registers its backlight with the flag to not register a sysfs class
>> interface and then on success calls the new
>> devm_backlight_aggregate_register_or_add().
>>
>=20
> There still isn't anything tying a particular sysfs backlight interface
> node to a specific display panel, right? Is there a plan to eventually
> support this? How would this interact with that plan? I'm just a little
> worried about designing ourselves into a corner that makes things harder
> to untangle individual devices later if the need arises.

Good point. I think it would be better if the GPU drivers themself=20
figure out if a given DRM connector belongs to the internal panel.
They could then register with a notifier that notifies the WMI driver=20
whenever the "official" backlight interface was changed to update the EC=
=20
state as needed.

If only the Nvidia GPU is supposed to interact with this WMI device,=20
then we could implement this as a private interface inside nova/noveau.=20
Otherwise we might need to come up with a more generic API.

Thanks,
Armin Wolf

>> Regards,
>>
>> Hans
>>
>=20

