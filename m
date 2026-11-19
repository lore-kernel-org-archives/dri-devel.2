Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D9606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=gqrxGraY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62EF010E0C6;
	Thu, 19 Nov 2026 16:06:22 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC09B10E0C6
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795104375;
 bh=sAcMG9XBl3fij982NWy6C6FsqfiPI7EIZtKznKdWRfA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gqrxGraYLN3huMo+h81K7bNy+IP/VdVzf738C5NJ23L4RS7Fg1gvbUbTeQ6UcwAzv
 5HwbX7xSiQujuDGHr9ALg186TafNI4LH8tPAIgoxMFFWbfnV3odvY5jI7sPRb9/FBt
 BjSAuRbDC+Z3QQO9VU9kY8TSArzFWkAt+MZTKtlAINCShCLiOPiBNXWnOepudzoTDR
 ISU4RCRqfvhsUfKsHYx8bF+ETBw2zccOLLrrjLaMioWgQspXdNbDgn2eQTgp4eTobH
 M31Z2xMXy2QpkPKc0TJvK9bWv8b0MtcexYJQqVgkDbj6AJ275A8ftNWV92nFRFQGS0
 SuhSdJMFUGLhQ==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DFC6617E0A27;
 Thu, 19 Nov 2026 17:06:14 +0100 (CET)
Date: Thu, 19 Nov 2026 17:06:09 +0100
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
Subject: Re: [PATCH v4 9/9] drm/panthor: Add Mali v15 hardware support
Message-ID: <20261119170609.6953008d@fedora1.home>
In-Reply-To: <20261119154604.2519184-10-karunika.choo@arm.com>
References: <20261119154604.2519184-1-karunika.choo@arm.com>
 <20261119154604.2519184-10-karunika.choo@arm.com>
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

On Thu, 19 Nov 2026 15:45:59 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> Add the panthor hardware description for Mali v15 GPUs and hook it into
> device matching.
> 
> This includes the v15 register map and product identification needed to
> populate the GPU information exposed by the driver and its uAPI, as well
> as add compatibility string for v15 GPUs.
> 
> Mali v15 also exposes a 64-bit GPU_ID register with a different field
> layout from earlier GPUs. Add the register definitions and decoding
> helpers for the new format, read GPU_ID_WIDE when the compatibility
> value indicates a v15 GPU, and populate both the cached GPU_ID fields
> and the uAPI gpu_id_wide field.
> 
> Bump drm minor to 10.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
> v4:
> - squashed 64-bit GPU_ID decoding into this patch. Resetting R-bs as
>   a result.
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
> 64-bit GPU_ID:
> v3:
> - Fix the missing blank line after declarations in GPU_ID decoding.
> v2:
> - Picked up R-b from Liviu.
> - Rename the register macro from GPU_WIDE_ID to GPU_ID_WIDE.
> - Rename the uAPI field from gpu_wide_id to gpu_id_wide.
> - Print the upper 32 bits of GPU_ID_WIDE as the logged 'id' for v15 and
>   later GPUs. Keep the existing output for earlier GPUs. Continuation
>   fix for previous sashiko comment.
> - Link: https://lore.kernel.org/all/20260922205659.3C4F21F000FF@smtp.kernel.org/
> v1:
> - Decode selected GPU_ID format after checking compatibility value.
> - Document GPU_DISCOVER and GPU_CONTROL register offset differences
>   between GPUs.
> - Fix mask generation in panthor_gpu_discover_regs.h
> 
>  drivers/gpu/drm/panthor/panthor_drv.c         |   9 +-
>  drivers/gpu/drm/panthor/panthor_fw.c          |   1 +
>  drivers/gpu/drm/panthor/panthor_gpu.c         |   3 +-
>  .../drm/panthor/panthor_gpu_discover_regs.h   |  42 +++++
>  drivers/gpu/drm/panthor/panthor_heap.c        |   3 +-
>  drivers/gpu/drm/panthor/panthor_hw.c          | 159 ++++++++++++++++--
>  drivers/gpu/drm/panthor/panthor_hw.h          |  13 ++
>  include/uapi/drm/panthor_drm.h                |  23 ++-
>  8 files changed, 230 insertions(+), 23 deletions(-)
>  create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index b4d3d339b04b4..94320799d5d75 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1788,6 +1788,8 @@ static void panthor_debugfs_init(struct drm_minor *minor)
>   * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
>   * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
>   *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
> + * - 1.10 - adds thread_num_active_granularity, gpu_rev_wide, l2_features_wide,
> + *          and gpu_id_wide to drm_panthor_gpu_info
>   */
>  static const struct drm_driver panthor_drm_driver = {
>  	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
> @@ -1801,7 +1803,7 @@ static const struct drm_driver panthor_drm_driver = {
>  	.name = "panthor",
>  	.desc = "Panthor DRM driver",
>  	.major = 1,
> -	.minor = 9,
> +	.minor = 10,
>  
>  	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
>  	.gem_prime_import = panthor_gem_prime_import,
> @@ -1880,10 +1882,15 @@ static const struct panthor_soc_data soc_data_mediatek_mt8196 = {
>  	.asn_hash = { 0xb, 0xe, 0x0, },
>  };
>  
> +static const struct panthor_soc_data soc_data_gen5_am = {
> +	.devfreq_disabled = true,
> +};
> +
>  static const struct of_device_id dt_match[] = {
>  	{ .compatible = "mediatek,mt8196-mali", .data = &soc_data_mediatek_mt8196, },
>  	{ .compatible = "rockchip,rk3588-mali" },
>  	{ .compatible = "arm,mali-valhall-csf" },
> +	{ .compatible = "arm,mali-gen5-am", .data = &soc_data_gen5_am, },
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
> new file mode 100644
> index 0000000000000..05e90950ec6ad
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 or MIT */
> +/* Copyright 2026 ARM Limited. All rights reserved. */
> +
> +#ifndef __PANTHOR_GPU_DISCOVER_REGS_H__
> +#define __PANTHOR_GPU_DISCOVER_REGS_H__
> +
> +#include <linux/bits.h>
> +
> +#define GPU_ID_WIDE					0x0
> +#define   GPU_WIDE_COMPAT				0xF
> +#define   GPU_WIDE_ARCH_MAJOR(x)			(((x) & GENMASK_U64(63, 56)) >> 56)
> +#define   GPU_WIDE_ARCH_MINOR(x)			(((x) & GENMASK_U64(55, 48)) >> 48)
> +#define   GPU_WIDE_ARCH_REV(x)				(((x) & GENMASK_U64(47, 40)) >> 40)
> +#define   GPU_WIDE_PROD_MAJOR(x)			(((x) & GENMASK_U64(39, 32)) >> 32)
> +#define   GPU_WIDE_VER_MAJOR(x)				(((x) & GENMASK_U64(23, 16)) >> 16)
> +#define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK_U64(15, 8)) >> 8)
> +#define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK_U64(7, 0))
> +
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
> +#endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
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
> index 593bf6743d6df..fc81fabbe62fd 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -1,13 +1,16 @@
>  // SPDX-License-Identifier: GPL-2.0 or MIT
>  /* Copyright 2025 ARM Limited. All rights reserved. */
>  
> +#include <linux/bits.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/wordpart.h>
>  
>  #include <drm/drm_print.h>
>  
>  #include "panthor_device.h"
>  #include "panthor_gpu.h"
> +#include "panthor_gpu_discover_regs.h"
>  #include "panthor_gpu_regs.h"
>  #include "panthor_hw.h"
>  #include "panthor_pwr.h"
> @@ -73,6 +76,29 @@ static struct panthor_hw panthor_hw_arch_v14 = {
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
> @@ -84,6 +110,11 @@ static struct panthor_hw_entry panthor_hw_match[] = {
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
> @@ -151,8 +182,11 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
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
> @@ -195,6 +229,18 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
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
> @@ -218,7 +264,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
>  	return 0;
>  }
>  
> -static int panthor_gpu_info_init(struct panthor_device *ptdev)
> +static void panthor_gpu_info_v10_init(struct panthor_device *ptdev)
>  {
>  	unsigned int i;
>  
> @@ -259,31 +305,86 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
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
> -	u32 major, minor, status;
> +	u64 l2_features;
> +	u32 prod_id, major, minor, status;
>  	int ret;
>  
>  	ret = panthor_gpu_info_init(ptdev);
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * The logged 'id' contains four 4-bit architecture and product fields
> +	 * in pre-v15 GPUs. In v15+ GPUs, this is now four 8-bit fields.
> +	 * Preserve the pre-v15 format for compatibility. Tools decoding these
> +	 * fields must handle the wider format for v15+ GPUs.
> +	 */
> +	if (ptdev->gpu_id.arch_major < 15)
> +		prod_id = upper_16_bits(ptdev->gpu_info.gpu_id);
> +	else
> +		prod_id = upper_32_bits(ptdev->gpu_info.gpu_id_wide);
> +
>  	major = ptdev->gpu_id.ver_major;
>  	minor = ptdev->gpu_id.ver_minor;
>  	status = ptdev->gpu_id.ver_status;
> +	l2_features = panthor_hw_get_l2_features(ptdev);
>  
> -	drm_info(&ptdev->base,
> -		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
> -		 get_gpu_model_name(ptdev), ptdev->gpu_info.gpu_id >> 16,
> -		 major, minor, status);
> +	drm_info(&ptdev->base, "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
> +		 get_gpu_model_name(ptdev), prod_id, major, minor, status);
>  
>  	drm_info(&ptdev->base,
> -		 "Features: L2:%#x Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
> -		 ptdev->gpu_info.l2_features,
> +		 "Features: L2:%#llx Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
> +		 l2_features,
>  		 ptdev->gpu_info.tiler_features,
>  		 ptdev->gpu_info.mem_features,
>  		 ptdev->gpu_info.mmu_features,
> @@ -323,18 +424,42 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
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
> +		u64 gpu_id64 = gpu_read64(discover, GPU_ID_WIDE);
> +
> +		if (!gpu_id64)
> +			return -ENXIO;
> +
> +		ptdev->gpu_info.gpu_id_wide = gpu_id64;
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
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index f93a6b16df2af..8d61a1099aa5e 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -105,4 +105,17 @@ static inline bool panthor_hw_is_devfreq_disabled(struct panthor_device *ptdev)
>  	return data->devfreq_disabled;
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
> index a2ff0f4ec6915..da9f8f82413cf 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -371,11 +371,30 @@ struct drm_panthor_gpu_info {
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
> +
> +	/**
> +	 * @gpu_id_wide: 64-bit GPU ID for v15 and later GPUs. @gpu_id is 0 when
> +	 * this is populated.
> +	 */
> +	__u64 gpu_id_wide;
> +#define DRM_PANTHOR_WIDE_ARCH_MAJOR(x)		(((x) >> 56) & 0xff)
> +#define DRM_PANTHOR_WIDE_ARCH_MINOR(x)		(((x) >> 48) & 0xff)
> +#define DRM_PANTHOR_WIDE_ARCH_REV(x)		(((x) >> 40) & 0xff)
> +#define DRM_PANTHOR_WIDE_PRODUCT_MAJOR(x)	(((x) >> 32) & 0xff)
> +#define DRM_PANTHOR_WIDE_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
> +#define DRM_PANTHOR_WIDE_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
> +#define DRM_PANTHOR_WIDE_VERSION_STATUS(x)	((x) & 0xff)
> +
> +	/** @gpu_rev_wide: 64-bit GPU revision for v15 onwards */
> +	__u64 gpu_rev_wide;
> +
> +	/** @l2_features_wide: 64-bit L2_FEATURES for v15 onwards */
> +	__u64 l2_features_wide;
>  };
>  
>  /**

