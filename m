Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DC0CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E739D10E36E;
	Wed, 10 Jun 2026 16:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="E/+co/Xv";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9AF9F10E36E
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 16:02:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 588482103;
 Wed, 10 Jun 2026 09:02:09 -0700 (PDT)
Received: from [10.57.29.87] (unknown [10.57.29.87])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 327BF3F99C;
 Wed, 10 Jun 2026 09:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781107334; bh=j73F/G4OWvwMt3H9kCTjeXosf9iM166E9bY3jeUmw/4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=E/+co/Xv2jHUlnGJb5V2Ft5CX/DLGGnyLNfCE+tEqCW1TIhzwaYhDfZ38/EvN0Dtf
 Y0L41B8fjBVuclX4m2YfWOzzdkixmbl0ShAg0BjlvcUy2S0lSB+pQSzWRF0itULKeR
 46A6rE6tWWa4BxxDfD+HI5vC8GTLx666jSQCxBCc=
Message-ID: <5c793842-daed-4603-a2d5-9a9f46e2e526@arm.com>
Date: Wed, 10 Jun 2026 17:02:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/18] drm/panthor: Add 64-bit GPU_ID decoding for v15
 GPUs
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-5-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260528150546.3168527-5-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
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

On 28/05/2026 16:05, Karunika Choo wrote:
> Mali v15 exposes a 64-bit GPU_ID register with a different field layout
> from earlier GPUs.
> 
> Add the register definitions and decoding helpers for the new format,
> read GPU_WIDE_ID when the compatibility value indicates a v15 GPU, and
> populate both the cached GPU_ID fields and the uAPI gpu_id_hi field.

s/gpu_id_hi/gpu_wide_id/

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

I think you need GENMASK_U64 here - otherwise this is going to cause
problems on a 32 bit build (yes I know, but apparently people do still
use 32 bits - at least as a COMPILE_TEST target).

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

It seems odd to assign a bunch of wrong values to then detect the
WIDE_COMPAT marker afterwards. Wouldn't it be clearer to write:

	if (GPU_ARCH_MAJOR(gpu_id32) != GPU_WIDE_COMPAT) {
		ptdev->gpu_info.gpu_id = gpu_id32;

		gpu_id->arch.major = GPU_ARCH_MAJOR(gpu_id32);
		gpu_id->arch.minor = GPU_ARCH_MINOR(gpu_id32);
		gpu_id->arch.rev = GPU_ARCH_REV(gpu_id32);
		gpu_id->prod_major = GPU_PROD_MAJOR(gpu_id32);
		gpu_id->ver.major = GPU_VER_MAJOR(gpu_id32);
		gpu_id->ver.minor = GPU_VER_MINOR(gpu_id32);
		gpu_id->ver.status = GPU_VER_STATUS(gpu_id32);
	} else {
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
> +	__u64 gpu_wide_id;

I think it's worth a comment explaining how user space is meant to know
that gpu_wide_id is in use. I presume this is by looking at gpu_id and
seing it's zero?

We might also want a version bump in panthor_drm_driver so user space
knows that this is available (but that can be when all v15 support is in
place).

Thanks,
Steve

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

