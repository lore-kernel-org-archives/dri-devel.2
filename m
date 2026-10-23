Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA63606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WPucXX3W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EEB8112B2D;
	Fri, 23 Oct 2026 13:55:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1D8E6112B4F
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:55:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F7481C00
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:54:57 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 5A04A3F673
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792763700; bh=CBAd3D2nS0pV5DyJNQc3hXRDVv+Z6NVGzTQtyO8Q/is=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WPucXX3WhKkmOQm2eVOj9NfQqy0bLGj9km3s56i7x3gTjtJemmEo7Wco+m+yfkQKO
 I1BEJWWMy3mJCDn7CBMssiqoEZsbMreNIrssQbhYnxo1CRJpJbmkOhhy1O7XETeQcI
 eXlEaxMdhECdP8KV2GImXgNXBORWlE4ebgb/UcAA=
Date: Fri, 23 Oct 2026 14:54:49 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Lukas Zapolskas <lukas.zapolskas@arm.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v7 3/8] drm/panthor: Add DEV_QUERY.PERF_INFO handling
Message-ID: <attnKY2jJvfF6X6q@e142607>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
 <20261011-panthor-performance-counters-v7-3-12c32495062f@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261011-panthor-performance-counters-v7-3-12c32495062f@arm.com>
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

On Sun, Oct 11, 2026 at 06:36:50PM +0100, Lukas Zapolskas wrote:
> This change adds the IOCTL to query data about the performance counter
> setup. Some of this data was available via previous DEV_QUERY calls,
> for instance for GPU info, but exposing it via PERF_INFO
> minimizes the overhead of creating a single session to just the one
> aggregate IOCTL, and removes the dependence on architectural details of
> the counter layout.
> 
> This required reading one of the GPU registers, which is exposed via
> a new helper in the gpu header.
> 
> The current handling covers GPUs from the Mali-Gx10 up to and including
> the Mali-G1.
> 
> Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>

Hi,

I can't find a best place to put my thoughts in so I'm going to use this patch to
say how I think I would like the series to look like. The general idea is that
while a series introduces new functionality, each patch should ideally
stand on its own and be able to be committed individually without breaking the
previous version or end up confusing user space.

Therefore, I would merge patch 1/8 and 3/8 into a single bigger patch that at least offers
support for some of the exposed uAPI. Whether that means we should bump the driver's
minor version twice it's up for debate, but at least we don't end up having uAPI
headers with no implementation in case only the first commit in the series is merged.

> ---
>  drivers/gpu/drm/panthor/Makefile         |  1 +
>  drivers/gpu/drm/panthor/panthor_device.c |  7 +++
>  drivers/gpu/drm/panthor/panthor_device.h |  3 ++
>  drivers/gpu/drm/panthor/panthor_drv.c    | 10 +++-
>  drivers/gpu/drm/panthor/panthor_gpu.c    |  5 ++
>  drivers/gpu/drm/panthor/panthor_gpu.h    |  2 +
>  drivers/gpu/drm/panthor/panthor_perf.c   | 87 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_perf.h   | 15 ++++++
>  8 files changed, 129 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
> index dd15d52a88ba..c65fff290720 100644
> --- a/drivers/gpu/drm/panthor/Makefile
> +++ b/drivers/gpu/drm/panthor/Makefile
> @@ -10,6 +10,7 @@ panthor-y := \
>  	panthor_heap.o \
>  	panthor_hw.o \
>  	panthor_mmu.o \
> +	panthor_perf.o \
>  	panthor_pwr.o \
>  	panthor_sched.o
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 9687c59de350..2877d47c6717 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -24,6 +24,7 @@
>  #include "panthor_gpu.h"
>  #include "panthor_hw.h"
>  #include "panthor_mmu.h"
> +#include "panthor_perf.h"
>  #include "panthor_pwr.h"
>  #include "panthor_sched.h"
>  
> @@ -287,6 +288,10 @@ int panthor_device_init(struct panthor_device *ptdev)
>  	if (ret)
>  		goto err_unplug_fw;
>  
> +	ret = panthor_perf_init(ptdev);
> +	if (ret)
> +		goto err_unplug_sched;
> +
>  	panthor_gem_init(ptdev);
>  
>  	/* Now that everything is initialized, we can enable the reset work. */
> @@ -305,6 +310,8 @@ int panthor_device_init(struct panthor_device *ptdev)
>  
>  err_disable_autosuspend:
>  	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
> +
> +err_unplug_sched:
>  	panthor_sched_unplug(ptdev);
>  
>  err_unplug_fw:
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index b55a3f9edd41..d93b182a3d9b 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -174,6 +174,9 @@ struct panthor_device {
>  	/** @pwr: Power control management data. */
>  	struct panthor_pwr *pwr;
>  
> +	/** @perf_info: Performance counter interface information. */
> +	struct drm_panthor_perf_info perf_info;
> +
>  	/** @gpu: GPU management data. */
>  	struct panthor_gpu *gpu;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 8cdba0c1a14b..b6b55b0f2ff5 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -182,7 +182,8 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_vm_bind_op, syncs), \
> -		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size))
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_info, shader_blocks))
>  
>  /**
>   * PANTHOR_UOBJ_SET() - Copy a kernel object to a user object.
> @@ -959,6 +960,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
>  			args->size = sizeof(ptdev->mmu_info);
>  			return 0;
>  
> +		case DRM_PANTHOR_DEV_QUERY_PERF_INFO:
> +			args->size = sizeof(ptdev->perf_info);
> +			return 0;
> +
>  		default:
>  			return -EINVAL;
>  		}
> @@ -992,6 +997,9 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
>  	case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
>  		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->mmu_info);
>  
> +	case DRM_PANTHOR_DEV_QUERY_PERF_INFO:
> +		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->perf_info);
> +
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index a383b04f101e..726a70b74346 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -508,3 +508,8 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
>  	drm_err(&ptdev->base, "Coherency not supported by the device");
>  	return -ENOTSUPP;
>  }
> +
> +u32 panthor_gpu_get_prfcnt_features(struct panthor_device *ptdev)
> +{
> +	return gpu_read(ptdev->gpu->iomem, GPU_PRFCNT_FEATURES);
> +}
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.h b/drivers/gpu/drm/panthor/panthor_gpu.h
> index f615feb05609..46a6ca98cbb1 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.h
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.h
> @@ -60,4 +60,6 @@ u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev);
>  
>  int panthor_gpu_coherency_init(struct panthor_device *ptdev);
>  
> +u32 panthor_gpu_get_prfcnt_features(struct panthor_device *ptdev);
> +
>  #endif
> diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
> new file mode 100644
> index 000000000000..cbfe1ca5872d
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/panthor_perf.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +/* Copyright 2023 Collabora Ltd */
> +/* Copyright 2025 Arm ltd. */
> +
> +#include <linux/bitops.h>
> +#include <drm/panthor_drm.h>
> +
> +#include "panthor_device.h"
> +#include "panthor_fw.h"
> +#include "panthor_gpu.h"
> +#include "panthor_gpu_regs.h"
> +#include "panthor_perf.h"
> +
> +/**
> + * PANTHOR_PERF_COUNTERS_PER_BLOCK - On CSF architectures pre-11.x, the number of counters
> + * per block was hardcoded to be 64. Arch 11.0 onwards supports the PRFCNT_FEATURES GPU register,
> + * which indicates the same information.
> + */
> +#define PANTHOR_PERF_COUNTERS_PER_BLOCK (64)
> +
> +/**
> + * PANTHOR_HW_COUNTER_SIZE - The size of a hardware counter in the FW ring buffer.
> + */
> +#define PANTHOR_HW_COUNTER_SIZE (sizeof(u32))
> +
> +struct panthor_perf_counter_block {
> +	struct drm_panthor_perf_block_header header;
> +	u64 counters[];
> +};
> +
> +static size_t get_annotated_block_size(size_t counters_per_block)
> +{
> +	return struct_size_t(struct panthor_perf_counter_block, counters, counters_per_block);
> +}
> +
> +static size_t session_get_sample_size(const struct drm_panthor_perf_info *const info)
> +{
> +	const size_t block_size = get_annotated_block_size(info->counters_per_block);
> +	const size_t block_nr = info->cshw_blocks + info->fw_blocks +
> +		info->tiler_blocks + info->memsys_blocks + info->shader_blocks;
> +
> +	return info->sample_header_size + (block_size * block_nr);
> +}
> +
> +static void panthor_perf_info_init(struct panthor_device *const ptdev)
> +{
> +	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
> +	struct drm_panthor_perf_info *const perf_info = &ptdev->perf_info;
> +
> +	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 11) {
> +		perf_info->counters_per_block = PANTHOR_PERF_COUNTERS_PER_BLOCK;
> +	} else {
> +		u32 features = panthor_gpu_get_prfcnt_features(ptdev);
> +
> +		perf_info->counters_per_block = PRFCNT_FEATURES_COUNTER_BLOCK_SIZE(features) /
> +			PANTHOR_HW_COUNTER_SIZE;
> +	}
> +
> +	perf_info->sample_header_size = sizeof(struct drm_panthor_perf_sample_header);
> +	perf_info->block_header_size = sizeof(struct drm_panthor_perf_block_header);
> +
> +	if (GLB_PERFCNT_FW_SIZE(glb_iface->control->perfcnt_size))
> +		perf_info->fw_blocks = 1;
> +
> +	perf_info->cshw_blocks = 1;
> +	perf_info->tiler_blocks = 1;
> +	perf_info->memsys_blocks = GPU_MEM_FEATURES_L2_SLICES(ptdev->gpu_info.mem_features);
> +	perf_info->shader_blocks = hweight64(ptdev->gpu_info.shader_present);
> +
> +	perf_info->sample_size = session_get_sample_size(perf_info);
> +}
> +
> +/**
> + * panthor_perf_init - Initialize the performance counter subsystem.
> + * @ptdev: Panthor device
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int panthor_perf_init(struct panthor_device *ptdev)
> +{
> +	if (!ptdev)
> +		return -EINVAL;
> +
> +	panthor_perf_info_init(ptdev);
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
> new file mode 100644
> index 000000000000..3c32c24c164c
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/panthor_perf.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 or MIT */
> +/* Copyright 2025 Collabora Ltd */
> +/* Copyright 2025 Arm ltd. */
> +
> +#ifndef __PANTHOR_PERF_H__
> +#define __PANTHOR_PERF_H__
> +
> +#include <linux/types.h>
> +
> +struct panthor_device;
> +
> +int panthor_perf_init(struct panthor_device *ptdev);

You could add the declaration in panthor_device.h and drop the creation of the new header file.

Otherwise, the content of the patch looks good to me.

Best regards,
Liviu


> +
> +#endif /* __PANTHOR_PERF_H__ */
> +
> 
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
