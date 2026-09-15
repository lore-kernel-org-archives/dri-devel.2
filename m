Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5195FC88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 22:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8779B10E326;
	Tue, 15 Sep 2026 22:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.b="UT+BepEm";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1760810E326;
 Tue, 15 Sep 2026 22:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789509830; x=1790114630; i=w_armin@gmx.de;
 bh=PK36bUBx7R+CoucIZMwOSWJo6eqVDS+7S6ZL3JBqOhw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UT+BepEm9vkAviFp2v3l2jAynbSlpzvirTQIUQ2V9166AK0+ZY8QCOwQEZJGUDVM
 7OuSQ1LX/ersIcUDyq96UQJoL8gB/uSDF+VTMMRceBKGc6PcoCJXxXTNFWCeGfyiL
 KBfEPBbK1IXfcx6tISgkW/O9QZb12RWJM6YLxZvKBVJVwpsjNti6+yivcBGnZsa4L
 viX/FuXE+pi93zB1Md/n2/cIg+k/ieAUqwSGP4R66Ew4wnph8p/GwPbwI/7/2njBa
 VA46qutF6HfLEKLH/xbkzGz2dF8PcVsiJ9CdkKSJ9fILQDfQ52b2FlUfuFG7FLJjM
 SEm99tfRe7Y3vBE3fA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof9P-1wQS1X1Ixl-00psPr; Wed, 16
 Sep 2026 00:03:50 +0200
Message-ID: <3ef68773-e07e-437a-98fb-a3c5fc08539c@gmx.de>
Date: Wed, 16 Sep 2026 00:03:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
To: Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "hansg@kernel.org" <hansg@kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux@weissschuh.net" <linux@weissschuh.net>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "patrik.r.jakobsson@gmail.com" <patrik.r.jakobsson@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
 "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "matthew.brost@intel.com" <matthew.brost@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
References: <20260724025959.142826-1-W_Armin@gmx.de>
 <20260724025959.142826-3-W_Armin@gmx.de>
 <BN9PR12MB514668975E87D570F50B2D91F7A82@BN9PR12MB5146.namprd12.prod.outlook.com>
 <86d0e015-a8f4-4e10-a9b6-a9714d3e0f07@gmx.de>
 <80c4bb47-936b-976b-6ba8-b366f7a455cf@linux.intel.com>
 <11976ed3784675ad241646287a909286a42675a8@intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <11976ed3784675ad241646287a909286a42675a8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GQNEzCvPZ09jtCE2Od/NEqRJIcn4aJ6vnRPjh+HWUMc7ZmYAElf
 l8ZMQ0U1s2cbaPb5FtKCEF43Hsx9aDsh//j+L8KlsRKWsZGEeWPN7aHFa4prMFn4mJ5iOt+
 1C8JuBphPXGYWnOmRWx596id0cXPGQcQwUAHneqRdzAOtiWL76EMYyid+B5Jnti9haw17ns
 5ODSNlkAmneFAKQj0nCyw==
UI-OutboundReport: notjunk:1;M01:P0:cHwD8Y/jEf8=;snpvPDlOb0l46sdRg5iXhSr6zIn
 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
 qwps
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

Am 15.09.26 um 14:31 schrieb Jani Nikula:

> On Tue, 15 Sep 2026, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =
wrote:
>> GPU people heads up!!
>>
>> On Wed, 2 Sep 2026, Armin Wolf wrote:
>>
>>> Am 01.09.26 um 23:30 schrieb Deucher, Alexander:
>>>
>>>> Public
>>>>
>>>>> -----Original Message-----
>>>>> From: Armin Wolf <W_Armin@gmx.de>
>>>>> Sent: Thursday, July 23, 2026 11:00 PM
>>>>> To: hansg@kernel.org; ilpo.jarvinen@linux.intel.com
>>>>> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.or=
g;
>>>>> linux@weissschuh.net; rafael@kernel.org; lenb@kernel.org; linux-
>>>>> acpi@vger.kernel.org; Deucher, Alexander <Alexander.Deucher@amd.com>=
;
>>>>> Koenig, Christian <Christian.Koenig@amd.com>; airlied@gmail.com;
>>>>> simona@ffwll.ch; amd-gfx@lists.freedesktop.org; dri-
>>>>> devel@lists.freedesktop.org; patrik.r.jakobsson@gmail.com;
>>>>> maarten.lankhorst@linux.intel.com; mripard@kernel.org;
>>>>> tzimmermann@suse.de; jani.nikula@linux.intel.com;
>>>>> joonas.lahtinen@linux.intel.com; rodrigo.vivi@intel.com;
>>>>> tursulin@ursulin.net; intel-gfx@lists.freedesktop.org;
>>>>> matthew.brost@intel.com; thomas.hellstrom@linux.intel.com; intel-
>>>>> xe@lists.freedesktop.org
>>>>> Subject: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
>>>>> nvidia_wmi_ec_supported()
>>>>>
>>>>> The WMI-ACPI driver now supports architectures other than x86.
>>>>> Remove the CONFIG_X86 handling from video-detect and the associated
>>>>> drivers to simplify the resulting code.
>>>>>
>>>>> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>>> ---
>>>>>    drivers/acpi/Kconfig               | 2 +-
>>>>>    drivers/acpi/video_detect.c        | 8 --------
>>>>>    drivers/gpu/drm/amd/amdgpu/Kconfig | 4 +---
>>>>>    drivers/gpu/drm/gma500/Kconfig     | 1 -
>>>>>    drivers/gpu/drm/i915/Kconfig       | 1 -
>>>>>    drivers/gpu/drm/radeon/Kconfig     | 4 +---
>>>>>    drivers/gpu/drm/xe/Kconfig         | 5 ++---
>>>>>    drivers/platform/loongarch/Kconfig | 1 +
>>>>>    8 files changed, 6 insertions(+), 20 deletions(-)
>>>>>
>>>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig index
>>>>> f165d14cf61a..cc1e58fa664b 100644
>>>>> --- a/drivers/acpi/Kconfig
>>>>> +++ b/drivers/acpi/Kconfig
>>>>> @@ -224,7 +224,7 @@ config ACPI_VIDEO
>>>>>         tristate "Video"
>>>>>         depends on BACKLIGHT_CLASS_DEVICE
>>>>>         depends on INPUT
>>>>> -     depends on ACPI_WMI || !X86
>>>>> +     depends on ACPI_WMI
>>>>>         select THERMAL
>>>>>         help
>>>>>           This driver implements the ACPI Extensions For Display Ada=
pters
>>>>> diff
>>>>> --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c in=
dex
>>>>> 458efa4fe9d4..af9280b244f1 100644
>>>>> --- a/drivers/acpi/video_detect.c
>>>>> +++ b/drivers/acpi/video_detect.c
>>>>> @@ -82,8 +82,6 @@ find_video(acpi_handle handle, u32 lvl, void *cont=
ext,
>>>>> void **rv)
>>>>>         return AE_OK;
>>>>>    }
>>>>>
>>>>> -/* This depends on ACPI_WMI which is X86 only */ -#ifdef CONFIG_X86
>>>>> static bool nvidia_wmi_ec_supported(void)  {
>>>>>         struct wmi_brightness_args args =3D {
>>>>> @@ -105,12 +103,6 @@ static bool nvidia_wmi_ec_supported(void)
>>>>>          */
>>>>>         return args.ret =3D=3D WMI_BRIGHTNESS_SOURCE_EC;  } -#else -=
static bool
>>>>> nvidia_wmi_ec_supported(void) -{
>>>>> -     return false;
>>>>> -}
>>>>> -#endif
>>>>>
>>>>>    /* Force to use vendor driver when the ACPI device is known to be
>>>>>     * buggy */
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>> b/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>> index 12e4a41bf1f0..50305630f533 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
>>>>> @@ -30,9 +30,7 @@ config DRM_AMDGPU
>>>>>         # ACPI_VIDEO's dependencies must also be selected.
>>>>>         select INPUT if ACPI
>>>>>         select ACPI_VIDEO if ACPI
>>>>> -     # On x86 ACPI_VIDEO also needs ACPI_WMI
>>>>> -     select X86_PLATFORM_DEVICES if ACPI && X86
>>>> The change below makes sense, but this one looks like it should remai=
n
>>>> unless X86_PLATFORM_DEVICES is handled some other way?
>>>>
>>>> Alex
>>> AFAIK the dependency on X86_PLATFORM_DEVICES was only necessary becaus=
e
>>> ACPI-WMI depended on it in the past.
>>> By now ACPI-WMI neither depends on X86_PLATFORM_DEVICES or X86 anymore=
.
>> Hi all,
>>
>> Could more GPU people besides Alex take a look on this. I'd want to mak=
e
>> progress with this series within this cycle but would prefer to have Ac=
ks
>> from GPU side.
> I share the same concern with Alex. It seems to me we could now end up
> with x86 configurations without X86_PLATFORM_DEVICES, which handle
> e.g. backlight on a lot of platforms.
>
> I think the safer option might be to go for:
>
> 	depends on X86_PLATFORM_DEVICES || !X86
>
> in all of the cases that select/depend on X86_PLATFORM_DEVICES in drm.
>
> The alternative is to find out, and handle the fallout, if any.
>
>
> BR,
> Jani.

Alright, should i leave the original "select X86_PLATFORM_DEVICES if ..." =
statements
as-is or should is change them to "depends on X86_PLATFORM_DEVICES || !X86=
" everywhere?

Thanks,
Armin Wolf

>>>>> -     select ACPI_WMI if ACPI && X86
>>>>> +     select ACPI_WMI if ACPI
>>>>>         help
>>>>>           Choose this option if you have a recent AMD Radeon graphic=
s card.
>>>>>
>>>>> diff --git a/drivers/gpu/drm/gma500/Kconfig
>>>>> b/drivers/gpu/drm/gma500/Kconfig index a2acaa699dd5..dc4c56638819
>>>>> 100644
>>>>> --- a/drivers/gpu/drm/gma500/Kconfig
>>>>> +++ b/drivers/gpu/drm/gma500/Kconfig
>>>>> @@ -11,7 +11,6 @@ config DRM_GMA500
>>>>>         select ACPI_VIDEO if ACPI
>>>>>         select BACKLIGHT_CLASS_DEVICE if ACPI
>>>>>         select INPUT if ACPI
>>>>> -     select X86_PLATFORM_DEVICES if ACPI
>>>>>         select ACPI_WMI if ACPI
>>>>>         help
>>>>>           Say yes for an experimental 2D KMS framebuffer driver for =
the
>>>>> diff --
>>>>> git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig in=
dex
>>>>> 5e939004b646..71426b9c91f0 100644
>>>>> --- a/drivers/gpu/drm/i915/Kconfig
>>>>> +++ b/drivers/gpu/drm/i915/Kconfig
>>>>> @@ -28,7 +28,6 @@ config DRM_I915
>>>>>         # but for select to work, need to select ACPI_VIDEO's depend=
encies,
>>>>> ick
>>>>>         select BACKLIGHT_CLASS_DEVICE if ACPI
>>>>>         select INPUT if ACPI
>>>>> -     select X86_PLATFORM_DEVICES if ACPI
>>>>>         select ACPI_WMI if ACPI
>>>>>         select ACPI_VIDEO if ACPI
>>>>>         select SYNC_FILE
>>>>> diff --git a/drivers/gpu/drm/radeon/Kconfig
>>>>> b/drivers/gpu/drm/radeon/Kconfig index c479f0c0dd5c..3cd70aef770e
>>>>> 100644
>>>>> --- a/drivers/gpu/drm/radeon/Kconfig
>>>>> +++ b/drivers/gpu/drm/radeon/Kconfig
>>>>> @@ -25,9 +25,7 @@ config DRM_RADEON
>>>>>         # ACPI_VIDEO's dependencies must also be selected.
>>>>>         select INPUT if ACPI
>>>>>         select ACPI_VIDEO if ACPI
>>>>> -     # On x86 ACPI_VIDEO also needs ACPI_WMI
>>>>> -     select X86_PLATFORM_DEVICES if ACPI && X86
>>>>> -     select ACPI_WMI if ACPI && X86
>>>>> +     select ACPI_WMI if ACPI
>>>>>         help
>>>>>           Choose this option if you have an ATI Radeon graphics card=
.
>>>>> There
>>>>>           are both PCI and AGP versions.  You don't need to choose t=
his to
>>>>> diff -
>>>>> -git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig index
>>>>> 4d7dcaff2b91..502c7b3c1f16 100644
>>>>> --- a/drivers/gpu/drm/xe/Kconfig
>>>>> +++ b/drivers/gpu/drm/xe/Kconfig
>>>>> @@ -4,7 +4,6 @@ config DRM_XE
>>>>>         depends on DRM && PCI
>>>>>         depends on KUNIT || !KUNIT
>>>>>         depends on INTEL_VSEC || !INTEL_VSEC
>>>>> -     depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
>>>>>         depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN
>>>>>         select INTERVAL_TREE
>>>>>         # we need shmfs for the swappable backing store, and in part=
icular
>>>>> @@ -29,8 +28,8 @@ config DRM_XE
>>>>>         # but for select to work, need to select ACPI_VIDEO's depend=
encies,
>>>>> ick
>>>>>         select BACKLIGHT_CLASS_DEVICE if ACPI
>>>>>         select INPUT if ACPI
>>>>> -     select ACPI_VIDEO if X86 && ACPI
>>>>> -     select ACPI_WMI if X86 && ACPI
>>>>> +     select ACPI_VIDEO if ACPI
>>>>> +     select ACPI_WMI if ACPI
>>>>>         select SYNC_FILE
>>>>>         select CRC32
>>>>>         select SND_HDA_I915 if SND_HDA_CORE
>>>>> diff --git a/drivers/platform/loongarch/Kconfig
>>>>> b/drivers/platform/loongarch/Kconfig
>>>>> index 447528797d07..db7833842142 100644
>>>>> --- a/drivers/platform/loongarch/Kconfig
>>>>> +++ b/drivers/platform/loongarch/Kconfig
>>>>> @@ -23,6 +23,7 @@ config LOONGSON_LAPTOP
>>>>>         depends on INPUT
>>>>>         depends on MACH_LOONGSON64
>>>>>         select ACPI_VIDEO
>>>>> +     select ACPI_WMI
>>>>>         select INPUT_SPARSEKMAP
>>>>>         default y
>>>>>         help
>>>>> --
>>>>> 2.39.5
