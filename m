Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2F4CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5513510EA6E;
	Fri, 12 Jun 2026 16:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="kJQv+zj6";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 67FFD10EA6E
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 16:01:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 371F22BCA;
 Fri, 12 Jun 2026 09:01:17 -0700 (PDT)
Received: from [10.57.28.189] (unknown [10.57.28.189])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A60723FAA1;
 Fri, 12 Jun 2026 09:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781280081; bh=dfqIhHP0F70QqsyabOoPDoOYHwFs5yYg642Fodtjq+Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kJQv+zj6m1OY0N9rmoKuKo4G/RuYy5hN0hUkHpxJdpH4sdOrhnCtDn6ASOpS0t6DC
 gZJ63CFYSiTQlCxgvu62ljeY1p+71qf0wjayE0Pbv3BerHnINHxmam4Uf9wniH4pYf
 ta6lp8YelZ3opHMnKMk4qAlLH0Fi8s90pzuzeGeI=
Message-ID: <cbf0e5c1-7284-4a94-9d1d-09412e75dafa@arm.com>
Date: Fri, 12 Jun 2026 17:01:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/18] drm/panthor: Add Mali v15 hardware support
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-8-karunika.choo@arm.com>
 <99c5c33c-3c68-49a8-b827-c3fa210e8b13@arm.com>
 <4da19dca-ce00-4888-8f9d-2400e2617a29@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <4da19dca-ce00-4888-8f9d-2400e2617a29@arm.com>
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

On 11/06/2026 17:04, Karunika Choo wrote:
> On 11/06/2026 16:18, Steven Price wrote:
>> On 28/05/2026 16:05, Karunika Choo wrote:
>>> Add the panthor hardware description for Mali v15 GPUs and hook it into
>>> device matching.
>>>
>>> This includes the v15 register map and product identification needed to
>>> populate the GPU information exposed by the driver and its uAPI.
>>>
>>> Add compatibility string for v15 GPUs.
>>>
>>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
>>> ---
>>>  drivers/gpu/drm/panthor/panthor_drv.c         |  1 +
>>>  drivers/gpu/drm/panthor/panthor_fw.c          |  1 +
>>>  .../drm/panthor/panthor_gpu_discover_regs.h   | 25 ++++++
>>>  drivers/gpu/drm/panthor/panthor_heap.c        |  3 +-
>>>  drivers/gpu/drm/panthor/panthor_hw.c          | 81 ++++++++++++++++++-
>>>  drivers/gpu/drm/panthor/panthor_hw.h          | 13 +++
>>>  include/uapi/drm/panthor_drm.h                | 10 ++-
>>>  7 files changed, 128 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
>>> index e8dc4096c1d2..21644a60c8e4 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_drv.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
>>> @@ -1875,6 +1875,7 @@ static const struct of_device_id dt_match[] = {
>>>  	{ .compatible = "mediatek,mt8196-mali", .data = &soc_data_mediatek_mt8196, },
>>>  	{ .compatible = "rockchip,rk3588-mali" },
>>>  	{ .compatible = "arm,mali-valhall-csf" },
>>> +	{ .compatible = "arm,mali-gen5-am" },
>>
>> Just a heads up: a new DT compatible should have a binding document
>> describing it. So this can't be merged until the DT bindings change is
>> agreed.
>>
> 
> In this case are we leaning more towards a new arm,mali-gen5-am.yaml
> or is it preferrable to update arm/mali-valhall-csf.yaml instead?

You've probably got a better idea of how similar it is to
mali-valhall-csf.yaml. I don't have a preference as to how it's
documented - although others might. But we get into issues if the
bindings aren't agreed before the code using them is merged.

Thanks,
Steve

>>>  	{}
>>>  };
>>>  MODULE_DEVICE_TABLE(of, dt_match);
>>> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
>>> index f6381f5f236f..e2a511b741f4 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_fw.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
>>> @@ -1529,3 +1529,4 @@ MODULE_FIRMWARE("arm/mali/arch11.8/mali_csffw.bin");
>>>  MODULE_FIRMWARE("arm/mali/arch12.8/mali_csffw.bin");
>>>  MODULE_FIRMWARE("arm/mali/arch13.8/mali_csffw.bin");
>>>  MODULE_FIRMWARE("arm/mali/arch14.8/mali_csffw.bin");
>>> +MODULE_FIRMWARE("arm/mali/arch15.8/mali_csffw.bin");
>>> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
>>> index 54bb104902ee..9c64676dc35a 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
>>> +++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
>>> @@ -14,4 +14,29 @@
>>>  #define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK(15, 8)) >> 8)
>>>  #define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK(7, 0))
>>>  
>>> +#define DISCOVER_REVIDR					0x8
>>> +#define DISCOVER_GPU_FEATURES				0x20
>>> +#define   GPU_FEATURES_VARIABLE_RATE_SHADING		BIT(0)
>>> +#define   GPU_FEATURES_SIMD_STATE			BIT(1)
>>> +#define   GPU_FEATURES_CROSS_STREAM_SYNC		BIT(3)
>>> +#define   GPU_FEATURES_NX				BIT(4)
>>> +#define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
>>> +#define   GPU_FEATURES_LD_LEA_TENSOR_INSTRUCTIONS	BIT(6)
>>> +#define DISCOVER_MCU_FEATURES				0x40
>>> +#define DISCOVER_PRFCNT_FEATURES			0x50
>>> +#define   PRFCNT_FEATURES_COUNTER_BLOCK_SIZE(x)		(((x) & GENMASK(7, 0)) << 8)
>>> +#define DISCOVER_DOORBELL_FEATURES			0x60
>>> +#define DISCOVER_MEM_FEATURES				0x100
>>> +#define DISCOVER_MMU_FEATURES				0x108
>>> +#define   MMU_FEATURES_AS_COUNT(x)			(((x) & GENMASK(23, 16)) >> 16)
>>> +#define DISCOVER_AMBA_FEATURES				0x120
>>> +
>>> +#define DISCOVER_L2_FEATURES				0x128
>>> +#define DISCOVER_TILER_FEATURES				0x200
>>> +#define DISCOVER_CORE_FEATURES				0x300
>>> +#define DISCOVER_THREAD_FEATURES			0x320
>>> +#define DISCOVER_THREAD_MAX_THREADS			0x330
>>> +#define DISCOVER_THREAD_NUM_ACTIVE_GRANULARITY		0x334
>>> +#define DISCOVER_TEXTURE_FEATURES			0x360
>>> +
>>>  #endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
>>> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
>>> index 99311abdf1e9..afb7d68abc87 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_heap.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_heap.c
>>> @@ -11,6 +11,7 @@
>>>  #include "panthor_gem.h"
>>>  #include "panthor_gpu_regs.h"
>>>  #include "panthor_heap.h"
>>> +#include "panthor_hw.h"
>>>  #include "panthor_mmu.h"
>>>  
>>>  /*
>>> @@ -105,7 +106,7 @@ struct panthor_heap_pool {
>>>  
>>>  static int panthor_heap_ctx_stride(struct panthor_device *ptdev)
>>>  {
>>> -	u32 l2_features = ptdev->gpu_info.l2_features;
>>> +	u64 l2_features = panthor_hw_get_l2_features(ptdev);
>>>  	u32 gpu_cache_line_size = GPU_L2_FEATURES_LINE_SIZE(l2_features);
>>>  
>>>  	return ALIGN(HEAP_CONTEXT_SIZE, gpu_cache_line_size);
>>> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
>>> index e677f1a8f488..52271fb9db52 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_hw.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
>>> @@ -65,6 +65,23 @@ static struct panthor_hw panthor_hw_arch_v14 = {
>>>  	},
>>>  };
>>>  
>>> +static struct panthor_hw panthor_hw_arch_v15 = {
>>> +	.ops = {
>>> +		.soft_reset = panthor_pwr_reset_soft,
>>> +		.l2_power_off = panthor_pwr_l2_power_off,
>>> +		.l2_power_on = panthor_pwr_l2_power_on,
>>> +	},
>>> +	.map = {
>>> +		.gpu_control_base = 0x3000,
>>> +		.pwr_control_base = 0x3800,
>>> +		.mcu_control_base = 0x3100,
>>> +		.mmu_as = {
>>> +			.base = 0x2800,
>>> +			.stride = 0x80,
>>> +		},
>>> +	},
>>> +};
>>> +
>>>  static struct panthor_hw_entry panthor_hw_match[] = {
>>>  	{
>>>  		.arch_min = 10,
>>> @@ -76,6 +93,11 @@ static struct panthor_hw_entry panthor_hw_match[] = {
>>>  		.arch_max = 14,
>>>  		.hwdev = &panthor_hw_arch_v14,
>>>  	},
>>> +	{
>>> +		.arch_min = 15,
>>> +		.arch_max = 15,
>>> +		.hwdev = &panthor_hw_arch_v15,
>>> +	}
>>>  };
>>>  
>>>  static int panthor_hw_set_power_tracing(struct device *dev, void *data)
>>> @@ -187,6 +209,12 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
>>>  		return "Mali-G1-Premium";
>>>  	case GPU_PROD_ID_MAKE(14, 3):
>>>  		return "Mali-G1-Pro";
>>> +	case GPU_PROD_ID_MAKE(15, 0):
>>> +		return "Mali-G2-Ultra";
>>> +	case GPU_PROD_ID_MAKE(15, 1):
>>> +		return "Mali-G2-Premium";
>>> +	case GPU_PROD_ID_MAKE(15, 3):
>>> +		return "Mali-G2-Pro";
>>>  	}
>>>  
>>>  	return "(Unknown Mali GPU)";
>>> @@ -210,7 +238,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
>>>  	return 0;
>>>  }
>>>  
>>> -static int panthor_gpu_info_init(struct panthor_device *ptdev)
>>> +static void panthor_gpu_info_v10_init(struct panthor_device *ptdev)
>>>  {
>>>  	unsigned int i;
>>>  
>>> @@ -251,12 +279,56 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
>>>  		ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
>>>  		ptdev->gpu_info.l2_present = gpu_read64(gpu_iomem, GPU_L2_PRESENT);
>>>  	}
>>> +}
>>> +
>>> +static void panthor_gpu_info_v15_init(struct panthor_device *ptdev)
>>> +{
>>> +	void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->map.pwr_control_base;
>>> +	u64 texture_features;
>>> +
>>> +	ptdev->gpu_info.gpu_rev_wide = gpu_read64(ptdev->iomem, DISCOVER_REVIDR);
>>> +	ptdev->gpu_info.l2_features_wide = gpu_read64(ptdev->iomem, DISCOVER_L2_FEATURES);
>>> +
>>> +	texture_features = gpu_read64(ptdev->iomem, DISCOVER_TEXTURE_FEATURES);
>>> +	ptdev->gpu_info.texture_features[0] = lower_32_bits(texture_features);
>>> +	ptdev->gpu_info.texture_features[1] = upper_32_bits(texture_features);
>>> +
>>> +	ptdev->gpu_info.thread_features = gpu_read(ptdev->iomem, DISCOVER_THREAD_FEATURES);
>>> +	ptdev->gpu_info.max_threads = gpu_read(ptdev->iomem, DISCOVER_THREAD_MAX_THREADS);
>>> +	ptdev->gpu_info.thread_num_active_granularity =
>>> +		gpu_read(ptdev->iomem, DISCOVER_THREAD_NUM_ACTIVE_GRANULARITY);
>>> +
>>> +	ptdev->gpu_info.gpu_features = gpu_read64(ptdev->iomem, DISCOVER_GPU_FEATURES);
>>> +
>>> +	/* The following _HI registers do not contain any information (yet) */
>>
>> This is a little confusing as a comment - there are no "_HI" registers
>> mentioned. I think this would be better reworded as "32 bit reads are
>> used as the HI part of the 64 bit register does not contian any
>> information (yet)" (or similar).
> 
> ACK.
> 
>> Or alternatively you could just upgrade these to 64 bit and be done with
>> it ;)
>>
>>> +	ptdev->gpu_info.mem_features = gpu_read(ptdev->iomem, DISCOVER_MEM_FEATURES);
>>> +	ptdev->gpu_info.mmu_features = gpu_read(ptdev->iomem, DISCOVER_MMU_FEATURES);
>>> +	ptdev->gpu_info.coherency_features = gpu_read(ptdev->iomem, DISCOVER_AMBA_FEATURES);
>>> +	ptdev->gpu_info.tiler_features = gpu_read(ptdev->iomem, DISCOVER_TILER_FEATURES);
>>> +	ptdev->gpu_info.core_features = gpu_read(ptdev->iomem, DISCOVER_CORE_FEATURES);
>>> +
>>> +	/* AS_PRESENT register removed on v15+ create virtual mask from MMU_FEATURES.AS_COUNT */
>>> +	ptdev->gpu_info.as_present =
>>> +		(1U << MMU_FEATURES_AS_COUNT(ptdev->gpu_info.mmu_features)) - 1;
>>
>> This might be better expressed using GENMASK:
>>
>> GENMASK(MMU_FEATURES_AS_COUNT(ptdev->gpu_info.mmu_features) - 1, 0)
>>
> 
> ACK.
> 
> Kind regards,
> Karunika
> 
>>> +
>>> +	ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
>>> +	ptdev->gpu_info.tiler_present = gpu_read64(pwr_iomem, PWR_TILER_PRESENT);
>>> +	ptdev->gpu_info.shader_present = gpu_read64(pwr_iomem, PWR_SHADER_PRESENT);
>>> +}
>>> +
>>> +static int panthor_gpu_info_init(struct panthor_device *ptdev)
>>> +{
>>> +	if (panthor_hw_has_gpu_discover(ptdev))
>>> +		panthor_gpu_info_v15_init(ptdev);
>>> +	else
>>> +		panthor_gpu_info_v10_init(ptdev);
>>>  
>>>  	return overload_shader_present(ptdev);
>>>  }
>>>  
>>>  static int panthor_hw_info_init(struct panthor_device *ptdev)
>>>  {
>>> +	u64 l2_features = ptdev->gpu_info.l2_features;
>>>  	u32 major, minor, status;
>>>  	int ret;
>>>  
>>> @@ -268,14 +340,17 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
>>>  	minor = ptdev->gpu_id.ver.minor;
>>>  	status = ptdev->gpu_id.ver.status;
>>>  
>>> +	if (panthor_hw_has_gpu_discover(ptdev))
>>> +		l2_features = ptdev->gpu_info.l2_features_wide;
>>> +
>>>  	drm_info(&ptdev->base,
>>>  		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
>>>  		 get_gpu_model_name(ptdev), ptdev->gpu_id.prod_major,
>>>  		 major, minor, status);
>>>  
>>>  	drm_info(&ptdev->base,
>>> -		 "Features: L2:%#x Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
>>> -		 ptdev->gpu_info.l2_features,
>>> +		 "Features: L2:%#llx Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
>>> +		 l2_features,
>>>  		 ptdev->gpu_info.tiler_features,
>>>  		 ptdev->gpu_info.mem_features,
>>>  		 ptdev->gpu_info.mmu_features,
>>> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
>>> index 0ae11b78c77e..1b2678ea00db 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_hw.h
>>> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
>>> @@ -83,4 +83,17 @@ static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
>>>  	return ptdev->gpu_id.arch.major >= 14;
>>>  }
>>>  
>>> +static inline bool panthor_hw_has_gpu_discover(struct panthor_device *ptdev)
>>> +{
>>> +	return ptdev->gpu_id.arch.major >= 15;
>>> +}
>>> +
>>> +static inline u64 panthor_hw_get_l2_features(struct panthor_device *ptdev)
>>> +{
>>> +	if (panthor_hw_has_gpu_discover(ptdev))
>>> +		return ptdev->gpu_info.l2_features_wide;
>>> +
>>> +	return ptdev->gpu_info.l2_features;
>>> +}
>>> +
>>>  #endif /* __PANTHOR_HW_H__ */
>>> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
>>> index 04fc9f133152..2ecc50eade27 100644
>>> --- a/include/uapi/drm/panthor_drm.h
>>> +++ b/include/uapi/drm/panthor_drm.h
>>> @@ -368,8 +368,8 @@ struct drm_panthor_gpu_info {
>>>  	/** @core_features: Used to discriminate core variants when they exist. */
>>>  	__u32 core_features;
>>>  
>>> -	/** @pad: MBZ. */
>>> -	__u32 pad;
>>> +	/** @thread_num_active_granularity: Granularity of number of active threads */
>>> +	__u32 thread_num_active_granularity;
>>>  
>>>  	/** @gpu_features: Bitmask describing supported GPU-wide features */
>>>  	__u64 gpu_features;
>>> @@ -383,6 +383,12 @@ struct drm_panthor_gpu_info {
>>>  #define DRM_PANTHOR_WIDE_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
>>>  #define DRM_PANTHOR_WIDE_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
>>>  #define DRM_PANTHOR_WIDE_VERSION_STATUS(x)	((x) & 0xff)
>>> +
>>> +	/** @gpu_rev_wide: 64-bit GPU revision for v15 onwards */
>>> +	__u64 gpu_rev_wide;
>>> +
>>> +	/** @l2_features_wide: 64-bit L2_FEATURES for v15 onwards */
>>> +	__u64 l2_features_wide;
>>>  };
>>>  
>>>  /**
>>
> 

