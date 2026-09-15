Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0F2C88E7B
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3BEC10FBC3;
	Tue, 15 Sep 2026 12:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Wfk/ZGNc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C44210FB8E;
 Tue, 15 Sep 2026 12:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789474119; x=1821010119;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=r4/etdnCcfrVsy/eyrNdRvVeg93egQng/TtPPPFnO+Q=;
 b=Wfk/ZGNcJbis3m2ZuXTctJHCS/PbXZr02GAytjun7DmH910QC2bPjhzq
 ALg5bEhULWNbmvvlALzU8a6BDWYp4u8wHi1vAjmoYBYopMTuDdm0RNleg
 cEYVNd6EKqrqalCBsCah94a1ILUrAiwDbQV9oBIsGYp+jEOh7KG/7YzMw
 UWzRwn16/pa0Z0HYbaLI9J7ewinsA6qOz933UjH6ii6/qq6Aky+1vpfDX
 H0Fd4Gf02p9BDTUxe9JclUq7PRIkN6RwhdHumLDOnDGLvwDTdx2qEPFZF
 f3CXbrKrJUFOPGCjhTFIqs0xBYaZWKgCa/fte65fk6iTJ3xHSFHFQRCBg w==;
X-CSE-ConnectionGUID: gvzcw2v+Q8ewfWFOM58GEA==
X-CSE-MsgGUID: s16AMrXrRme0cYAYh5CLHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112603686"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112603686"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:08:38 -0700
X-CSE-ConnectionGUID: yEXKeHT/S1eM9WiIW6824Q==
X-CSE-MsgGUID: +eCt4baJQ1ehGF/VxF7LQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="276752589"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.24])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:08:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 15 Sep 2026 15:08:25 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "hansg@kernel.org" <hansg@kernel.org>, 
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux@weissschuh.net" <linux@weissschuh.net>, 
 "rafael@kernel.org" <rafael@kernel.org>, 
 "lenb@kernel.org" <lenb@kernel.org>, 
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "airlied@gmail.com" <airlied@gmail.com>, 
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
Subject: Re: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
In-Reply-To: <86d0e015-a8f4-4e10-a9b6-a9714d3e0f07@gmx.de>
Message-ID: <80c4bb47-936b-976b-6ba8-b366f7a455cf@linux.intel.com>
References: <20260724025959.142826-1-W_Armin@gmx.de>
 <20260724025959.142826-3-W_Armin@gmx.de>
 <BN9PR12MB514668975E87D570F50B2D91F7A82@BN9PR12MB5146.namprd12.prod.outlook.com>
 <86d0e015-a8f4-4e10-a9b6-a9714d3e0f07@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

GPU people heads up!!

On Wed, 2 Sep 2026, Armin Wolf wrote:

> Am 01.09.26 um 23:30 schrieb Deucher, Alexander:
> 
> > Public
> > 
> > > -----Original Message-----
> > > From: Armin Wolf <W_Armin@gmx.de>
> > > Sent: Thursday, July 23, 2026 11:00 PM
> > > To: hansg@kernel.org; ilpo.jarvinen@linux.intel.com
> > > Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > linux@weissschuh.net; rafael@kernel.org; lenb@kernel.org; linux-
> > > acpi@vger.kernel.org; Deucher, Alexander <Alexander.Deucher@amd.com>;
> > > Koenig, Christian <Christian.Koenig@amd.com>; airlied@gmail.com;
> > > simona@ffwll.ch; amd-gfx@lists.freedesktop.org; dri-
> > > devel@lists.freedesktop.org; patrik.r.jakobsson@gmail.com;
> > > maarten.lankhorst@linux.intel.com; mripard@kernel.org;
> > > tzimmermann@suse.de; jani.nikula@linux.intel.com;
> > > joonas.lahtinen@linux.intel.com; rodrigo.vivi@intel.com;
> > > tursulin@ursulin.net; intel-gfx@lists.freedesktop.org;
> > > matthew.brost@intel.com; thomas.hellstrom@linux.intel.com; intel-
> > > xe@lists.freedesktop.org
> > > Subject: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
> > > nvidia_wmi_ec_supported()
> > > 
> > > The WMI-ACPI driver now supports architectures other than x86.
> > > Remove the CONFIG_X86 handling from video-detect and the associated
> > > drivers to simplify the resulting code.
> > > 
> > > Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > > ---
> > >   drivers/acpi/Kconfig               | 2 +-
> > >   drivers/acpi/video_detect.c        | 8 --------
> > >   drivers/gpu/drm/amd/amdgpu/Kconfig | 4 +---
> > >   drivers/gpu/drm/gma500/Kconfig     | 1 -
> > >   drivers/gpu/drm/i915/Kconfig       | 1 -
> > >   drivers/gpu/drm/radeon/Kconfig     | 4 +---
> > >   drivers/gpu/drm/xe/Kconfig         | 5 ++---
> > >   drivers/platform/loongarch/Kconfig | 1 +
> > >   8 files changed, 6 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig index
> > > f165d14cf61a..cc1e58fa664b 100644
> > > --- a/drivers/acpi/Kconfig
> > > +++ b/drivers/acpi/Kconfig
> > > @@ -224,7 +224,7 @@ config ACPI_VIDEO
> > >        tristate "Video"
> > >        depends on BACKLIGHT_CLASS_DEVICE
> > >        depends on INPUT
> > > -     depends on ACPI_WMI || !X86
> > > +     depends on ACPI_WMI
> > >        select THERMAL
> > >        help
> > >          This driver implements the ACPI Extensions For Display Adapters
> > > diff
> > > --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c index
> > > 458efa4fe9d4..af9280b244f1 100644
> > > --- a/drivers/acpi/video_detect.c
> > > +++ b/drivers/acpi/video_detect.c
> > > @@ -82,8 +82,6 @@ find_video(acpi_handle handle, u32 lvl, void *context,
> > > void **rv)
> > >        return AE_OK;
> > >   }
> > > 
> > > -/* This depends on ACPI_WMI which is X86 only */ -#ifdef CONFIG_X86
> > > static bool nvidia_wmi_ec_supported(void)  {
> > >        struct wmi_brightness_args args = {
> > > @@ -105,12 +103,6 @@ static bool nvidia_wmi_ec_supported(void)
> > >         */
> > >        return args.ret == WMI_BRIGHTNESS_SOURCE_EC;  } -#else -static bool
> > > nvidia_wmi_ec_supported(void) -{
> > > -     return false;
> > > -}
> > > -#endif
> > > 
> > >   /* Force to use vendor driver when the ACPI device is known to be
> > >    * buggy */
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig
> > > b/drivers/gpu/drm/amd/amdgpu/Kconfig
> > > index 12e4a41bf1f0..50305630f533 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> > > +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> > > @@ -30,9 +30,7 @@ config DRM_AMDGPU
> > >        # ACPI_VIDEO's dependencies must also be selected.
> > >        select INPUT if ACPI
> > >        select ACPI_VIDEO if ACPI
> > > -     # On x86 ACPI_VIDEO also needs ACPI_WMI
> > > -     select X86_PLATFORM_DEVICES if ACPI && X86
> > The change below makes sense, but this one looks like it should remain
> > unless X86_PLATFORM_DEVICES is handled some other way?
> > 
> > Alex
> 
> AFAIK the dependency on X86_PLATFORM_DEVICES was only necessary because
> ACPI-WMI depended on it in the past.
> By now ACPI-WMI neither depends on X86_PLATFORM_DEVICES or X86 anymore.

Hi all,

Could more GPU people besides Alex take a look on this. I'd want to make 
progress with this series within this cycle but would prefer to have Acks 
from GPU side.

> > > -     select ACPI_WMI if ACPI && X86
> > > +     select ACPI_WMI if ACPI
> > >        help
> > >          Choose this option if you have a recent AMD Radeon graphics card.
> > > 
> > > diff --git a/drivers/gpu/drm/gma500/Kconfig
> > > b/drivers/gpu/drm/gma500/Kconfig index a2acaa699dd5..dc4c56638819
> > > 100644
> > > --- a/drivers/gpu/drm/gma500/Kconfig
> > > +++ b/drivers/gpu/drm/gma500/Kconfig
> > > @@ -11,7 +11,6 @@ config DRM_GMA500
> > >        select ACPI_VIDEO if ACPI
> > >        select BACKLIGHT_CLASS_DEVICE if ACPI
> > >        select INPUT if ACPI
> > > -     select X86_PLATFORM_DEVICES if ACPI
> > >        select ACPI_WMI if ACPI
> > >        help
> > >          Say yes for an experimental 2D KMS framebuffer driver for the
> > > diff --
> > > git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig index
> > > 5e939004b646..71426b9c91f0 100644
> > > --- a/drivers/gpu/drm/i915/Kconfig
> > > +++ b/drivers/gpu/drm/i915/Kconfig
> > > @@ -28,7 +28,6 @@ config DRM_I915
> > >        # but for select to work, need to select ACPI_VIDEO's dependencies,
> > > ick
> > >        select BACKLIGHT_CLASS_DEVICE if ACPI
> > >        select INPUT if ACPI
> > > -     select X86_PLATFORM_DEVICES if ACPI
> > >        select ACPI_WMI if ACPI
> > >        select ACPI_VIDEO if ACPI
> > >        select SYNC_FILE
> > > diff --git a/drivers/gpu/drm/radeon/Kconfig
> > > b/drivers/gpu/drm/radeon/Kconfig index c479f0c0dd5c..3cd70aef770e
> > > 100644
> > > --- a/drivers/gpu/drm/radeon/Kconfig
> > > +++ b/drivers/gpu/drm/radeon/Kconfig
> > > @@ -25,9 +25,7 @@ config DRM_RADEON
> > >        # ACPI_VIDEO's dependencies must also be selected.
> > >        select INPUT if ACPI
> > >        select ACPI_VIDEO if ACPI
> > > -     # On x86 ACPI_VIDEO also needs ACPI_WMI
> > > -     select X86_PLATFORM_DEVICES if ACPI && X86
> > > -     select ACPI_WMI if ACPI && X86
> > > +     select ACPI_WMI if ACPI
> > >        help
> > >          Choose this option if you have an ATI Radeon graphics card.
> > > There
> > >          are both PCI and AGP versions.  You don't need to choose this to
> > > diff -
> > > -git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig index
> > > 4d7dcaff2b91..502c7b3c1f16 100644
> > > --- a/drivers/gpu/drm/xe/Kconfig
> > > +++ b/drivers/gpu/drm/xe/Kconfig
> > > @@ -4,7 +4,6 @@ config DRM_XE
> > >        depends on DRM && PCI
> > >        depends on KUNIT || !KUNIT
> > >        depends on INTEL_VSEC || !INTEL_VSEC
> > > -     depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
> > >        depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN
> > >        select INTERVAL_TREE
> > >        # we need shmfs for the swappable backing store, and in particular
> > > @@ -29,8 +28,8 @@ config DRM_XE
> > >        # but for select to work, need to select ACPI_VIDEO's dependencies,
> > > ick
> > >        select BACKLIGHT_CLASS_DEVICE if ACPI
> > >        select INPUT if ACPI
> > > -     select ACPI_VIDEO if X86 && ACPI
> > > -     select ACPI_WMI if X86 && ACPI
> > > +     select ACPI_VIDEO if ACPI
> > > +     select ACPI_WMI if ACPI
> > >        select SYNC_FILE
> > >        select CRC32
> > >        select SND_HDA_I915 if SND_HDA_CORE
> > > diff --git a/drivers/platform/loongarch/Kconfig
> > > b/drivers/platform/loongarch/Kconfig
> > > index 447528797d07..db7833842142 100644
> > > --- a/drivers/platform/loongarch/Kconfig
> > > +++ b/drivers/platform/loongarch/Kconfig
> > > @@ -23,6 +23,7 @@ config LOONGSON_LAPTOP
> > >        depends on INPUT
> > >        depends on MACH_LOONGSON64
> > >        select ACPI_VIDEO
> > > +     select ACPI_WMI
> > >        select INPUT_SPARSEKMAP
> > >        default y
> > >        help
> > > --
> > > 2.39.5
> > 
> 

-- 
 i.

