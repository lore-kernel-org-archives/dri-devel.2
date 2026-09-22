Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922B7C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C51CA10E2B0;
	Tue, 22 Sep 2026 12:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nMnSkx7f";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CD5A10E2B0;
 Tue, 22 Sep 2026 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=Uy/GfFdKXUPHRo8d/JJfzN7Xe+yzCqJHo/wc5bj6rvc=; b=nMnSkx7f+ANN2MUwihAKiP6cPR
 8uMqeMiMYQnZZsV+d6ezqdxHWaSlDyu5mIlYer/ntMwYsjs1YjpgWvI0a8AYhRXAgEcxBFKolapG2
 x9n4w2X32sbLlCxeySvbaf7bBY20cksK0cb38nWaK7/IFyAia4iI09BiIf+rxTVX/nkoO8B2jD2J3
 6uhzZT+3/MBuHEESGjufOFWWD/hOzyFmyN6sVZgRJP9a4MZDbloOSbZfx6iEIyXDG4si+A5erYvNR
 yN/IQWiaeoi1gV/NUTyS7zsKKDZ8od52O0Ytv8a5QJ72Q0LlVfmwY+2BCS3i04CwbiPKxq2WpkOfL
 g2daQ0SQ==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x8zBN-005bxu-UM; Tue, 22 Sep 2026 14:01:09 +0200
Message-ID: <fe616885-5509-4236-8261-7cdb3b0ef67c@igalia.com>
Date: Tue, 22 Sep 2026 09:00:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] drm: Rename drm_utils.h to drm_panel_quirks.h
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
References: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
 <20260915-drm-timeout-helpers-v3-7-f2ae987d861f@igalia.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20260915-drm-timeout-helpers-v3-7-f2ae987d861f@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Thomas, do you have any thoughts about this change?

Best regards,
- Maíra

On 15/09/26 16:42, Maíra Canal wrote:
> Now that the timeout-related functions were removed from drm_utils.h,
> the header has exclusively panel orientation and backlight quirk getters.
> 
> Therefore, rename the header accordingly and update all files that
> include it. The files amdgpu_dm.c, amdgpu_dm_connector.c and panthor_drv.c
> include the header but don't use it, so drop the include there.
> 
> No functional change.
> 
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 1 -
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c | 2 +-
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 1 -
>   drivers/gpu/drm/drm_connector.c                             | 2 +-
>   drivers/gpu/drm/drm_panel_backlight_quirks.c                | 2 +-
>   drivers/gpu/drm/drm_panel_orientation_quirks.c              | 2 +-
>   drivers/gpu/drm/panthor/panthor_drv.c                       | 1 -
>   drivers/video/fbdev/efifb.c                                 | 2 +-
>   include/drm/{drm_utils.h => drm_panel_quirks.h}             | 8 +++-----
>   9 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4426e18f7543..5f20fff2d466 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -98,7 +98,6 @@
>   #include <drm/drm_edid.h>
>   #include <drm/drm_eld.h>
>   #include <drm/drm_mode.h>
> -#include <drm/drm_utils.h>
>   #include <drm/drm_vblank.h>
>   #include <drm/drm_colorop.h>
>   #include <drm/drm_gem_atomic_helper.h>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index b9e90ea449ca..3211bd1472b2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -41,7 +41,7 @@
>   #include <linux/backlight.h>
>   #include <linux/power_supply.h>
>   #include <drm/drm_edid.h>
> -#include <drm/drm_utils.h>
> +#include <drm/drm_panel_quirks.h>
>   
>   #include <acpi/video.h>
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index e7b555fa666f..9e43e70afe8d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -62,7 +62,6 @@
>   #include <drm/drm_fixed.h>
>   #include <drm/drm_mode.h>
>   #include <drm/drm_probe_helper.h>
> -#include <drm/drm_utils.h>
>   #include <drm/display/drm_dp_mst_helper.h>
>   #include <drm/display/drm_hdmi_helper.h>
>   #include <drm/drm_privacy_screen_consumer.h>
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 8b4baed060f3..c4d844205971 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -28,10 +28,10 @@
>   #include <drm/drm_file.h>
>   #include <drm/drm_managed.h>
>   #include <drm/drm_panel.h>
> +#include <drm/drm_panel_quirks.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_privacy_screen_consumer.h>
>   #include <drm/drm_sysfs.h>
> -#include <drm/drm_utils.h>
>   
>   #include <linux/export.h>
>   #include <linux/platform_device.h>
> diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> index e417c7533053..dcb91e12bac6 100644
> --- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> @@ -5,7 +5,7 @@
>   #include <linux/export.h>
>   #include <linux/module.h>
>   #include <drm/drm_edid.h>
> -#include <drm/drm_utils.h>
> +#include <drm/drm_panel_quirks.h>
>   
>   struct drm_panel_match {
>   	enum dmi_field field;
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 3a218fb592ce..813a204cd201 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -12,7 +12,7 @@
>   #include <linux/export.h>
>   #include <linux/module.h>
>   #include <drm/drm_connector.h>
> -#include <drm/drm_utils.h>
> +#include <drm/drm_panel_quirks.h>
>   
>   #ifdef CONFIG_DMI
>   
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 46a3080b0b20..4bb74102acb1 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -25,7 +25,6 @@
>   #include <drm/drm_ioctl.h>
>   #include <drm/drm_print.h>
>   #include <drm/drm_syncobj.h>
> -#include <drm/drm_utils.h>
>   #include <drm/gpu_scheduler.h>
>   #include <drm/panthor_drm.h>
>   
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index ad8dec7807c3..3411be06d3e6 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -18,8 +18,8 @@
>   #include <linux/sysfb.h>
>   #include <video/vga.h>
>   #include <asm/efi.h>
> -#include <drm/drm_utils.h> /* For drm_get_panel_orientation_quirk */
>   #include <drm/drm_connector.h>  /* For DRM_MODE_PANEL_ORIENTATION_* */
> +#include <drm/drm_panel_quirks.h> /* For drm_get_panel_orientation_quirk */
>   
>   struct bmp_file_header {
>   	u16 id;
> diff --git a/include/drm/drm_utils.h b/include/drm/drm_panel_quirks.h
> similarity index 63%
> rename from include/drm/drm_utils.h
> rename to include/drm/drm_panel_quirks.h
> index c61dee76451c..60711a49d403 100644
> --- a/include/drm/drm_utils.h
> +++ b/include/drm/drm_panel_quirks.h
> @@ -1,14 +1,12 @@
>   /* SPDX-License-Identifier: MIT */
>   /*
> - * Function prototypes for misc. drm utility functions.
> - * Specifically this file is for function prototypes for functions which
> - * may also be used outside of drm code (e.g. in fbdev drivers).
> + * Function prototypes for panel-related quirks.
>    *
>    * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
>    */
>   
> -#ifndef __DRM_UTILS_H__
> -#define __DRM_UTILS_H__
> +#ifndef __DRM_PANEL_QUIRKS_H__
> +#define __DRM_PANEL_QUIRKS_H__
>   
>   #include <linux/types.h>
>   
> 

