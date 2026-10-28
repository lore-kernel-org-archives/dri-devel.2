Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA4606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WlDTIcnN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E937B10FD8F;
	Wed, 28 Oct 2026 16:20:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id E4CB810FD79
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 16:20:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CD8D1756
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:20:46 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 317493F59E
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793204449; bh=JUCTRiFueu+szCLQK3JTp4IoCOCN1BVL0JwNcbelPxg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WlDTIcnNVQlBg01ke2qf72EH5DBNxORbmKvV2S/exINfxLKs8ouorv5AQ3ClzH8e9
 d24nfKAdUfnDmvFXEberlRBSzundyK9ZHlB8ggfTPctlAQ5AgL+IwCyNHYtzhHPQA7
 KPUcH2l8qL6dDuCsSy1rkp/LABAJjLmCgrbn3Elg=
Date: Wed, 28 Oct 2026 16:20:47 +0000
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
Subject: Re: [PATCH v1 08/27] drm/panthor: Add Mali v15 hardware support
Message-ID: <auIg3-hRQlv7YeHP@e142607>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-9-karunika.choo@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922204535.2850094-9-karunika.choo@arm.com>
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

On Tue, Sep 22, 2026 at 09:45:02PM +0100, Karunika Choo wrote:
> Add the panthor hardware description for Mali v15 GPUs and hook it into
> device matching.
> 
> This includes the v15 register map and product identification needed to
> populate the GPU information exposed by the driver and its uAPI.
> 
> Add compatibility string for v15 GPUs.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
> v1:
> - make COHERENCY_FEATURES register read use cached gpu_info values.
> - Added Mali-G2 name variants and NX aware model identification.
> - fix premature reading of l2_features gpu_info field during
>   panthor_hw_info_init().
> - build as_present using GENMASK.
> 
>  drivers/gpu/drm/panthor/panthor_drv.c         |  1 +
>  drivers/gpu/drm/panthor/panthor_fw.c          |  1 +
>  drivers/gpu/drm/panthor/panthor_gpu.c         |  3 +-
>  .../drm/panthor/panthor_gpu_discover_regs.h   | 25 +++++
>  drivers/gpu/drm/panthor/panthor_gpu_regs.h    |  1 +
>  drivers/gpu/drm/panthor/panthor_heap.c        |  3 +-
>  drivers/gpu/drm/panthor/panthor_hw.c          | 98 ++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_hw.h          | 13 +++
>  include/uapi/drm/panthor_drm.h                | 10 +-
>  9 files changed, 147 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 8cdba0c1a14b9..3fe9f96f7755e 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1886,6 +1886,7 @@ static const struct of_device_id dt_match[] = {
>  	{ .compatible = "mediatek,mt8196-mali", .data = &soc_data_mediatek_mt8196, },
>  	{ .compatible = "rockchip,rk3588-mali" },
>  	{ .compatible = "arm,mali-valhall-csf" },
> +	{ .compatible = "arm,mali-gen5-am" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dt_match);
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 679ea1d233d53..1449d9a66302e 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1563,3 +1563,4 @@ MODULE_FIRMWARE("arm/mali/arch11.8/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch12.8/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch13.8/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch14.8/mali_csffw.bin");
> +MODULE_FIRMWARE("arm/mali/arch15.8/mali_csffw.bin");
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index d6534fabc682e..e6e970e9b59d3 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -499,8 +499,7 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
>  	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
>  	 * ACE protocol has never been supported for command stream frontend GPUs.
>  	 */
> -	if ((gpu_read(ptdev->gpu->iomem, GPU_COHERENCY_FEATURES) &
> -		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
> +	if ((ptdev->gpu_info.coherency_features & GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
>  		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
>  		return 0;
>  	}
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
> index e6bfe1fe2c68a..c4d0cb2fca92d 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
> @@ -16,4 +16,29 @@
>  #define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK_U64(15, 8)) >> 8)
>  #define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK_U64(7, 0))
>  
> +#define DISCOVER_REVIDR					0x8
> +#define DISCOVER_GPU_FEATURES				0x20
> +#define   GPU_FEATURES_VARIABLE_RATE_SHADING		BIT(0)
> +#define   GPU_FEATURES_SIMD_STATE			BIT(1)
> +#define   GPU_FEATURES_CROSS_STREAM_SYNC		BIT(3)
> +#define   GPU_FEATURES_NX				BIT(4)
> +#define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
> +#define   GPU_FEATURES_LD_LEA_TENSOR_INSTRUCTIONS	BIT(6)

Either these macros need a new prefix to prevent clashing with the definitions in panthor_gpu_regs.h, or
the two declarations should be unified.

> +#define DISCOVER_MCU_FEATURES				0x40
> +#define DISCOVER_PRFCNT_FEATURES			0x50
> +#define   PRFCNT_FEATURES_COUNTER_BLOCK_SIZE(x)		(((x) & GENMASK(7, 0)) << 8)
> +#define DISCOVER_DOORBELL_FEATURES			0x60
> +#define DISCOVER_MEM_FEATURES				0x100
> +#define DISCOVER_MMU_FEATURES				0x108
> +#define   MMU_FEATURES_AS_COUNT(x)			(((x) & GENMASK(23, 16)) >> 16)
> +#define DISCOVER_AMBA_FEATURES				0x120
> +
> +#define DISCOVER_L2_FEATURES				0x128
> +#define DISCOVER_TILER_FEATURES				0x200
> +#define DISCOVER_CORE_FEATURES				0x300
> +#define DISCOVER_THREAD_FEATURES			0x320
> +#define DISCOVER_THREAD_MAX_THREADS			0x330
> +#define DISCOVER_THREAD_NUM_ACTIVE_GRANULARITY		0x334
> +#define DISCOVER_TEXTURE_FEATURES			0x360
> +
>  #endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> index 753df87009901..60819c4ace428 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> @@ -65,6 +65,7 @@
>  
>  #define GPU_FEATURES					0x60
>  #define   GPU_FEATURES_RAY_INTERSECTION			BIT(2)
> +#define   GPU_FEATURES_NX				BIT(4)
>  #define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
>  
>  #define GPU_TIMESTAMP_OFFSET				0x88
> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
> index 99311abdf1e91..afb7d68abc874 100644
> --- a/drivers/gpu/drm/panthor/panthor_heap.c
> +++ b/drivers/gpu/drm/panthor/panthor_heap.c
> @@ -11,6 +11,7 @@
>  #include "panthor_gem.h"
>  #include "panthor_gpu_regs.h"
>  #include "panthor_heap.h"
> +#include "panthor_hw.h"
>  #include "panthor_mmu.h"
>  
>  /*
> @@ -105,7 +106,7 @@ struct panthor_heap_pool {
>  
>  static int panthor_heap_ctx_stride(struct panthor_device *ptdev)
>  {
> -	u32 l2_features = ptdev->gpu_info.l2_features;
> +	u64 l2_features = panthor_hw_get_l2_features(ptdev);
>  	u32 gpu_cache_line_size = GPU_L2_FEATURES_LINE_SIZE(l2_features);
>  
>  	return ALIGN(HEAP_CONTEXT_SIZE, gpu_cache_line_size);
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 13090ff6db7b5..9d539f5f80158 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0 or MIT
>  /* Copyright 2025 ARM Limited. All rights reserved. */
>  
> +#include <linux/bits.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/platform_device.h>
>  
> @@ -74,6 +75,29 @@ static struct panthor_hw panthor_hw_arch_v14 = {
>  	},
>  };
>  
> +static struct panthor_hw panthor_hw_arch_v15 = {
> +	.ops = {
> +		.soft_reset = panthor_pwr_reset_soft,
> +		.l2_power_off = panthor_pwr_l2_power_off,
> +		.l2_power_on = panthor_pwr_l2_power_on,
> +	},
> +	.regs = {
> +		.gpu_control = {
> +			.offset = 0x3000,
> +		},
> +		.mcu_control = {
> +			.offset = 0x3100,
> +		},
> +		.pwr_control = {
> +			.offset = 0x3800,
> +		},
> +		.mmu_as_control = {
> +			.offset = 0x2800,
> +			.stride = 0x80,
> +		},
> +	},
> +};
> +
>  static struct panthor_hw_entry panthor_hw_match[] = {
>  	{
>  		.arch_min = 10,
> @@ -85,6 +109,11 @@ static struct panthor_hw_entry panthor_hw_match[] = {
>  		.arch_max = 14,
>  		.hwdev = &panthor_hw_arch_v14,
>  	},
> +	{
> +		.arch_min = 15,
> +		.arch_max = 15,
> +		.hwdev = &panthor_hw_arch_v15,
> +	}
>  };
>  
>  static int panthor_hw_set_power_tracing(struct device *dev, void *data)
> @@ -152,8 +181,11 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
>  						gpu_id->prod_major);
>  	const bool ray_intersection = !!(ptdev->gpu_info.gpu_features &
>  					 GPU_FEATURES_RAY_INTERSECTION);
> +	const bool neural_present = !!(ptdev->gpu_info.gpu_features &
> +				       GPU_FEATURES_NX);
>  	const u8 shader_core_count = hweight64(ptdev->gpu_info.shader_present);
>  
> +
>  	switch (product_id) {
>  	case GPU_PROD_ID_MAKE(10, 2):
>  		return "Mali-G710";
> @@ -196,6 +228,18 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
>  		return "Mali-G1-Premium";
>  	case GPU_PROD_ID_MAKE(14, 3):
>  		return "Mali-G1-Pro";
> +	case GPU_PROD_ID_MAKE(15, 0):
> +		return "Mali-G2-Ultra-NX";
> +	case GPU_PROD_ID_MAKE(15, 1):
> +		if (neural_present)
> +			return "Mali-G2-Premium-NX";
> +
> +		return "Mali-G2-Premium";
> +	case GPU_PROD_ID_MAKE(15, 3):
> +		if (neural_present)
> +			return "Mali-G2-Pro-NX";
> +
> +		return "Mali-G2-Pro";
>  	}
>  
>  	return "(Unknown Mali GPU)";
> @@ -219,7 +263,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
>  	return 0;
>  }
>  
> -static int panthor_gpu_info_init(struct panthor_device *ptdev)
> +static void panthor_gpu_info_v10_init(struct panthor_device *ptdev)
>  {
>  	unsigned int i;
>  
> @@ -260,12 +304,55 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
>  		ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
>  		ptdev->gpu_info.l2_present = gpu_read64(gpu_iomem, GPU_L2_PRESENT);
>  	}
> +}
> +
> +static void panthor_gpu_info_v15_init(struct panthor_device *ptdev)
> +{
> +	void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
> +	u64 texture_features;
> +
> +	ptdev->gpu_info.gpu_rev_wide = gpu_read64(ptdev->iomem, DISCOVER_REVIDR);
> +	ptdev->gpu_info.l2_features_wide = gpu_read64(ptdev->iomem, DISCOVER_L2_FEATURES);
> +
> +	texture_features = gpu_read64(ptdev->iomem, DISCOVER_TEXTURE_FEATURES);
> +	ptdev->gpu_info.texture_features[0] = lower_32_bits(texture_features);
> +	ptdev->gpu_info.texture_features[1] = upper_32_bits(texture_features);
> +
> +	ptdev->gpu_info.thread_features = gpu_read(ptdev->iomem, DISCOVER_THREAD_FEATURES);
> +	ptdev->gpu_info.max_threads = gpu_read(ptdev->iomem, DISCOVER_THREAD_MAX_THREADS);
> +	ptdev->gpu_info.thread_num_active_granularity =
> +		gpu_read(ptdev->iomem, DISCOVER_THREAD_NUM_ACTIVE_GRANULARITY);
> +
> +	/* The upper 32-bits of following registers do not contain any information (yet) */
> +	ptdev->gpu_info.gpu_features = gpu_read64(ptdev->iomem, DISCOVER_GPU_FEATURES);
> +	ptdev->gpu_info.mem_features = gpu_read(ptdev->iomem, DISCOVER_MEM_FEATURES);
> +	ptdev->gpu_info.mmu_features = gpu_read(ptdev->iomem, DISCOVER_MMU_FEATURES);
> +	ptdev->gpu_info.coherency_features = gpu_read(ptdev->iomem, DISCOVER_AMBA_FEATURES);
> +	ptdev->gpu_info.tiler_features = gpu_read(ptdev->iomem, DISCOVER_TILER_FEATURES);
> +	ptdev->gpu_info.core_features = gpu_read(ptdev->iomem, DISCOVER_CORE_FEATURES);
> +
> +	/* AS_PRESENT register removed on v15+ create virtual mask from MMU_FEATURES.AS_COUNT */
> +	ptdev->gpu_info.as_present = GENMASK(
> +		MMU_FEATURES_AS_COUNT(ptdev->gpu_info.mmu_features) - 1, 0);
> +
> +	ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
> +	ptdev->gpu_info.tiler_present = gpu_read64(pwr_iomem, PWR_TILER_PRESENT);
> +	ptdev->gpu_info.shader_present = gpu_read64(pwr_iomem, PWR_SHADER_PRESENT);
> +}
> +
> +static int panthor_gpu_info_init(struct panthor_device *ptdev)
> +{
> +	if (panthor_hw_has_gpu_discover(ptdev))
> +		panthor_gpu_info_v15_init(ptdev);
> +	else
> +		panthor_gpu_info_v10_init(ptdev);
>  
>  	return overload_shader_present(ptdev);
>  }
>  
>  static int panthor_hw_info_init(struct panthor_device *ptdev)
>  {
> +	u64 l2_features;
>  	u32 major, minor, status;
>  	int ret;
>  
> @@ -273,18 +360,23 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
>  	if (ret)
>  		return ret;
>  
> +	l2_features = ptdev->gpu_info.l2_features;
> +
>  	major = ptdev->gpu_id.ver_major;
>  	minor = ptdev->gpu_id.ver_minor;
>  	status = ptdev->gpu_id.ver_status;
>  
> +	if (panthor_hw_has_gpu_discover(ptdev))
> +		l2_features = ptdev->gpu_info.l2_features_wide;
> +

You've already used `panthor_hw_get_l2_features()` function in `panthor_heap_ctx_stride()`,
why not use it here a few lines before and remove these lines?

>  	drm_info(&ptdev->base,
>  		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
>  		 get_gpu_model_name(ptdev), ptdev->gpu_id.prod_major,
>  		 major, minor, status);
>  
>  	drm_info(&ptdev->base,
> -		 "Features: L2:%#x Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
> -		 ptdev->gpu_info.l2_features,
> +		 "Features: L2:%#llx Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
> +		 l2_features,
>  		 ptdev->gpu_info.tiler_features,
>  		 ptdev->gpu_info.mem_features,
>  		 ptdev->gpu_info.mmu_features,
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index 68627f0df7f95..48232254fef97 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -88,4 +88,17 @@ static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
>  	return ptdev->gpu_id.arch_major >= 14;
>  }
>  
> +static inline bool panthor_hw_has_gpu_discover(struct panthor_device *ptdev)
> +{
> +	return ptdev->gpu_id.arch_major >= 15;
> +}
> +
> +static inline u64 panthor_hw_get_l2_features(struct panthor_device *ptdev)
> +{
> +	if (panthor_hw_has_gpu_discover(ptdev))
> +		return ptdev->gpu_info.l2_features_wide;
> +
> +	return ptdev->gpu_info.l2_features;
> +}
> +
>  #endif /* __PANTHOR_HW_H__ */
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index 843a0b40e1d36..5c75dda5f0ae7 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -371,8 +371,8 @@ struct drm_panthor_gpu_info {
>  	/** @core_features: Used to discriminate core variants when they exist. */
>  	__u32 core_features;
>  
> -	/** @pad: MBZ. */
> -	__u32 pad;
> +	/** @thread_num_active_granularity: Granularity of number of active threads */
> +	__u32 thread_num_active_granularity;
>  
>  	/** @gpu_features: Bitmask describing supported GPU-wide features */
>  	__u64 gpu_features;
> @@ -389,6 +389,12 @@ struct drm_panthor_gpu_info {
>  #define DRM_PANTHOR_WIDE_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
>  #define DRM_PANTHOR_WIDE_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
>  #define DRM_PANTHOR_WIDE_VERSION_STATUS(x)	((x) & 0xff)
> +
> +	/** @gpu_rev_wide: 64-bit GPU revision for v15 onwards */
> +	__u64 gpu_rev_wide;
> +
> +	/** @l2_features_wide: 64-bit L2_FEATURES for v15 onwards */
> +	__u64 l2_features_wide;
>  };
>  
>  /**
> -- 
> 2.43.0
> 

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu


-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
