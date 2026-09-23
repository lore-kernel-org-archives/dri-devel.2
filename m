Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06097C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D7D710F00C;
	Wed, 23 Sep 2026 13:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eXW6NNPv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB23E10F002;
 Wed, 23 Sep 2026 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790169137; x=1821705137;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=BHvDLUI9nqVAlvcjaV5O4v/nRyJ1BP74c0k2XszR2Bo=;
 b=eXW6NNPvUsu80dIYsHl3LDzWkCLM6zDegeY32k8t90PvvvNRfY2owvI6
 27r9zmM4ecqPjnQ2RF2sFOtDMxu3YpvPVyzNuxI1XfHcYUmGVVthP2lFq
 9tsLxRqYnYAmAWcGu5vIOfMcWK9Nk+TbEWRBZHfTk6CriR4aeUuv4qZGf
 vwfj6Jz3OgTrSf44xYRM6gCAJoMfjhCjXdalEV6LkRYtDZSWDLznkYULp
 HIdjeT4gr4lU4tm79cvkKEbac+rVzo6SFwOkBRoSQKgEgsdKEPQlGWmLP
 FR5l5frwK2rbVcF2pxfkrwxC+mKG+6sLKWhSPEcz/sQesamH9jLF47yFN g==;
X-CSE-ConnectionGUID: qnx/MmrKSwmKn+pMQFM8GQ==
X-CSE-MsgGUID: MPQ7KB8uRhq3va7nPx6nIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="89996437"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="89996437"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 06:12:16 -0700
X-CSE-ConnectionGUID: iEZUdQppQA+APPRF92xoGA==
X-CSE-MsgGUID: 47uPzuqWRuag9QeVQneEQw==
X-ExtLoop1: 1
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.253])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 06:12:11 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, jfalempe@redhat.com,
 javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, sashiko-reviews@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/2] drm/fbdev: Move fbdev helpers into client library
In-Reply-To: <20260923110537.451614-3-tzimmermann@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260923110537.451614-1-tzimmermann@suse.de>
 <20260923110537.451614-3-tzimmermann@suse.de>
Date: Wed, 23 Sep 2026 16:12:09 +0300
Message-ID: <acbe05d92420f09ea69054b1215ec4dcab4c6953@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, 23 Sep 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> DRM's fbdev helpers are for the fbdev-emulation clients. Move them
> into the client-library module. Fix include statements throughout
> DRM drivers.

FWIW,

Acked-by: Jani Nikula <jani.nikula@intel.com>


>
> While at it, rename the files from drm_fb_helper to drm_fbdev_helper.
> The old name was too reminiscent of DRM's framebuffer code.
>
> The GEM support code for fbdev remains part of DRM's memory managers.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/Makefile                                      | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c                   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                       | 2 +-
>  drivers/gpu/drm/clients/Makefile                              | 3 ++-
>  drivers/gpu/drm/clients/drm_fbdev_client.c                    | 2 +-
>  .../gpu/drm/{drm_fb_helper.c => clients/drm_fbdev_helper.c}   | 2 +-
>  drivers/gpu/drm/drm_fbdev_dma.c                               | 2 +-
>  drivers/gpu/drm/drm_fbdev_shmem.c                             | 2 +-
>  drivers/gpu/drm/drm_fbdev_ttm.c                               | 2 +-
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c                     | 2 +-
>  drivers/gpu/drm/gma500/fbdev.c                                | 2 +-
>  drivers/gpu/drm/i915/display/intel_fbdev.c                    | 2 +-
>  drivers/gpu/drm/msm/msm_debugfs.c                             | 2 +-
>  drivers/gpu/drm/msm/msm_fbdev.c                               | 2 +-
>  drivers/gpu/drm/nouveau/dispnv50/disp.c                       | 1 -
>  drivers/gpu/drm/omapdrm/omap_debugfs.c                        | 2 +-
>  drivers/gpu/drm/omapdrm/omap_fbdev.c                          | 2 +-
>  drivers/gpu/drm/radeon/radeon_device.c                        | 2 +-
>  drivers/gpu/drm/radeon/radeon_fbdev.c                         | 2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c                   | 2 +-
>  drivers/gpu/drm/sitronix/st7571.c                             | 1 -
>  drivers/gpu/drm/tegra/fbdev.c                                 | 2 +-
>  drivers/gpu/drm/vboxvideo/vbox_mode.c                         | 2 +-
>  include/drm/{drm_fb_helper.h => clients/drm_fbdev_helper.h}   | 4 ++--
>  24 files changed, 23 insertions(+), 25 deletions(-)
>  rename drivers/gpu/drm/{drm_fb_helper.c => clients/drm_fbdev_helper.c} (99%)
>  rename include/drm/{drm_fb_helper.h => clients/drm_fbdev_helper.h} (99%)
>
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index f0c340aa2ec6..3a0f2095de3c 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -158,7 +158,6 @@ drm_kms_helper-y := \
>  drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
>  drm_kms_helper-$(CONFIG_DRM_PANIC_HELPER) += drm_panic_helper.o
>  drm_kms_helper-$(CONFIG_DRM_PANIC_SCREEN_QR_CODE) += drm_panic_helper_qr.o
> -drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
>  obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
>  
>  #
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 59ea338b554c..126bfd9bb89e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -38,11 +38,11 @@
>  
>  #include <linux/pci.h>
>  #include <linux/pm_runtime.h>
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_damage_helper.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_edid.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_modeset_helper.h>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f2f179421c4d..51a7a4091376 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -28,8 +28,8 @@
>  
>  #include "amdgpu.h"
>  #include <drm/amdgpu_drm.h>
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_fb_helper.h>
>  #include "amdgpu_uvd.h"
>  #include "amdgpu_vce.h"
>  #include "atom.h"
> diff --git a/drivers/gpu/drm/clients/Makefile b/drivers/gpu/drm/clients/Makefile
> index c16addbc327f..1304ff358509 100644
> --- a/drivers/gpu/drm/clients/Makefile
> +++ b/drivers/gpu/drm/clients/Makefile
> @@ -4,5 +4,6 @@ subdir-ccflags-y += -I$(src)/..
>  
>  drm_client_lib-y := drm_client_setup.o
>  drm_client_lib-$(CONFIG_DRM_CLIENT_LOG) += drm_log.o
> -drm_client_lib-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fbdev_client.o
> +drm_client_lib-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fbdev_client.o \
> +						drm_fbdev_helper.o
>  obj-$(CONFIG_DRM_CLIENT_LIB) += drm_client_lib.o
> diff --git a/drivers/gpu/drm/clients/drm_fbdev_client.c b/drivers/gpu/drm/clients/drm_fbdev_client.c
> index 7574bd36f45e..eec463d19943 100644
> --- a/drivers/gpu/drm/clients/drm_fbdev_client.c
> +++ b/drivers/gpu/drm/clients/drm_fbdev_client.c
> @@ -1,9 +1,9 @@
>  // SPDX-License-Identifier: MIT
>  
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_client.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_print.h>
>  
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/clients/drm_fbdev_helper.c
> similarity index 99%
> rename from drivers/gpu/drm/drm_fb_helper.c
> rename to drivers/gpu/drm/clients/drm_fbdev_helper.c
> index 76195410db60..fff3cf6a0aed 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/clients/drm_fbdev_helper.c
> @@ -32,9 +32,9 @@
>  #include <linux/console.h>
>  #include <linux/export.h>
>  
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
> index 9412d9fdd74b..452f84400350 100644
> --- a/drivers/gpu/drm/drm_fbdev_dma.c
> +++ b/drivers/gpu/drm/drm_fbdev_dma.c
> @@ -4,10 +4,10 @@
>  #include <linux/fb.h>
>  #include <linux/vmalloc.h>
>  
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fbdev_dma.h>
>  #include <drm/drm_fb_dma_helper.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_print.h>
> diff --git a/drivers/gpu/drm/drm_fbdev_shmem.c b/drivers/gpu/drm/drm_fbdev_shmem.c
> index 458c899b5d4f..8eb05fe9bc98 100644
> --- a/drivers/gpu/drm/drm_fbdev_shmem.c
> +++ b/drivers/gpu/drm/drm_fbdev_shmem.c
> @@ -3,9 +3,9 @@
>  #include <linux/export.h>
>  #include <linux/fb.h>
>  
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fbdev_shmem.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_gem_shmem_helper.h>
> diff --git a/drivers/gpu/drm/drm_fbdev_ttm.c b/drivers/gpu/drm/drm_fbdev_ttm.c
> index 160bc35d8738..8eb59c2ac5ea 100644
> --- a/drivers/gpu/drm/drm_fbdev_ttm.c
> +++ b/drivers/gpu/drm/drm_fbdev_ttm.c
> @@ -4,9 +4,9 @@
>  #include <linux/moduleparam.h>
>  #include <linux/vmalloc.h>
>  
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_print.h>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> index 8641c9e84d4c..f412269d6323 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> @@ -10,9 +10,9 @@
>  
>  #include <linux/fb.h>
>  
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_prime.h>
> diff --git a/drivers/gpu/drm/gma500/fbdev.c b/drivers/gpu/drm/gma500/fbdev.c
> index d1e93588234f..428912574f20 100644
> --- a/drivers/gpu/drm/gma500/fbdev.c
> +++ b/drivers/gpu/drm/gma500/fbdev.c
> @@ -7,9 +7,9 @@
>  
>  #include <linux/fb.h>
>  
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_framebuffer.h>
>  
>  #include "gem.h"
> diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
> index db0e36dd8722..219ee17de3f6 100644
> --- a/drivers/gpu/drm/i915/display/intel_fbdev.c
> +++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
> @@ -38,10 +38,10 @@
>  #include <linux/vga_switcheroo.h>
>  
>  #include <drm/clients/drm_client_setup.h>
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/intel/display_parent_interface.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
> index f12701e286ec..d05307bfa123 100644
> --- a/drivers/gpu/drm/msm/msm_debugfs.c
> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> @@ -9,8 +9,8 @@
>  #include <linux/debugfs.h>
>  #include <linux/fault-inject.h>
>  
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_debugfs.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_framebuffer.h>
>  
> diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
> index dd6d6c507d77..f37cc3f97a21 100644
> --- a/drivers/gpu/drm/msm/msm_fbdev.c
> +++ b/drivers/gpu/drm/msm/msm_fbdev.c
> @@ -6,9 +6,9 @@
>  
>  #include <linux/fb.h>
>  
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_crtc_helper.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_framebuffer.h>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index add19d479ebe..e91130f93db6 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -40,7 +40,6 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_eld.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_fixed.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_vblank.h>
> diff --git a/drivers/gpu/drm/omapdrm/omap_debugfs.c b/drivers/gpu/drm/omapdrm/omap_debugfs.c
> index 9edc1b3f9f95..1c40c489ed72 100644
> --- a/drivers/gpu/drm/omapdrm/omap_debugfs.c
> +++ b/drivers/gpu/drm/omapdrm/omap_debugfs.c
> @@ -6,10 +6,10 @@
>  
>  #include <linux/seq_file.h>
>  
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_debugfs.h>
>  #include <drm/drm_file.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_print.h>
>  
> diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
> index 4881777642d2..e1dcc3cb7c55 100644
> --- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
> +++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
> @@ -7,9 +7,9 @@
>  #include <linux/fb.h>
>  
>  #include <drm/clients/drm_client_setup.h>
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_crtc_helper.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_framebuffer.h>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 9523240110a6..fdbdcefa84e7 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -33,11 +33,11 @@
>  #include <linux/vga_switcheroo.h>
>  #include <linux/vgaarb.h>
>  
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_cache.h>
>  #include <drm/drm_client_event.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_device.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_probe_helper.h>
> diff --git a/drivers/gpu/drm/radeon/radeon_fbdev.c b/drivers/gpu/drm/radeon/radeon_fbdev.c
> index 3e243f5e2f44..e40c23d9dff2 100644
> --- a/drivers/gpu/drm/radeon/radeon_fbdev.c
> +++ b/drivers/gpu/drm/radeon/radeon_fbdev.c
> @@ -29,9 +29,9 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/vga_switcheroo.h>
>  
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index 9a1dc9f12072..b55113a7a00b 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -8,9 +8,9 @@
>  #include <linux/iommu.h>
>  #include <linux/vmalloc.h>
>  
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm.h>
>  #include <drm/drm_dumb_buffers.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_prime.h>
> diff --git a/drivers/gpu/drm/sitronix/st7571.c b/drivers/gpu/drm/sitronix/st7571.c
> index fc3ba5e8600f..5e60c4685671 100644
> --- a/drivers/gpu/drm/sitronix/st7571.c
> +++ b/drivers/gpu/drm/sitronix/st7571.c
> @@ -20,7 +20,6 @@
>  #include <drm/drm_damage_helper.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_encoder.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_fbdev_shmem.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_framebuffer.h>
> diff --git a/drivers/gpu/drm/tegra/fbdev.c b/drivers/gpu/drm/tegra/fbdev.c
> index 003e80cf7b9a..64c2e64f219b 100644
> --- a/drivers/gpu/drm/tegra/fbdev.c
> +++ b/drivers/gpu/drm/tegra/fbdev.c
> @@ -11,9 +11,9 @@
>  #include <linux/fb.h>
>  #include <linux/vmalloc.h>
>  
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_crtc_helper.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
> index bb3f7f0ad7c4..7c34299fa531 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
> @@ -13,11 +13,11 @@
>  #include <linux/iosys-map.h>
>  #include <linux/export.h>
>  
> +#include <drm/clients/drm_fbdev_helper.h>
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_blend.h>
>  #include <drm/drm_edid.h>
> -#include <drm/drm_fb_helper.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_gem_atomic_helper.h>
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/clients/drm_fbdev_helper.h
> similarity index 99%
> rename from include/drm/drm_fb_helper.h
> rename to include/drm/clients/drm_fbdev_helper.h
> index 0c5e5ed7b5e7..7575aaf34c62 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/clients/drm_fbdev_helper.h
> @@ -27,8 +27,8 @@
>   *      Dave Airlie <airlied@linux.ie>
>   *      Jesse Barnes <jesse.barnes@intel.com>
>   */
> -#ifndef DRM_FB_HELPER_H
> -#define DRM_FB_HELPER_H
> +#ifndef DRM_FBDEV_HELPER_H
> +#define DRM_FBDEV_HELPER_H
>  
>  struct drm_clip_rect;
>  struct drm_fb_helper;

-- 
Jani Nikula, Intel
