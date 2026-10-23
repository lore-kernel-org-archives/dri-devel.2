Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0873E606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GfWuBKFo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 622D9112B58;
	Fri, 23 Oct 2026 13:59:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4F51B112B58
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:58:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B25691C00
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:58:51 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 B037C3F673
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792763934; bh=xKoA97gtYFyGQYoGNvmpRHwPabgsxdqPlSj5YP1vDxQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GfWuBKFoepJrCCdSBSdneOv4NY8flB7/t8ZbhdC0aksuDJ48ZJq0+RR18sMMKdmeQ
 MCGmYrcc2vGJx8gxifnyt7FJj6IBNU7xynhg+4sR1Cjq5GAdpngX3QoA3T3P3uVG0k
 JsAaNHWag/wKR37hZ5IjyZOWPqhD/4wPEdckxvVA=
Date: Fri, 23 Oct 2026 14:58:43 +0100
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
Subject: Re: [PATCH v7 4/8] drm/panthor: Add panthor perf initialization and
 termination
Message-ID: <attoEwv8OgZ2-l58@e142607>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
 <20261011-panthor-performance-counters-v7-4-12c32495062f@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261011-panthor-performance-counters-v7-4-12c32495062f@arm.com>
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

On Sun, Oct 11, 2026 at 06:36:51PM +0100, Lukas Zapolskas wrote:
> Added the panthor_perf system initialization and unplug code for
> subsystem-level handling in subsequent patches. Userspace session
> handling is done at the pfile level, via a pool of sessions.
> 
> Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c |  2 +
>  drivers/gpu/drm/panthor/panthor_device.h |  9 +++-
>  drivers/gpu/drm/panthor/panthor_drv.c    |  9 ++++
>  drivers/gpu/drm/panthor/panthor_perf.c   | 85 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_perf.h   |  6 +++
>  5 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 2877d47c6717..535383ef629f 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -95,6 +95,7 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  	/* Now, try to cleanly shutdown the GPU before the device resources
>  	 * get reclaimed.
>  	 */
> +	panthor_perf_unplug(ptdev);
>  	panthor_sched_unplug(ptdev);
>  	panthor_fw_unplug(ptdev);
>  	panthor_mmu_unplug(ptdev);
> @@ -310,6 +311,7 @@ int panthor_device_init(struct panthor_device *ptdev)
>  
>  err_disable_autosuspend:
>  	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
> +	panthor_perf_unplug(ptdev);
>  
>  err_unplug_sched:
>  	panthor_sched_unplug(ptdev);
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index d93b182a3d9b..085254a60fc4 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -29,10 +29,11 @@ struct panthor_hw;
>  struct panthor_job;
>  struct panthor_mmu;
>  struct panthor_fw;
> -struct panthor_perfcnt;
>  struct panthor_pwr;
> +struct panthor_perf;
>  struct panthor_vm;
>  struct panthor_vm_pool;
> +struct panthor_perf_pool;
>  
>  /**
>   * struct panthor_soc_data - Panthor SoC Data
> @@ -323,6 +324,9 @@ struct panthor_device {
>  		atomic_t recovery_needed;
>  	} pm;
>  
> +	/** @perf: Performance counter management data. */
> +	struct panthor_perf *perf;
> +
>  	/** @profile_mask: User-set profiling flags for job accounting. */
>  	u32 profile_mask;
>  
> @@ -377,6 +381,9 @@ struct panthor_file {
>  	/** @groups: Scheduling group pool attached to this file. */
>  	struct panthor_group_pool *groups;
>  
> +	/** @sessions: Perf session pool attached to this file. */
> +	struct panthor_perf_pool *sessions;
> +
>  	/** @stats: cycle and timestamp measures for job execution. */
>  	struct panthor_gpu_usage stats;
>  };
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index b6b55b0f2ff5..3e62142d7ebd 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -37,6 +37,7 @@
>  #include "panthor_gpu.h"
>  #include "panthor_heap.h"
>  #include "panthor_mmu.h"
> +#include "panthor_perf.h"
>  #include "panthor_sched.h"
>  
>  /**
> @@ -1635,9 +1636,16 @@ panthor_open(struct drm_device *ddev, struct drm_file *file)
>  	if (ret)
>  		goto err_destroy_vm_pool;
>  
> +	ret = panthor_perf_pool_create(pfile);
> +	if (ret)
> +		goto err_destroy_group_pool;
> +
>  	file->driver_priv = pfile;
>  	return 0;
>  
> +err_destroy_group_pool:
> +	panthor_group_pool_destroy(pfile);
> +
>  err_destroy_vm_pool:
>  	panthor_vm_pool_destroy(pfile);
>  
> @@ -1651,6 +1659,7 @@ panthor_postclose(struct drm_device *ddev, struct drm_file *file)
>  {
>  	struct panthor_file *pfile = file->driver_priv;
>  
> +	panthor_perf_pool_destroy(pfile);
>  	panthor_group_pool_destroy(pfile);
>  	panthor_vm_pool_destroy(pfile);
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
> index cbfe1ca5872d..ba466e22c50d 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.c
> +++ b/drivers/gpu/drm/panthor/panthor_perf.c
> @@ -3,7 +3,9 @@
>  /* Copyright 2025 Arm ltd. */
>  
>  #include <linux/bitops.h>
> +#include <drm/drm_managed.h>
>  #include <drm/panthor_drm.h>
> +#include <drm/drm_print.h>
>  
>  #include "panthor_device.h"
>  #include "panthor_fw.h"
> @@ -23,11 +25,26 @@
>   */
>  #define PANTHOR_HW_COUNTER_SIZE (sizeof(u32))
>  
> +#define MAX_SESSIONS_PER_FILE 1
> +
>  struct panthor_perf_counter_block {
>  	struct drm_panthor_perf_block_header header;
>  	u64 counters[];
>  };
>  
> +struct panthor_perf {
> +	/** @info: Pointer to the previously initialized perf info. */
> +	struct drm_panthor_perf_info *info;
> +};
> +
> +struct panthor_perf_pool {
> +	/** @session_range: The number of sessions supported at a time. */
> +	struct xa_limit session_range;
> +
> +	/** @xa: Xarray used to manage session handles. */
> +	struct xarray xa;
> +};
> +
>  static size_t get_annotated_block_size(size_t counters_per_block)
>  {
>  	return struct_size_t(struct panthor_perf_counter_block, counters, counters_per_block);
> @@ -74,14 +91,82 @@ static void panthor_perf_info_init(struct panthor_device *const ptdev)
>   * panthor_perf_init - Initialize the performance counter subsystem.
>   * @ptdev: Panthor device
>   *
> + * The performance counters require the FW interface to be available to setup the
> + * sampling ringbuffers, so this must be called only after FW is initialized.
> + *
>   * Return: 0 on success, negative error code on failure.
>   */
>  int panthor_perf_init(struct panthor_device *ptdev)
>  {
> +	struct panthor_perf *perf;
> +	int ret = 0;
> +
>  	if (!ptdev)
>  		return -EINVAL;
>  
>  	panthor_perf_info_init(ptdev);
>  
> +	perf = drmm_kzalloc(&ptdev->base, sizeof(*perf), GFP_KERNEL);
> +	if (!perf)
> +		return -ENOMEM;
> +
> +	drm_info(&ptdev->base, "Performance counter subsystem initialized");
> +
> +	perf->info = &ptdev->perf_info;
> +	ptdev->perf = perf;
> +
> +	return ret;
> +}
> +
> +/**
> + * panthor_perf_unplug - Terminate the performance counter subsystem.
> + * @ptdev: Panthor device.
> + *
> + * Release the performance counter hardware resources. The control structure is
> + * released with the DRM device.
> + */
> +void panthor_perf_unplug(struct panthor_device *ptdev)
> +{
> +	struct panthor_perf *perf = ptdev->perf;
> +
> +	if (!perf)
> +		return;
> +
> +	ptdev->perf = NULL;
> +}
> +
> +int panthor_perf_pool_create(struct panthor_file *pfile)
> +{
> +	struct panthor_perf_pool *pool;
> +
> +	pool = kzalloc_obj(*pool);
> +	if (!pool)
> +		return -ENOMEM;
> +
> +	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC);
> +
> +	pool->session_range.min = 0;
> +	pool->session_range.max = MAX_SESSIONS_PER_FILE - 1;
> +
> +	pfile->sessions = pool;
> +
>  	return 0;
>  }
> +
> +void panthor_perf_pool_destroy(struct panthor_file *pfile)
> +{
> +	struct panthor_perf_pool *pool = pfile->sessions;
> +
> +	if (IS_ERR_OR_NULL(pool))
> +		return;
> +
> +	if (!xa_empty(&pool->xa)) {
> +		drm_err(&pfile->ptdev->base,
> +			"Performance counter sessions active when unplugging the driver!");
> +	}
> +
> +	xa_destroy(&pool->xa);
> +	kfree(pool);
> +
> +	pfile->sessions = NULL;
> +}
> diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
> index 3c32c24c164c..ad01fc88f18f 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.h
> +++ b/drivers/gpu/drm/panthor/panthor_perf.h
> @@ -8,8 +8,14 @@
>  #include <linux/types.h>
>  
>  struct panthor_device;
> +struct panthor_file;
> +struct panthor_perf_pool;
> +
> +int panthor_perf_pool_create(struct panthor_file *pfile);
> +void panthor_perf_pool_destroy(struct panthor_file *pfile);
>  
>  int panthor_perf_init(struct panthor_device *ptdev);
> +void panthor_perf_unplug(struct panthor_device *ptdev);
>  
>  #endif /* __PANTHOR_PERF_H__ */

Now the panthor_perf.h file is sizeable enough to merit its existence. Maybe
we should have 1/8 + 3/8 + 4/8 together in one big happy patch?

Code looks good to me, so:

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

>  
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
