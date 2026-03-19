Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75198108E1E8
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE4E110E971;
	Thu, 19 Mar 2026 11:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ewiYL6Oq";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE00210E971
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 11:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773918626;
 bh=0QeJPButvYP5EhqfbwLudCzfGaYiu5+w8f+bzG4Bpec=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ewiYL6OqwmXWU9B1Fq2TJ/ZZlXKAhyClDFkc5onM2kFTOPKjDwyQuuf4cOl9mc745
 VetxLfnHv/YGg8AFhTLNdjbrjYh0VJrlDOns8Vi2jQNafARt9fEW19sccUY9jOiRou
 7AvFPWxk3ckY/aMDu4YXp/kQ7cyjwLt2skjBvs96Nk+IJ0qm/OQhxcycw37Hy/bwxE
 Xjx5YGDV7+tlot9bDbYxZMzXefQGbbPkB9ZSCz+g+eOSn9Qd8SPclKTwzAjQZiuiRf
 ktcGPWYB8JjKjZi8TyS45HGrkM93XiLIaN3BiyqA5thon/vsmg2P8oAkKvo6RWL3TK
 zQjL5DI1UdUsQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 13FA317E01B1;
 Thu, 19 Mar 2026 12:10:26 +0100 (CET)
Date: Thu, 19 Mar 2026 12:10:20 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Marcin Slusarz <marcin.slusarz@arm.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Lukas Zapolskas
 <lukas.zapolskas@arm.com>, nd@arm.com
Subject: Re: [PATCH v3] drm/panthor: extend timestamp query with flags
Message-ID: <20260319121020.5dbc5fdc@fedora>
In-Reply-To: <20260319110053.909152-1-marcin.slusarz@arm.com>
References: <20260318112952.645160-1-marcin.slusarz@arm.com>
 <20260319110053.909152-1-marcin.slusarz@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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

On Thu, 19 Mar 2026 12:00:53 +0100
Marcin Slusarz <marcin.slusarz@arm.com> wrote:

> Flags now control which data user space wants to query,
> there is more information sources, and there's ability
> to query duration of multiple timestamp reads.
> 
> New sources:
> - CPU's monotonic,
> - CPU's monotonic raw,
> - GPU's cycle count
> 
> These changes should make the implementation of
> VK_KHR_calibrated_timestamps more accurate and much simpler.
> 
> Signed-off-by: Marcin Slusarz <marcin.slusarz@arm.com>

Still

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
> Changes in v3:
>  - {} around multiline statements
>  - added comment about default flags
>  - added VALID_TIMESTAMP_QUERY_FLAGS
>  - used u64_to_user_ptr
> Changes in v2:
>  - added DRM_PANTHOR_TIMESTAMP_CPU_NONE
>  - cpu_timestamp_nsec extended to u64
>  - pad1 removed
>  - copy_from_user -> copy_struct_from_user
>  - looking at size replaced by looking at flags
>  - more comments
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 134 ++++++++++++++++++++++++--
>  include/uapi/drm/panthor_drm.h        |  58 ++++++++++-
>  2 files changed, 184 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 165dddfde6ca..029ef3295b06 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -13,7 +13,9 @@
>  #include <linux/pagemap.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/sched/clock.h>
>  #include <linux/time64.h>
> +#include <linux/time_namespace.h>
>  
>  #include <drm/drm_auth.h>
>  #include <drm/drm_debugfs.h>
> @@ -761,22 +763,135 @@ static void panthor_submit_ctx_cleanup(struct panthor_submit_ctx *ctx,
>  	kvfree(ctx->jobs);
>  }
>  
> +#define VALID_TIMESTAMP_QUERY_FLAGS \
> +		(DRM_PANTHOR_TIMESTAMP_GPU | \
> +		 DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK | \
> +		 DRM_PANTHOR_TIMESTAMP_GPU_OFFSET | \
> +		 DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT | \
> +		 DRM_PANTHOR_TIMESTAMP_FREQ | \
> +		 DRM_PANTHOR_TIMESTAMP_DURATION)
> +
>  static int panthor_query_timestamp_info(struct panthor_device *ptdev,
>  					struct drm_panthor_timestamp_info *arg)
>  {
>  	int ret;
> +	u32 flags;
> +	unsigned long irq_flags;
> +	struct timespec64 cpu_ts;
> +	u64 query_start_time;
> +	bool minimize_interruption;
> +	u32 timestamp_types = 0;
> +
> +	if (arg->flags != 0) {
> +		flags = arg->flags;
> +	} else {
> +		/*
> +		 * If flags are 0, then ask for the same things that we asked
> +		 * for before flags were added.
> +		 */
> +		flags = DRM_PANTHOR_TIMESTAMP_GPU |
> +			DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> +			DRM_PANTHOR_TIMESTAMP_FREQ;
> +	}
> +
> +	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
> +	case 0:
> +		break;
> +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
> +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
> +		timestamp_types++;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (flags & ~VALID_TIMESTAMP_QUERY_FLAGS)
> +		return -EINVAL;
> +
> +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
> +		timestamp_types++;
> +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
> +		timestamp_types++;
> +
> +	/* If user asked to obtain timestamps from more than one source,
> +	 * then it very likely means they want them to be as close as possible.
> +	 * If they asked for duration, then that likely means that they
> +	 * want to know how long obtaining timestamp takes, without random
> +	 * events, like process scheduling or interrupts.
> +	 */
> +	minimize_interruption =
> +		(flags & DRM_PANTHOR_TIMESTAMP_DURATION) ||
> +		(timestamp_types >= 2);
>  
>  	ret = panthor_device_resume_and_get(ptdev);
>  	if (ret)
>  		return ret;
>  
> +	if (flags & DRM_PANTHOR_TIMESTAMP_FREQ) {
>  #ifdef CONFIG_ARM_ARCH_TIMER
> -	arg->timestamp_frequency = arch_timer_get_cntfrq();
> +		arg->timestamp_frequency = arch_timer_get_cntfrq();
>  #else
> -	arg->timestamp_frequency = 0;
> +		arg->timestamp_frequency = 0;
>  #endif
> -	arg->current_timestamp = gpu_read64_counter(ptdev, GPU_TIMESTAMP);
> -	arg->timestamp_offset = gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET);
> +	} else {
> +		arg->timestamp_frequency = 0;
> +	}
> +
> +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_OFFSET)
> +		arg->timestamp_offset = gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET);
> +	else
> +		arg->timestamp_offset = 0;
> +
> +	if (minimize_interruption) {
> +		preempt_disable();
> +		local_irq_save(irq_flags);
> +	}
> +
> +	if (flags & DRM_PANTHOR_TIMESTAMP_DURATION)
> +		query_start_time = local_clock();
> +	else
> +		query_start_time = 0;
> +
> +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
> +		arg->current_timestamp = gpu_read64_counter(ptdev, GPU_TIMESTAMP);
> +	else
> +		arg->current_timestamp = 0;
> +
> +	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
> +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
> +		ktime_get_ts64(&cpu_ts);
> +		break;
> +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
> +		ktime_get_raw_ts64(&cpu_ts);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
> +		arg->cycle_count = gpu_read64_counter(ptdev, GPU_CYCLE_COUNT);
> +	else
> +		arg->cycle_count = 0;
> +
> +	if (flags & DRM_PANTHOR_TIMESTAMP_DURATION)
> +		arg->duration_nsec = local_clock() - query_start_time;
> +	else
> +		arg->duration_nsec = 0;
> +
> +	if (minimize_interruption) {
> +		local_irq_restore(irq_flags);
> +		preempt_enable();
> +	}
> +
> +	if (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
> +		timens_add_monotonic(&cpu_ts);
> +
> +		arg->cpu_timestamp_sec = cpu_ts.tv_sec;
> +		arg->cpu_timestamp_nsec = cpu_ts.tv_nsec;
> +	} else {
> +		arg->cpu_timestamp_sec = 0;
> +		arg->cpu_timestamp_nsec = 0;
> +	}
>  
>  	pm_runtime_put(ptdev->base.dev);
>  	return 0;
> @@ -851,8 +966,14 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
>  		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->csif_info);
>  
>  	case DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO:
> -		ret = panthor_query_timestamp_info(ptdev, &timestamp_info);
> +		ret = copy_struct_from_user(&timestamp_info,
> +					    sizeof(timestamp_info),
> +					    u64_to_user_ptr(args->pointer),
> +					    args->size);
> +		if (ret)
> +			return ret;
>  
> +		ret = panthor_query_timestamp_info(ptdev, &timestamp_info);
>  		if (ret)
>  			return ret;
>  
> @@ -1680,6 +1801,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
>   *       - adds DRM_IOCTL_PANTHOR_BO_SYNC ioctl
>   *       - adds DRM_IOCTL_PANTHOR_BO_QUERY_INFO ioctl
>   *       - adds drm_panthor_gpu_info::selected_coherency
> + * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
>   */
>  static const struct drm_driver panthor_drm_driver = {
>  	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
> @@ -1693,7 +1815,7 @@ static const struct drm_driver panthor_drm_driver = {
>  	.name = "panthor",
>  	.desc = "Panthor DRM driver",
>  	.major = 1,
> -	.minor = 7,
> +	.minor = 8,
>  
>  	.gem_create_object = panthor_gem_create_object,
>  	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table,
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index b401ac585d6a..8a46ef040c3d 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -409,6 +409,38 @@ struct drm_panthor_csif_info {
>  	__u32 pad;
>  };
>  
> +/**
> + * enum drm_panthor_timestamp_info_flags - drm_panthor_timestamp_info.flags
> + */
> +enum drm_panthor_timestamp_info_flags {
> +	/** @DRM_PANTHOR_TIMESTAMP_GPU: Query GPU time. */
> +	DRM_PANTHOR_TIMESTAMP_GPU = 1 << 0,
> +
> +	/** @DRM_PANTHOR_TIMESTAMP_CPU_NONE: Don't query CPU time. */
> +	DRM_PANTHOR_TIMESTAMP_CPU_NONE = 0 << 1,
> +
> +	/** @DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC: Query CPU time using CLOCK_MONOTONIC. */
> +	DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC = 1 << 1,
> +
> +	/** @DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW: Query CPU time using CLOCK_MONOTONIC_RAW. */
> +	DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW = 2 << 1,
> +
> +	/** @DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK: Space reserved for CPU clock type. */
> +	DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK = 7 << 1,
> +
> +	/** @DRM_PANTHOR_TIMESTAMP_GPU_OFFSET: Query GPU offset. */
> +	DRM_PANTHOR_TIMESTAMP_GPU_OFFSET = 1 << 4,
> +
> +	/** @DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT: Query GPU cycle count. */
> +	DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT = 1 << 5,
> +
> +	/** @DRM_PANTHOR_TIMESTAMP_FREQ: Query timestamp frequency. */
> +	DRM_PANTHOR_TIMESTAMP_FREQ = 1 << 6,
> +
> +	/** @DRM_PANTHOR_TIMESTAMP_DURATION: Return duration of time query. */
> +	DRM_PANTHOR_TIMESTAMP_DURATION = 1 << 7,
> +};
> +
>  /**
>   * struct drm_panthor_timestamp_info - Timestamp information
>   *
> @@ -421,11 +453,33 @@ struct drm_panthor_timestamp_info {
>  	 */
>  	__u64 timestamp_frequency;
>  
> -	/** @current_timestamp: The current timestamp. */
> +	/** @current_timestamp: The current GPU timestamp. */
>  	__u64 current_timestamp;
>  
> -	/** @timestamp_offset: The offset of the timestamp timer. */
> +	/** @timestamp_offset: The offset of the GPU timestamp timer. */
>  	__u64 timestamp_offset;
> +
> +	/**
> +	 * @flags: Bitmask of drm_panthor_timestamp_info_flags.
> +	 *
> +	 * If set to 0, then it is interpreted as:
> +	 *  DRM_PANTHOR_TIMESTAMP_GPU |
> +	 *  DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> +	 *  DRM_PANTHOR_TIMESTAMP_FREQ
> +	 */
> +	__u32 flags;
> +
> +	/** @duration_nsec: Duration of time query. */
> +	__u32 duration_nsec;
> +
> +	/** @cycle_count: Value of GPU_CYCLE_COUNT. */
> +	__u64 cycle_count;
> +
> +	/** @cpu_timestamp_sec: Seconds part of CPU timestamp. */
> +	__u64 cpu_timestamp_sec;
> +
> +	/** @cpu_timestamp_nsec: Nanseconds part of CPU timestamp. */
> +	__u64 cpu_timestamp_nsec;
>  };
>  
>  /**

