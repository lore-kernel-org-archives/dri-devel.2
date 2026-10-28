Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15991606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PF1vR7+9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6999B10E68D;
	Wed, 28 Oct 2026 15:58:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5652010E677
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 15:58:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EC661756
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 08:58:35 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 777063F673
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793203118; bh=LqMVoiCpP/7b83Vo3Et5H75tfBu+HMQvKifhWWwQWHs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PF1vR7+9WCPAiq130LizExkmLfp6Kp5BMNgF6BzX8WsQr9aWoD8+I5gjTw0y4AKZu
 tf5a1mKbyhqOGZLUbW6jCHpI81HnKOxsHRsM71R068N9N2P0zC9MmzFbnxm5thEOsz
 mPCn/Ux0zktCc+Ib4hdS66F+EdFKmwwqqqRJ517g=
Date: Wed, 28 Oct 2026 15:58:37 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v1 04/27] drm/panthor: Add 64-bit GPU_ID decoding for v15
 GPUs
Message-ID: <auIbraVb0PKxFmPm@e142607>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-5-karunika.choo@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922204535.2850094-5-karunika.choo@arm.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

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
>  
>  /**
> -- 
> 2.43.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
