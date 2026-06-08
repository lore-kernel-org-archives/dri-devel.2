Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253B6CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7522610F3C0;
	Mon,  8 Jun 2026 13:28:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HKbE7Zch";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9590810F3C0
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 13:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780925301;
 bh=Xal4WwcUKx8z0IdWwXKFAhEvvuSmwHvRYMXNT0+INYY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HKbE7ZchrsiHo2d0L3Ijk3DLY6rESmVEJcRgwMGfVhcXDD/3ZFH1X0XiajBnsc/Lu
 EP8Wyjgq8H3ejbPP2NTnj6Xswh8XXJqi8E4MvD0bxTUWpMuPwq9/oEN5VS9rKHoRmt
 qGfBS5uzs8su+EUUWUZVsZ+2E/+2Fak0pjS8yGOr08Vt4RuIrmAf1PHQamF8eZTV3I
 qOx7jLFX48j7ryBY3W6HyekQmeLgta+PNwS+xOP5aJdngXjeFdHuzKc1X81MFfvpBy
 DysW0MmQgmj/1eJLsp+H2/s1mtWC3nQeYGMVOwsIm/mgT0sYeVuxAPc8pQvuF83bPS
 7gdGAzuKepcuw==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BEED517E0191;
 Mon,  8 Jun 2026 15:28:20 +0200 (CEST)
Date: Mon, 8 Jun 2026 15:28:17 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/18] drm/panthor: Add 64-bit GPU_ID decoding for
 v15 GPUs
Message-ID: <20260608152817.7f72ab08@fedora-2.home>
In-Reply-To: <20260528150546.3168527-5-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-5-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 28 May 2026 16:05:32 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> Mali v15 exposes a 64-bit GPU_ID register with a different field layout
> from earlier GPUs.
> 
> Add the register definitions and decoding helpers for the new format,
> read GPU_WIDE_ID when the compatibility value indicates a v15 GPU, and
> populate both the cached GPU_ID fields and the uAPI gpu_id_hi field.
> 
> This allows userspace and the driver to identify v15 GPUs correctly.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  .../drm/panthor/panthor_gpu_discover_regs.h   | 17 +++++++++
>  drivers/gpu/drm/panthor/panthor_hw.c          | 38 ++++++++++++++-----
>  include/uapi/drm/panthor_drm.h                | 10 +++++
>  3 files changed, 56 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
> new file mode 100644
> index 000000000000..54bb104902ee
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 or MIT */
> +/* Copyright 2026 ARM Limited. All rights reserved. */
> +
> +#ifndef __PANTHOR_GPU_DISCOVER_REGS_H__
> +#define __PANTHOR_GPU_DISCOVER_REGS_H__
> +
> +#define GPU_WIDE_ID					0x0
> +#define   GPU_WIDE_COMPAT				0xF
> +#define   GPU_WIDE_ARCH_MAJOR(x)			(((x) & GENMASK(63, 56)) >> 56)
> +#define   GPU_WIDE_ARCH_MINOR(x)			(((x) & GENMASK(55, 48)) >> 48)
> +#define   GPU_WIDE_ARCH_REV(x)				(((x) & GENMASK(47, 40)) >> 40)
> +#define   GPU_WIDE_PROD_MAJOR(x)			(((x) & GENMASK(39, 32)) >> 32)
> +#define   GPU_WIDE_VER_MAJOR(x)				(((x) & GENMASK(23, 16)) >> 16)
> +#define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK(15, 8)) >> 8)
> +#define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK(7, 0))
> +
> +#endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 3570e2889584..833d10cbb2d6 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -9,6 +9,7 @@
>  #include "panthor_device.h"
>  #include "panthor_device_io.h"
>  #include "panthor_gpu.h"
> +#include "panthor_gpu_discover_regs.h"
>  #include "panthor_gpu_regs.h"
>  #include "panthor_hw.h"
>  #include "panthor_pwr.h"
> @@ -297,18 +298,37 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
>  static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
>  {
>  	struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
> -	ptdev->gpu_info.gpu_id = gpu_read(ptdev->iomem, GPU_ID);
> +	u32 gpu_id32 = gpu_read(ptdev->iomem, GPU_ID);
>  
> -	if (!ptdev->gpu_info.gpu_id)
> +	if (!gpu_id32)
>  		return -ENXIO;
>  
> -	gpu_id->arch.major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
> -	gpu_id->arch.minor = GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id);
> -	gpu_id->arch.rev = GPU_ARCH_REV(ptdev->gpu_info.gpu_id);
> -	gpu_id->prod_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
> -	gpu_id->ver.major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
> -	gpu_id->ver.minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
> -	gpu_id->ver.status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
> +	ptdev->gpu_info.gpu_id = gpu_id32;
> +
> +	gpu_id->arch.major = GPU_ARCH_MAJOR(gpu_id32);
> +	gpu_id->arch.minor = GPU_ARCH_MINOR(gpu_id32);
> +	gpu_id->arch.rev = GPU_ARCH_REV(gpu_id32);
> +	gpu_id->prod_major = GPU_PROD_MAJOR(gpu_id32);
> +	gpu_id->ver.major = GPU_VER_MAJOR(gpu_id32);
> +	gpu_id->ver.minor = GPU_VER_MINOR(gpu_id32);
> +	gpu_id->ver.status = GPU_VER_STATUS(gpu_id32);
> +
> +	if (GPU_ARCH_MAJOR(gpu_id32) == GPU_WIDE_COMPAT) {
> +		u64 gpu_id64 = gpu_read64(ptdev->iomem, GPU_WIDE_ID);

I know we currently assume that DISCOVER regs on v15 and GPU regs on
older gens are starting at zero, but I'd prefer to make this explicit
with something like:

		/* DISCOVER register block always starts at offset
		 * zero, so does the GPU register block on older
		 * GPUs.
		 */
		void __iomem *discover = ptdev->iomem;
		u64 gpu_id64 = gpu_read64(discover, GPU_WIDE_ID);
> +		if (!gpu_id64)
> +			return -ENXIO;
> +
> +		ptdev->gpu_info.gpu_wide_id = gpu_id64;
> +		ptdev->gpu_info.gpu_id = 0;
> +
> +		gpu_id->arch.major = GPU_WIDE_ARCH_MAJOR(gpu_id64);
> +		gpu_id->arch.minor = GPU_WIDE_ARCH_MINOR(gpu_id64);
> +		gpu_id->arch.rev = GPU_WIDE_ARCH_REV(gpu_id64);
> +		gpu_id->prod_major = GPU_WIDE_PROD_MAJOR(gpu_id64);
> +		gpu_id->ver.major = GPU_WIDE_VER_MAJOR(gpu_id64);
> +		gpu_id->ver.minor = GPU_WIDE_VER_MINOR(gpu_id64);
> +		gpu_id->ver.status = GPU_WIDE_VER_STATUS(gpu_id64);
> +	}

I'd probably move the !has_wide_id() logic to an else branch instead of
assigning unconditionally, and then fixing up if has_wide_id() is true:

	if (GPU_ARCH_MAJOR(gpu_id32) == GPU_WIDE_COMPAT) {
		u64 gpu_id64 = gpu_read64(ptdev->iomem, GPU_WIDE_ID);
		if (!gpu_id64)
			return -ENXIO;

		ptdev->gpu_info.gpu_wide_id = gpu_id64;
		gpu_id->arch.major = GPU_WIDE_ARCH_MAJOR(gpu_id64);
		gpu_id->arch.minor = GPU_WIDE_ARCH_MINOR(gpu_id64);
		gpu_id->arch.rev = GPU_WIDE_ARCH_REV(gpu_id64);
		gpu_id->prod_major = GPU_WIDE_PROD_MAJOR(gpu_id64);
		gpu_id->ver.major = GPU_WIDE_VER_MAJOR(gpu_id64);
		gpu_id->ver.minor = GPU_WIDE_VER_MINOR(gpu_id64);
		gpu_id->ver.status = GPU_WIDE_VER_STATUS(gpu_id64);
	} else {
		ptdev->gpu_info.gpu_id = gpu_id32;
		gpu_id->arch.major = GPU_ARCH_MAJOR(gpu_id32);
		gpu_id->arch.minor = GPU_ARCH_MINOR(gpu_id32);
		gpu_id->arch.rev = GPU_ARCH_REV(gpu_id32);
		gpu_id->prod_major = GPU_PROD_MAJOR(gpu_id32);
		gpu_id->ver.major = GPU_VER_MAJOR(gpu_id32);
		gpu_id->ver.minor = GPU_VER_MINOR(gpu_id32);
		gpu_id->ver.status = GPU_VER_STATUS(gpu_id32);
	}


>  
>  	return 0;
>  }
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index 0e455d91e77d..04fc9f133152 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -373,6 +373,16 @@ struct drm_panthor_gpu_info {
>  
>  	/** @gpu_features: Bitmask describing supported GPU-wide features */
>  	__u64 gpu_features;
> +
> +	/** @gpu_wide_id: 64-bit GPU_ID for v15 onwards. */

Specify that it's zero on v14- HW, and also update the gpu_id doc to
mention it will be zero on v15+.

> +	__u64 gpu_wide_id;
> +#define DRM_PANTHOR_WIDE_ARCH_MAJOR(x)		(((x) >> 56) & 0xff)
> +#define DRM_PANTHOR_WIDE_ARCH_MINOR(x)		(((x) >> 48) & 0xff)
> +#define DRM_PANTHOR_WIDE_ARCH_REV(x)		(((x) >> 40) & 0xff)
> +#define DRM_PANTHOR_WIDE_PRODUCT_MAJOR(x)	(((x) >> 32) & 0xff)
> +#define DRM_PANTHOR_WIDE_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
> +#define DRM_PANTHOR_WIDE_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
> +#define DRM_PANTHOR_WIDE_VERSION_STATUS(x)	((x) & 0xff)
>  };
>  
>  /**

