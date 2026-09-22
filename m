Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DD6C982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 23:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F6B10EE9F;
	Tue, 22 Sep 2026 23:23:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="EAoQOvxi";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C7D410EE9F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 23:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790119409; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nhWvax1F9xTG5I/m8hTeEsAkdXE079fqQ7MtGS+HXxmnpuHI0YlKU0s41C4ly58VksTmfiLaTgpyFT0AggVwYHzIDb72fkFRDsvTmaxtWXsRiGZrL0I5vfgDGqHpZN9GQZ6fEKjBYEZ6W9uXapnFQEDeIE1W/5sU6MAj/YpyI28=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790119409;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=c+CKVAXKvF3QH2XbDhGfJoZluYlA2vvQfpVP+/rBZdc=; 
 b=mdrEzFGq817nqEdqOxvt4ATdXMQDM60MITqU3GCJc0SVM3XnjYPOkwS+6Pdqu3ELHz/RBdUFlK9nhSw13feKGkIExmp8h99ys8ORR2XT7msPgZNt6OjabofR3XbGIVbnW/KWquvV7VP5bJUhX8tKK+kS+gYa57CjB71hiYw5J1M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790119409; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=c+CKVAXKvF3QH2XbDhGfJoZluYlA2vvQfpVP+/rBZdc=;
 b=EAoQOvxiCJJovxMhdeoAAY3ZWIOQJ7fNXaeqmHUaq2QJrixlvcgTyxqutu4FzSLV
 xc8j4beiioOA6eQM+CY5aWf+H/2NJLjabYbSo2QNrqvlGF97SKCXImS4bPVxvdlwgm4
 hWRKD0ihxWF2dM/0icTVjRigvDKGW5yglCK4ALwc=
Received: by smtp.zohomail.com with SMTPS id 1790119407034940.7269783412032;
 Tue, 22 Sep 2026 16:23:27 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:23:26 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v1 04/27] drm/panthor: Add 64-bit GPU_ID decoding for v15
 GPUs
Message-ID: <arMN7pGrDoPJq0kX@um790>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-5-karunika.choo@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922204535.2850094-5-karunika.choo@arm.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.95.26
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

On Tue, Sep 22, 2026 at 09:44:58PM +0100, Karunika Choo wrote:
> Mali v15 exposes a 64-bit GPU_ID register with a different field layout
> from earlier GPUs.
> 
> Add the register definitions and decoding helpers for the new format,
> read GPU_WIDE_ID when the compatibility value indicates a v15 GPU, and
> populate both the cached GPU_ID fields and the uAPI gpu_wide_id field.
> 
> This allows userspace and the driver to identify v15 GPUs correctly.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
> v1:
> - Decode selected GPU_ID format after checking compatibility value.
> - Document GPU_DISCOVER and GPU_CONTROL register offset differences
>   between GPUs.
> - Fix mask generation in panthor_gpu_discover_regs.h
> 
>  .../drm/panthor/panthor_gpu_discover_regs.h   | 19 +++++++++
>  drivers/gpu/drm/panthor/panthor_hw.c          | 42 +++++++++++++++----
>  include/uapi/drm/panthor_drm.h                | 13 ++++++
>  3 files changed, 65 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
> new file mode 100644
> index 0000000000000..e6bfe1fe2c68a
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 or MIT */
> +/* Copyright 2026 ARM Limited. All rights reserved. */
> +
> +#ifndef __PANTHOR_GPU_DISCOVER_REGS_H__
> +#define __PANTHOR_GPU_DISCOVER_REGS_H__
> +
> +#include <linux/bits.h>
> +
> +#define GPU_WIDE_ID					0x0
> +#define   GPU_WIDE_COMPAT				0xF
> +#define   GPU_WIDE_ARCH_MAJOR(x)			(((x) & GENMASK_U64(63, 56)) >> 56)
> +#define   GPU_WIDE_ARCH_MINOR(x)			(((x) & GENMASK_U64(55, 48)) >> 48)
> +#define   GPU_WIDE_ARCH_REV(x)				(((x) & GENMASK_U64(47, 40)) >> 40)
> +#define   GPU_WIDE_PROD_MAJOR(x)			(((x) & GENMASK_U64(39, 32)) >> 32)
> +#define   GPU_WIDE_VER_MAJOR(x)				(((x) & GENMASK_U64(23, 16)) >> 16)
> +#define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK_U64(15, 8)) >> 8)
> +#define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK_U64(7, 0))
> +
> +#endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 2143e57d48106..40012ba7e23ca 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -8,6 +8,7 @@
>  
>  #include "panthor_device.h"
>  #include "panthor_gpu.h"
> +#include "panthor_gpu_discover_regs.h"
>  #include "panthor_gpu_regs.h"
>  #include "panthor_hw.h"
>  #include "panthor_pwr.h"
> @@ -296,18 +297,41 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
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
> -	gpu_id->arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
> -	gpu_id->arch_minor = GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id);
> -	gpu_id->arch_rev = GPU_ARCH_REV(ptdev->gpu_info.gpu_id);
> -	gpu_id->prod_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
> -	gpu_id->ver_major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
> -	gpu_id->ver_minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
> -	gpu_id->ver_status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
> +	if (GPU_ARCH_MAJOR(gpu_id32) == GPU_WIDE_COMPAT) {
> +		/*
> +		 * GPU_DISCOVER register block always starts at offset zero,
> +		 * so does the GPU_CONTROL register block on pre-v15 GPUs.
> +		 */
> +		void __iomem *discover = ptdev->iomem;
> +		u64 gpu_id64 = gpu_read64(discover, GPU_WIDE_ID);
> +		if (!gpu_id64)
> +			return -ENXIO;
> +
> +		ptdev->gpu_info.gpu_wide_id = gpu_id64;
> +
> +		gpu_id->arch_major = GPU_WIDE_ARCH_MAJOR(gpu_id64);
> +		gpu_id->arch_minor = GPU_WIDE_ARCH_MINOR(gpu_id64);
> +		gpu_id->arch_rev = GPU_WIDE_ARCH_REV(gpu_id64);
> +		gpu_id->prod_major = GPU_WIDE_PROD_MAJOR(gpu_id64);
> +		gpu_id->ver_major = GPU_WIDE_VER_MAJOR(gpu_id64);
> +		gpu_id->ver_minor = GPU_WIDE_VER_MINOR(gpu_id64);
> +		gpu_id->ver_status = GPU_WIDE_VER_STATUS(gpu_id64);
> +	} else {
> +		ptdev->gpu_info.gpu_id = gpu_id32;
> +
> +		gpu_id->arch_major = GPU_ARCH_MAJOR(gpu_id32);
> +		gpu_id->arch_minor = GPU_ARCH_MINOR(gpu_id32);
> +		gpu_id->arch_rev = GPU_ARCH_REV(gpu_id32);
> +		gpu_id->prod_major = GPU_PROD_MAJOR(gpu_id32);
> +		gpu_id->ver_major = GPU_VER_MAJOR(gpu_id32);
> +		gpu_id->ver_minor = GPU_VER_MINOR(gpu_id32);
> +		gpu_id->ver_status = GPU_VER_STATUS(gpu_id32);
> +	}
>  
>  	return 0;
>  }
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index a2ff0f4ec6915..843a0b40e1d36 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -376,6 +376,19 @@ struct drm_panthor_gpu_info {
>  
>  	/** @gpu_features: Bitmask describing supported GPU-wide features */
>  	__u64 gpu_features;
> +
> +	/**
> +	 * @gpu_wide_id: 64-bit GPU ID for v15 and later GPUs. @gpu_id is 0 when
> +	 * this is populated.
> +	 */
> +	__u64 gpu_wide_id;
> +#define DRM_PANTHOR_WIDE_ARCH_MAJOR(x)		(((x) >> 56) & 0xff)
> +#define DRM_PANTHOR_WIDE_ARCH_MINOR(x)		(((x) >> 48) & 0xff)
> +#define DRM_PANTHOR_WIDE_ARCH_REV(x)		(((x) >> 40) & 0xff)
> +#define DRM_PANTHOR_WIDE_PRODUCT_MAJOR(x)	(((x) >> 32) & 0xff)
> +#define DRM_PANTHOR_WIDE_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
> +#define DRM_PANTHOR_WIDE_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
> +#define DRM_PANTHOR_WIDE_VERSION_STATUS(x)	((x) & 0xff)
>  };

This patch is meant to pre-emptively prevent a compile failure for tyr
that sashiko-bot pointed out will happen from this patch (or anything
similar :))

https://lore.kernel.org/rust-for-linux/20260922-b4-gpu_info_zero-v1-1-7259840069c6@collabora.com/T/#u


>  
>  /**
> -- 
> 2.43.0
> 
