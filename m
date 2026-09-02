Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1B2C624DB
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79FA310E035;
	Wed,  2 Sep 2026 17:00:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.b="gy/3ZXgi";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0AB310E035;
 Wed,  2 Sep 2026 17:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1788368439; x=1788973239; i=w_armin@gmx.de;
 bh=Xx0f0zmV6hSmuDi+e+o7qd5lE1g0dWUd3E6Tbqm4Py8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gy/3ZXgid0oXueL3xH7LJ77ZRbhZ1FxvaqmBorXbO2Sm4UdTv2J/CJQTbVOvTnD3
 WxZjVTzHXA7S3bBg+hjxN9cPNLcfFPhgYNk17LtbkRWFLS+dlXfcAt/bn+cdoYb8k
 fGW3soURj4F4LaWy9EWjZyYG+8Izi1ens1LyzgNI9LPGW4jly8C1Z/5QErqZEK6dy
 yXQ4F7RRdG0tVq46kPMM+shOldOk5wTDe1aRoVZH2i/y04kQa3uJHlxq3m4ASHCBJ
 ZM5ddwXDcKfvrjuQYetjxrUZ/44Ku/dl9JiIuCO8IWqoie7ArPq+Dpg8ySC/FaXk1
 bWIsfVpFivdtV9NyNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1wsZEP2Iuc-014N2C; Wed, 02
 Sep 2026 19:00:39 +0200
Message-ID: <86d0e015-a8f4-4e10-a9b6-a9714d3e0f07@gmx.de>
Date: Wed, 2 Sep 2026 19:00:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "hansg@kernel.org" <hansg@kernel.org>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Cc: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>,
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
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
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
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <BN9PR12MB514668975E87D570F50B2D91F7A82@BN9PR12MB5146.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qSz0YlDYyyk+dQhEUWQQm+sM1p1itkwhw5FDOabk/1kn4rpvPwu
 aRC6N8QfcaGIvwZX1EoSkWmCKSjeUFwXO4kLcAyiRz6PHDayG71iOJMPlG/RfkCi14yk7Rt
 LjdyN7uBoLtBhDf/OEjhbDiE2e+FoV77/fcXjpmiUBTmPw2zbCkPBsjvydpmQG5KNPOrfOi
 z+r7JShdHkcAOgfpSxG7w==
UI-OutboundReport: notjunk:1;M01:P0:68dPsfdPcPo=;wwqUdvbOtboeue9EczumWJefYe2
 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
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

Am 01.09.26 um 23:30 schrieb Deucher, Alexander:

> Public
>
>> -----Original Message-----
>> From: Armin Wolf <W_Armin@gmx.de>
>> Sent: Thursday, July 23, 2026 11:00 PM
>> To: hansg@kernel.org; ilpo.jarvinen@linux.intel.com
>> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
>> linux@weissschuh.net; rafael@kernel.org; lenb@kernel.org; linux-
>> acpi@vger.kernel.org; Deucher, Alexander <Alexander.Deucher@amd.com>;
>> Koenig, Christian <Christian.Koenig@amd.com>; airlied@gmail.com;
>> simona@ffwll.ch; amd-gfx@lists.freedesktop.org; dri-
>> devel@lists.freedesktop.org; patrik.r.jakobsson@gmail.com;
>> maarten.lankhorst@linux.intel.com; mripard@kernel.org;
>> tzimmermann@suse.de; jani.nikula@linux.intel.com;
>> joonas.lahtinen@linux.intel.com; rodrigo.vivi@intel.com;
>> tursulin@ursulin.net; intel-gfx@lists.freedesktop.org;
>> matthew.brost@intel.com; thomas.hellstrom@linux.intel.com; intel-
>> xe@lists.freedesktop.org
>> Subject: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
>> nvidia_wmi_ec_supported()
>>
>> The WMI-ACPI driver now supports architectures other than x86.
>> Remove the CONFIG_X86 handling from video-detect and the associated
>> drivers to simplify the resulting code.
>>
>> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/acpi/Kconfig               | 2 +-
>>   drivers/acpi/video_detect.c        | 8 --------
>>   drivers/gpu/drm/amd/amdgpu/Kconfig | 4 +---
>>   drivers/gpu/drm/gma500/Kconfig     | 1 -
>>   drivers/gpu/drm/i915/Kconfig       | 1 -
>>   drivers/gpu/drm/radeon/Kconfig     | 4 +---
>>   drivers/gpu/drm/xe/Kconfig         | 5 ++---
>>   drivers/platform/loongarch/Kconfig | 1 +
>>   8 files changed, 6 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig index
>> f165d14cf61a..cc1e58fa664b 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -224,7 +224,7 @@ config ACPI_VIDEO
>>        tristate "Video"
>>        depends on BACKLIGHT_CLASS_DEVICE
>>        depends on INPUT
>> -     depends on ACPI_WMI || !X86
>> +     depends on ACPI_WMI
>>        select THERMAL
>>        help
>>          This driver implements the ACPI Extensions For Display Adapters diff
>> --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c index
>> 458efa4fe9d4..af9280b244f1 100644
>> --- a/drivers/acpi/video_detect.c
>> +++ b/drivers/acpi/video_detect.c
>> @@ -82,8 +82,6 @@ find_video(acpi_handle handle, u32 lvl, void *context,
>> void **rv)
>>        return AE_OK;
>>   }
>>
>> -/* This depends on ACPI_WMI which is X86 only */ -#ifdef CONFIG_X86
>> static bool nvidia_wmi_ec_supported(void)  {
>>        struct wmi_brightness_args args = {
>> @@ -105,12 +103,6 @@ static bool nvidia_wmi_ec_supported(void)
>>         */
>>        return args.ret == WMI_BRIGHTNESS_SOURCE_EC;  } -#else -static bool
>> nvidia_wmi_ec_supported(void) -{
>> -     return false;
>> -}
>> -#endif
>>
>>   /* Force to use vendor driver when the ACPI device is known to be
>>    * buggy */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig
>> b/drivers/gpu/drm/amd/amdgpu/Kconfig
>> index 12e4a41bf1f0..50305630f533 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
>> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
>> @@ -30,9 +30,7 @@ config DRM_AMDGPU
>>        # ACPI_VIDEO's dependencies must also be selected.
>>        select INPUT if ACPI
>>        select ACPI_VIDEO if ACPI
>> -     # On x86 ACPI_VIDEO also needs ACPI_WMI
>> -     select X86_PLATFORM_DEVICES if ACPI && X86
> The change below makes sense, but this one looks like it should remain unless X86_PLATFORM_DEVICES is handled some other way?
>
> Alex

AFAIK the dependency on X86_PLATFORM_DEVICES was only necessary because ACPI-WMI depended on it in the past.
By now ACPI-WMI neither depends on X86_PLATFORM_DEVICES or X86 anymore.

Thanks,
Armin Wolf

>> -     select ACPI_WMI if ACPI && X86
>> +     select ACPI_WMI if ACPI
>>        help
>>          Choose this option if you have a recent AMD Radeon graphics card.
>>
>> diff --git a/drivers/gpu/drm/gma500/Kconfig
>> b/drivers/gpu/drm/gma500/Kconfig index a2acaa699dd5..dc4c56638819
>> 100644
>> --- a/drivers/gpu/drm/gma500/Kconfig
>> +++ b/drivers/gpu/drm/gma500/Kconfig
>> @@ -11,7 +11,6 @@ config DRM_GMA500
>>        select ACPI_VIDEO if ACPI
>>        select BACKLIGHT_CLASS_DEVICE if ACPI
>>        select INPUT if ACPI
>> -     select X86_PLATFORM_DEVICES if ACPI
>>        select ACPI_WMI if ACPI
>>        help
>>          Say yes for an experimental 2D KMS framebuffer driver for the diff --
>> git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig index
>> 5e939004b646..71426b9c91f0 100644
>> --- a/drivers/gpu/drm/i915/Kconfig
>> +++ b/drivers/gpu/drm/i915/Kconfig
>> @@ -28,7 +28,6 @@ config DRM_I915
>>        # but for select to work, need to select ACPI_VIDEO's dependencies,
>> ick
>>        select BACKLIGHT_CLASS_DEVICE if ACPI
>>        select INPUT if ACPI
>> -     select X86_PLATFORM_DEVICES if ACPI
>>        select ACPI_WMI if ACPI
>>        select ACPI_VIDEO if ACPI
>>        select SYNC_FILE
>> diff --git a/drivers/gpu/drm/radeon/Kconfig
>> b/drivers/gpu/drm/radeon/Kconfig index c479f0c0dd5c..3cd70aef770e
>> 100644
>> --- a/drivers/gpu/drm/radeon/Kconfig
>> +++ b/drivers/gpu/drm/radeon/Kconfig
>> @@ -25,9 +25,7 @@ config DRM_RADEON
>>        # ACPI_VIDEO's dependencies must also be selected.
>>        select INPUT if ACPI
>>        select ACPI_VIDEO if ACPI
>> -     # On x86 ACPI_VIDEO also needs ACPI_WMI
>> -     select X86_PLATFORM_DEVICES if ACPI && X86
>> -     select ACPI_WMI if ACPI && X86
>> +     select ACPI_WMI if ACPI
>>        help
>>          Choose this option if you have an ATI Radeon graphics card.  There
>>          are both PCI and AGP versions.  You don't need to choose this to diff -
>> -git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig index
>> 4d7dcaff2b91..502c7b3c1f16 100644
>> --- a/drivers/gpu/drm/xe/Kconfig
>> +++ b/drivers/gpu/drm/xe/Kconfig
>> @@ -4,7 +4,6 @@ config DRM_XE
>>        depends on DRM && PCI
>>        depends on KUNIT || !KUNIT
>>        depends on INTEL_VSEC || !INTEL_VSEC
>> -     depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
>>        depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN
>>        select INTERVAL_TREE
>>        # we need shmfs for the swappable backing store, and in particular
>> @@ -29,8 +28,8 @@ config DRM_XE
>>        # but for select to work, need to select ACPI_VIDEO's dependencies,
>> ick
>>        select BACKLIGHT_CLASS_DEVICE if ACPI
>>        select INPUT if ACPI
>> -     select ACPI_VIDEO if X86 && ACPI
>> -     select ACPI_WMI if X86 && ACPI
>> +     select ACPI_VIDEO if ACPI
>> +     select ACPI_WMI if ACPI
>>        select SYNC_FILE
>>        select CRC32
>>        select SND_HDA_I915 if SND_HDA_CORE
>> diff --git a/drivers/platform/loongarch/Kconfig
>> b/drivers/platform/loongarch/Kconfig
>> index 447528797d07..db7833842142 100644
>> --- a/drivers/platform/loongarch/Kconfig
>> +++ b/drivers/platform/loongarch/Kconfig
>> @@ -23,6 +23,7 @@ config LOONGSON_LAPTOP
>>        depends on INPUT
>>        depends on MACH_LOONGSON64
>>        select ACPI_VIDEO
>> +     select ACPI_WMI
>>        select INPUT_SPARSEKMAP
>>        default y
>>        help
>> --
>> 2.39.5
>
