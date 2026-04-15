Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CE8F41992
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D26C10E6CD;
	Wed, 15 Apr 2026 11:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="nzW6lPBU";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id DA64A10E6CD
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:49:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF0741F37
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 04:48:55 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 235E33F7B4
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 04:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776253741; bh=IixGzDZhdpzmaSso0n0dkOwcLC6ibpp8nkNFzA/99PY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nzW6lPBUzJCp4C04p2/fN9eDmaPQvSs9HZfdjz4Gc0ugYf52DzK2drY67TN3WFdgT
 +ZflXLYyqiGanWTqOjMzJcp6QaFUA59CeSJQQkaXtqJsoJb205GkOQo72E3txHQ6YA
 LQy/15QruIThan2FG8Yce7TWk25IZOqHOtXL+/rg=
Date: Wed, 15 Apr 2026 12:48:59 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] drm/panthor: Replace cross-component register
 accesses with helpers
Message-ID: <ad97Kzt9wgJFtVff@e142607>
References: <20260412142951.2309135-1-karunika.choo@arm.com>
 <20260412142951.2309135-4-karunika.choo@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260412142951.2309135-4-karunika.choo@arm.com>
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

On Sun, Apr 12, 2026 at 03:29:46PM +0100, Karunika Choo wrote:
> Stop reaching into other components' registers directly and route those
> operations through the component that owns them.
> 
> Move the timestamp/coherency helpers into panthor_gpu, add a doorbell
> helper, and update call sites accordingly. This keeps register knowledge
> local to each block and avoids spreading cross-component register
> accesses across the driver.
> 
> This is a preparatory cleanup for using per-component iomem bases.
> 
> v2:
> - Fix incorrect spelling of timestamp helpers
> - Fix unintended trailing backslash
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 27 ----------------
>  drivers/gpu/drm/panthor/panthor_drv.c    |  7 ++---
>  drivers/gpu/drm/panthor/panthor_fw.c     | 13 +++++---
>  drivers/gpu/drm/panthor/panthor_fw.h     |  1 +
>  drivers/gpu/drm/panthor/panthor_gpu.c    | 40 ++++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_gpu.h    |  6 ++++
>  drivers/gpu/drm/panthor/panthor_pwr.c    |  2 +-
>  drivers/gpu/drm/panthor/panthor_sched.c  |  2 +-
>  8 files changed, 61 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index f876b13492ae..bd417d6ae8c0 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -22,38 +22,11 @@
>  #include "panthor_fw_regs.h"
>  #include "panthor_gem.h"
>  #include "panthor_gpu.h"
> -#include "panthor_gpu_regs.h"
>  #include "panthor_hw.h"
>  #include "panthor_mmu.h"
>  #include "panthor_pwr.h"
>  #include "panthor_sched.h"
>  
> -static int panthor_gpu_coherency_init(struct panthor_device *ptdev)
> -{
> -	BUILD_BUG_ON(GPU_COHERENCY_NONE != DRM_PANTHOR_GPU_COHERENCY_NONE);
> -	BUILD_BUG_ON(GPU_COHERENCY_ACE_LITE != DRM_PANTHOR_GPU_COHERENCY_ACE_LITE);
> -	BUILD_BUG_ON(GPU_COHERENCY_ACE != DRM_PANTHOR_GPU_COHERENCY_ACE);
> -
> -	/* Start with no coherency, and update it if the device is flagged coherent. */
> -	ptdev->gpu_info.selected_coherency = GPU_COHERENCY_NONE;
> -	ptdev->coherent = device_get_dma_attr(ptdev->base.dev) == DEV_DMA_COHERENT;
> -
> -	if (!ptdev->coherent)
> -		return 0;
> -
> -	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
> -	 * ACE protocol has never been supported for command stream frontend GPUs.
> -	 */
> -	if ((gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES) &
> -		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
> -		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
> -		return 0;
> -	}
> -
> -	drm_err(&ptdev->base, "Coherency not supported by the device");
> -	return -ENOTSUPP;
> -}
> -
>  static int panthor_clk_init(struct panthor_device *ptdev)
>  {
>  	ptdev->clks.core = devm_clk_get(ptdev->base.dev, NULL);
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index e63210b01e6e..66996c9147c2 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -34,7 +34,6 @@
>  #include "panthor_fw.h"
>  #include "panthor_gem.h"
>  #include "panthor_gpu.h"
> -#include "panthor_gpu_regs.h"
>  #include "panthor_heap.h"
>  #include "panthor_mmu.h"
>  #include "panthor_sched.h"
> @@ -839,7 +838,7 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
>  	}
>  
>  	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_OFFSET)
> -		arg->timestamp_offset = gpu_read64(ptdev->iomem, GPU_TIMESTAMP_OFFSET);
> +		arg->timestamp_offset = panthor_gpu_get_timestamp_offset(ptdev);
>  	else
>  		arg->timestamp_offset = 0;
>  
> @@ -854,7 +853,7 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
>  		query_start_time = 0;
>  
>  	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
> -		arg->current_timestamp = gpu_read64_counter(ptdev->iomem, GPU_TIMESTAMP);
> +		arg->current_timestamp = panthor_gpu_get_timestamp(ptdev);
>  	else
>  		arg->current_timestamp = 0;
>  
> @@ -870,7 +869,7 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
>  	}
>  
>  	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
> -		arg->cycle_count = gpu_read64_counter(ptdev->iomem, GPU_CYCLE_COUNT);
> +		arg->cycle_count = panthor_gpu_get_cycle_count(ptdev);
>  	else
>  		arg->cycle_count = 0;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 4704275b9c8f..4a0c23e987b6 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1054,7 +1054,7 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
>  			       GLB_CFG_POWEROFF_TIMER |
>  			       GLB_CFG_PROGRESS_TIMER);
>  
> -	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
> +	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
>  
>  	/* Kick the watchdog. */
>  	mod_delayed_work(ptdev->reset.wq, &ptdev->fw->watchdog.ping_work,
> @@ -1156,7 +1156,7 @@ static void panthor_fw_halt_mcu(struct panthor_device *ptdev)
>  	else
>  		panthor_fw_update_reqs(glb_iface, req, GLB_HALT, GLB_HALT);
>  
> -	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
> +	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
>  }
>  
>  static bool panthor_fw_wait_mcu_halted(struct panthor_device *ptdev)
> @@ -1400,6 +1400,11 @@ int panthor_fw_csg_wait_acks(struct panthor_device *ptdev, u32 csg_slot,
>  	return ret;
>  }
>  
> +void panthor_fw_ring_doorbell(struct panthor_device *ptdev, u32 doorbell_id)
> +{
> +	gpu_write(ptdev->iomem, CSF_DOORBELL(doorbell_id), 1);
> +}
> +
>  /**
>   * panthor_fw_ring_csg_doorbells() - Ring command stream group doorbells.
>   * @ptdev: Device.
> @@ -1414,7 +1419,7 @@ void panthor_fw_ring_csg_doorbells(struct panthor_device *ptdev, u32 csg_mask)
>  	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
>  
>  	panthor_fw_toggle_reqs(glb_iface, doorbell_req, doorbell_ack, csg_mask);
> -	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
> +	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
>  }
>  
>  static void panthor_fw_ping_work(struct work_struct *work)
> @@ -1429,7 +1434,7 @@ static void panthor_fw_ping_work(struct work_struct *work)
>  		return;
>  
>  	panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PING);
> -	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
> +	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
>  
>  	ret = panthor_fw_glb_wait_acks(ptdev, GLB_PING, &acked, 100);
>  	if (ret) {
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
> index fbdc21469ba3..a99a9b6f4825 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.h
> +++ b/drivers/gpu/drm/panthor/panthor_fw.h
> @@ -500,6 +500,7 @@ int panthor_fw_csg_wait_acks(struct panthor_device *ptdev, u32 csg_id, u32 req_m
>  int panthor_fw_glb_wait_acks(struct panthor_device *ptdev, u32 req_mask, u32 *acked,
>  			     u32 timeout_ms);
>  
> +void panthor_fw_ring_doorbell(struct panthor_device *ptdev, u32 doorbell_id);
>  void panthor_fw_ring_csg_doorbells(struct panthor_device *ptdev, u32 csg_slot);
>  
>  struct panthor_kernel_bo *
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index fecc30747acf..747ac332be64 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -427,3 +427,43 @@ void panthor_gpu_resume(struct panthor_device *ptdev)
>  	panthor_hw_l2_power_on(ptdev);
>  }
>  
> +u64 panthor_gpu_get_timestamp(struct panthor_device *ptdev)
> +{
> +	return gpu_read64_counter(ptdev->iomem, GPU_TIMESTAMP);
> +}
> +
> +u64 panthor_gpu_get_timestamp_offset(struct panthor_device *ptdev)
> +{
> +	return gpu_read64(ptdev->iomem, GPU_TIMESTAMP_OFFSET);
> +}
> +
> +u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev)
> +{
> +	return gpu_read64_counter(ptdev->iomem, GPU_CYCLE_COUNT);
> +}
> +
> +int panthor_gpu_coherency_init(struct panthor_device *ptdev)
> +{
> +	BUILD_BUG_ON(GPU_COHERENCY_NONE != DRM_PANTHOR_GPU_COHERENCY_NONE);
> +	BUILD_BUG_ON(GPU_COHERENCY_ACE_LITE != DRM_PANTHOR_GPU_COHERENCY_ACE_LITE);
> +	BUILD_BUG_ON(GPU_COHERENCY_ACE != DRM_PANTHOR_GPU_COHERENCY_ACE);
> +
> +	/* Start with no coherency, and update it if the device is flagged coherent. */
> +	ptdev->gpu_info.selected_coherency = GPU_COHERENCY_NONE;
> +	ptdev->coherent = device_get_dma_attr(ptdev->base.dev) == DEV_DMA_COHERENT;
> +
> +	if (!ptdev->coherent)
> +		return 0;
> +
> +	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
> +	 * ACE protocol has never been supported for command stream frontend GPUs.
> +	 */
> +	if ((gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES) &
> +		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
> +		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
> +		return 0;
> +	}
> +
> +	drm_err(&ptdev->base, "Coherency not supported by the device");
> +	return -ENOTSUPP;
> +}
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.h b/drivers/gpu/drm/panthor/panthor_gpu.h
> index 12c263a39928..f615feb05609 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.h
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.h
> @@ -54,4 +54,10 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev);
>  void panthor_gpu_power_changed_off(struct panthor_device *ptdev);
>  int panthor_gpu_power_changed_on(struct panthor_device *ptdev);
>  
> +u64 panthor_gpu_get_timestamp(struct panthor_device *ptdev);
> +u64 panthor_gpu_get_timestamp_offset(struct panthor_device *ptdev);
> +u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev);
> +
> +int panthor_gpu_coherency_init(struct panthor_device *ptdev);
> +
>  #endif
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
> index 306592ff2227..aafb0c5c7d23 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -199,7 +199,7 @@ static int panthor_pwr_domain_wait_transition(struct panthor_device *ptdev, u32
>  
>  static void panthor_pwr_debug_info_show(struct panthor_device *ptdev)
>  {
> -	drm_info(&ptdev->base, "GPU_FEATURES:    0x%016llx", gpu_read64(ptdev->iomem, GPU_FEATURES));
> +	drm_info(&ptdev->base, "GPU_FEATURES:    0x%016llx", ptdev->gpu_info.gpu_features);
>  	drm_info(&ptdev->base, "PWR_STATUS:      0x%016llx", gpu_read64(ptdev->iomem, PWR_STATUS));
>  	drm_info(&ptdev->base, "L2_PRESENT:      0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PRESENT));
>  	drm_info(&ptdev->base, "L2_PWRTRANS:     0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PWRTRANS));
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 70b8a22b3ed7..60e7b4e20a13 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3373,7 +3373,7 @@ queue_run_job(struct drm_sched_job *sched_job)
>  		if (resume_tick)
>  			sched_resume_tick(ptdev);
>  
> -		gpu_write(ptdev->iomem, CSF_DOORBELL(queue->doorbell_id), 1);
> +		panthor_fw_ring_doorbell(ptdev, queue->doorbell_id);
>  		if (!sched->pm.has_ref &&
>  		    !(group->blocked_queues & BIT(job->queue_idx))) {
>  			pm_runtime_get(ptdev->base.dev);
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
