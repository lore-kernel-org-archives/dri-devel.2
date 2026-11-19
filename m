Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF76606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=SXE8ySJO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02AF711203E;
	Thu, 19 Nov 2026 08:08:30 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 792D111203E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795075702;
 bh=lXGlfqeOeEiKbgEdkhnKDBf3MRfc8btYnXq39yWyffI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SXE8ySJOEs0VKTmt54JahJpxSzsvu5Azyn/XM1U4Xg6/WXch8p6LrvR6R/uuB9tJd
 6jGrrCxC2aGSeRne7/6yqikpTgX+QVk6Ha7sinKoS1Om4G0Qr1+JyrGYqW/IMNmSpm
 6ZKgl6N/lcL/4D7LGs17PNILrAoURwXs8gnt7qypfv3zGzCqsTtt8HtgepamPjurqV
 4NeabIfepFMxlKbVYXyOBJg+wrDSkTGmqMXHZ6z47XizvtGrZgl0QSDhO34fm4DSDx
 YgyiSL/SQGme4QIRDLMnib2zZBriSHNo1qUY7wJPKbXcFr4lGQ3Wiolp0zLQqlFj+a
 +LQ+Yl/guv8FQ==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 83FDA17E052F;
 Thu, 19 Nov 2026 09:08:21 +0100 (CET)
Date: Thu, 19 Nov 2026 09:08:16 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>, Lukas
 Zapolskas <lukas.zapolskas@arm.com>, Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 09/10] drm/panthor: Add Mali v15 hardware support
Message-ID: <20261119090816.3eb35742@fedora1.home>
In-Reply-To: <20261118175332.519657-10-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
 <20261118175332.519657-10-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 17:53:25 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> Add the panthor hardware description for Mali v15 GPUs and hook it into
> device matching.
> 
> This includes the v15 register map and product identification needed to
> populate the GPU information exposed by the driver and its uAPI.
> 
> Add compatibility string for v15 GPUs and bump drm minor to 10.
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Just one comment: I wonder if patch 5 (drm/panthor: Add 64-bit GPU_ID
decoding for v15 GPUs) shouldn't be squashed in this commit, since
that's were you introduce all the v15 specific-stuff.

> ---
> v2:
> - check as_count is non-zero before generating as_present mask per
>   sashiko's comment.
> - Link: https://lore.kernel.org/all/20260922205812.C473B1F000FF@smtp.kernel.org/
> - clean up l2_features value assignment.
> - removed duplicated GPU_FEATURES macro definitions
> - Picked up R-b from Liviu
> v1:
> - make COHERENCY_FEATURES register read use cached gpu_info values.
> - Added Mali-G2 name variants and NX aware model identification.
> - fix premature reading of l2_features gpu_info field during
>   panthor_hw_info_init().
> - build as_present using GENMASK.
> 
>  drivers/gpu/drm/panthor/panthor_drv.c         |  5 +-
>  drivers/gpu/drm/panthor/panthor_fw.c          |  1 +
>  drivers/gpu/drm/panthor/panthor_gpu.c         |  3 +-
>  .../drm/panthor/panthor_gpu_discover_regs.h   | 23 +++++
>  drivers/gpu/drm/panthor/panthor_heap.c        |  3 +-
>  drivers/gpu/drm/panthor/panthor_hw.c          | 96 ++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_hw.h          | 13 +++
>  include/uapi/drm/panthor_drm.h                | 10 +-
>  8 files changed, 145 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index dc8d0191aef42..e9b71ff5ee53f 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1785,6 +1785,8 @@ static void panthor_debugfs_init(struct drm_minor *minor)
>   * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
>   * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
>   *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
> + * - 1.10 - adds thread_num_active_granularity, gpu_rev_wide, l2_features_wide,
> + *          and gpu_id_wide to drm_panthor_gpu_info
>   */
>  static const struct drm_driver panthor_drm_driver = {
>  	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
> @@ -1798,7 +1800,7 @@ static const struct drm_driver panthor_drm_driver = {
>  	.name = "panthor",
>  	.desc = "Panthor DRM driver",
>  	.major = 1,
> -	.minor = 9,
> +	.minor = 10,
>  
>  	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
>  	.gem_prime_import = panthor_gem_prime_import,
> @@ -1881,6 +1883,7 @@ static const struct of_device_id dt_match[] = {
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
> index ab54119314da0..2e1b00e86cdea 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -503,8 +503,7 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
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
> index 6896c263f76b6..05e90950ec6ad 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
> @@ -16,4 +16,27 @@
>  #define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK_U64(15, 8)) >> 8)
>  #define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK_U64(7, 0))
>  
> +#define DISCOVER_REVIDR					0x8
> +#define DISCOVER_GPU_FEATURES				0x20
> +#define   GPU_FEATURES_VARIABLE_RATE_SHADING		BIT(0)
> +#define   GPU_FEATURES_SIMD_STATE			BIT(1)
> +#define   GPU_FEATURES_CROSS_STREAM_SYNC		BIT(3)
> +#define   GPU_FEATURES_LD_LEA_TENSOR_INSTRUCTIONS	BIT(6)
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
> index 6a8645bda1e7d..fc81fabbe62fd 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0 or MIT
>  /* Copyright 2025 ARM Limited. All rights reserved. */
>  
> +#include <linux/bits.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/wordpart.h>
> @@ -75,6 +76,29 @@ static struct panthor_hw panthor_hw_arch_v14 = {
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
> @@ -86,6 +110,11 @@ static struct panthor_hw_entry panthor_hw_match[] = {
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
> @@ -153,8 +182,11 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
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
> @@ -197,6 +229,18 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
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
> @@ -220,7 +264,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
>  	return 0;
>  }
>  
> -static int panthor_gpu_info_init(struct panthor_device *ptdev)
> +static void panthor_gpu_info_v10_init(struct panthor_device *ptdev)
>  {
>  	unsigned int i;
>  
> @@ -261,12 +305,57 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
>  		ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
>  		ptdev->gpu_info.l2_present = gpu_read64(gpu_iomem, GPU_L2_PRESENT);
>  	}
> +}
> +
> +static void panthor_gpu_info_v15_init(struct panthor_device *ptdev)
> +{
> +	void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
> +	u64 texture_features;
> +	u32 as_count;
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
> +	as_count = MMU_FEATURES_AS_COUNT(ptdev->gpu_info.mmu_features);
> +	if (as_count)
> +		ptdev->gpu_info.as_present = GENMASK(as_count - 1, 0);
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
>  	u32 prod_id, major, minor, status;
>  	int ret;
>  
> @@ -288,13 +377,14 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
>  	major = ptdev->gpu_id.ver_major;
>  	minor = ptdev->gpu_id.ver_minor;
>  	status = ptdev->gpu_id.ver_status;
> +	l2_features = panthor_hw_get_l2_features(ptdev);
>  
>  	drm_info(&ptdev->base, "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
>  		 get_gpu_model_name(ptdev), prod_id, major, minor, status);
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
> index 4cb603a3acef6..fe31c1088af5a 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -95,4 +95,17 @@ static inline bool panthor_hw_has_neural(struct panthor_device *ptdev)
>  		ptdev->gpu_info.gpu_features & GPU_FEATURES_NX);
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
> index 09b7f7931e4f4..da9f8f82413cf 100644
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

