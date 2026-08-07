Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFE0C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 09:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3CE10E3F6;
	Fri,  7 Aug 2026 09:22:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fEHgV6qU";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40FF110E3F6
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 09:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=2tUHqbe+MekOBUnqwwiH+Tx//2Cc2EQ919g0+6XWuqA=; b=fEHgV6qUwCUUkd1LtPLOKsDLwI
 GD5UTdLwJVHg4X5WtG3xnKpq+vKUt0aBoP4e+Hr0cK9dK3U59ec72H7xNYGqa25l/B0Rc8oj3k72n
 ohF/hTin9kjy0eUm4XGBrqAdEwDWgBTkdbWdFHbH3zMQltHwojTCEV8emp+y6gCAjFA0ZOyaUpFXE
 rxqAtUCKL7A+2hBBUEncwt1Q6YhzdwLBmLL1d8PFhVZIC3flwvV4XgvZ7ALwsRfosad9QgGXkFi+Q
 yk2YNUZHP86hqViOrCCmxI3rLfS8gY0yVRX+xGI0x+1yGWCDCLs4AAIrAeQfyLoFL/xdJS//HnV3A
 kc62+rPA==;
Received: from [90.243.171.171] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wsGmG-00FLRA-NV; Fri, 07 Aug 2026 11:22:08 +0200
Message-ID: <14cc0561-7b5e-4a7e-8c6f-4126017dddd7@igalia.com>
Date: Fri, 7 Aug 2026 10:22:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] drm/vc4: Add DRM GPU scheduler infrastructure and
 job structures
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
 <20260712-vc4-drm-scheduler-v3-3-ed6dc4defa53@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260712-vc4-drm-scheduler-v3-3-ed6dc4defa53@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 12/07/2026 16:14, Maíra Canal wrote:
> Introduce `struct vc4_job` as the new base structure for GPU jobs, with
> `vc4_bin_job` and `vc4_render_job` as specialized variants for BIN and
> RENDER jobs, respectively. These structures embed `struct drm_sched_job`
> and will be used with the DRM GPU scheduler. The `vc4_exec_info` struct
> now holds pointers to these job structs, allowing the existing validation
> code to populate job fields during command list processing.
> 
> Add the core scheduler infrastructure in the new file "vc4_sched.c",
> which implements scheduler operations for BIN and RENDER queues, timeout
> handling, and job cleanup. Each queue has its own scheduler instance.
> 
> This design is largely inspired by the v3d driver.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/vc4/vc4_drv.c   |  24 +++
>   drivers/gpu/drm/vc4/vc4_drv.h   | 117 +++++++++++++-
>   drivers/gpu/drm/vc4/vc4_fence.c |  18 +++
>   drivers/gpu/drm/vc4/vc4_gem.c   |   8 +-
>   drivers/gpu/drm/vc4/vc4_sched.c | 331 ++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 496 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index 616caf9d9915..cacd4cb94259 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -145,7 +145,10 @@ static int vc4_get_param_ioctl(struct drm_device *dev, void *data,
>   static int vc4_open(struct drm_device *dev, struct drm_file *file)
>   {
>   	struct vc4_dev *vc4 = to_vc4_dev(dev);
> +	struct drm_gpu_scheduler *sched;
>   	struct vc4_file *vc4file;
> +	enum vc4_queue q;
> +	int ret;
>   
>   	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
>   		return -ENODEV;
> @@ -155,15 +158,33 @@ static int vc4_open(struct drm_device *dev, struct drm_file *file)
>   		return -ENOMEM;
>   	vc4file->dev = vc4;
>   
> +	for (q = 0; q < VC4_MAX_QUEUES; q++) {
> +		sched = &vc4->queue[q].sched;
> +		ret = drm_sched_entity_init(&vc4file->sched_entity[q],
> +					    DRM_SCHED_PRIORITY_NORMAL, &sched,

<ramble>The lovely sched list semantics..</ramble>

> +					    1, NULL);
> +		if (ret)
> +			goto err_sched;
> +	}
> +
>   	vc4_perfmon_open_file(vc4file);
>   	file->driver_priv = vc4file;
> +
>   	return 0;
> +
> +err_sched:
> +	for (q--; q >= 0; q--)
> +		drm_sched_entity_destroy(&vc4file->sched_entity[q]);

I keep forgetting if enum is guaranteed to be signed or not. For 
avoidance of doubt you could write is as while (q-- > 0).

> +	kfree(vc4file);
> +	return ret;
> +
>   }
>   
>   static void vc4_close(struct drm_device *dev, struct drm_file *file)
>   {
>   	struct vc4_dev *vc4 = to_vc4_dev(dev);
>   	struct vc4_file *vc4file = file->driver_priv;
> +	enum vc4_queue q;
>   
>   	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
>   		return;
> @@ -171,6 +192,9 @@ static void vc4_close(struct drm_device *dev, struct drm_file *file)
>   	if (vc4file->bin_bo_used)
>   		vc4_v3d_bin_bo_put(vc4);
>   
> +	for (q = 0; q < VC4_MAX_QUEUES; q++)
> +		drm_sched_entity_destroy(&vc4file->sched_entity[q]);
> +
>   	vc4_perfmon_close_file(vc4file);
>   	kfree(vc4file);
>   }
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index 91c9c7aa8039..255a95f55586 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -20,6 +20,7 @@
>   #include <drm/drm_managed.h>
>   #include <drm/drm_mm.h>
>   #include <drm/drm_modeset_lock.h>
> +#include <drm/gpu_scheduler.h>
>   
>   #include <kunit/test-bug.h>
>   
> @@ -31,6 +32,19 @@ struct drm_gem_object;
>   extern const struct drm_driver vc4_drm_driver;
>   extern const struct drm_driver vc5_drm_driver;
>   
> +enum vc4_queue {
> +	VC4_BIN,
> +	VC4_RENDER,
> +	VC4_MAX_QUEUES,
> +};
> +
> +struct vc4_queue_state {
> +	struct drm_gpu_scheduler sched;
> +
> +	u64 fence_context;
> +	u64 emit_seqno;
> +};
> +
>   /* Don't forget to update vc4_bo.c: bo_type_names[] when adding to
>    * this.
>    */
> @@ -152,6 +166,12 @@ struct vc4_dev {
>   	 */
>   	uint64_t emit_seqno;
>   
> +	struct vc4_queue_state queue[VC4_MAX_QUEUES];
> +
> +	struct vc4_bin_job *bin_job;
> +
> +	struct vc4_render_job *render_job;
> +
>   	/* Sequence number for the last completed job on the GPU.
>   	 * Starts at 0 (no jobs completed).
>   	 */
> @@ -174,6 +194,18 @@ struct vc4_dev {
>   	 * job_done_work.
>   	 */
>   	struct list_head job_done_list;
> +
> +	/* Lock taken when resetting the GPU, to keep multiple
> +	 * processes from trying to park the scheduler threads and
> +	 * reset at once.
> +	 */
> +	struct mutex reset_lock;
> +
> +	/* Lock taken when creating and pushing the GPU scheduler
> +	 * jobs. This lock protects the DRM scheduler arm + push pair.
> +	 */
> +	struct mutex sched_lock;
> +
>   	/* Spinlock used to synchronize the job_list and seqno
>   	 * accesses between the IRQ handler and GEM ioctls.
>   	 */
> @@ -289,8 +321,8 @@ struct vc4_bo {
>   struct vc4_fence {
>   	struct dma_fence base;
>   	struct drm_device *dev;
> -	/* vc4 seqno for signaled() test */

Why this removal?

>   	uint64_t seqno;
> +	enum vc4_queue queue;
>   };
>   
>   #define to_vc4_fence(_fence)					\
> @@ -675,9 +707,84 @@ struct vc4_crtc_state {
>   
>   #define VC4_REG32(reg) { .name = #reg, .offset = reg }
>   
> +struct vc4_job {
> +	struct drm_sched_job base;
> +
> +	struct kref refcount;
> +
> +	struct vc4_dev *vc4;
> +
> +	/* Fence to be signaled by IRQ handler when the job is complete. */
> +	struct dma_fence *irq_fence;
> +
> +	/* Scheduler fence for when the job is considered complete and
> +	 * the BO reservations can be released.
> +	 */
> +	struct dma_fence *done_fence;
> +
> +	/* Last current and return addresses the hardware was processing when
> +	 * the job timedout.
> +	 */
> +	u32 timedout_ctca, timedout_ctra;
> +
> +	/* Pointer to a performance monitor object if the user requested it,
> +	 * NULL otherwise.
> +	 */
> +	struct vc4_perfmon *perfmon;
> +
> +	/* Callback for the freeing of the job on refcount going to 0. */
> +	void (*free)(struct kref *ref);
> +};
> +
> +struct vc4_bin_job {
> +	struct vc4_job base;
> +
> +	uint32_t ct0ca, ct0ea;
> +
> +	/* Corresponding render job, for attaching our overflow memory. */
> +	struct vc4_render_job *render;
> +
> +	/* Whether the exec has taken a reference to the binner BO, which should
> +	 * happen with a VC4_PACKET_TILE_BINNING_MODE_CONFIG packet.
> +	 */
> +	bool bin_bo_used;
> +};
> +
> +struct vc4_render_job {
> +	struct vc4_job base;
> +
> +	uint32_t ct1ca, ct1ea;
> +
> +	/* This is the array of BOs that were looked up at the start of submission.
> +	 * Command validation will use indices into this array.
> +	 */
> +	struct drm_gem_object **bo;
> +	u32 bo_count;
> +
> +	/* List of other BOs used in the job that need to be released
> +	 * once the job is complete.
> +	 */
> +	struct list_head unref_list;
> +
> +	/* List of BOs that are being written by the RCL. Other than
> +	 * the binner temporary storage, this is all the BOs written
> +	 * by the job.
> +	 */
> +	struct drm_gem_dma_object *rcl_write_bo[4];
> +	uint32_t rcl_write_bo_count;
> +
> +	/* Bitmask of which binner slots are freed when this job completes.
> +	 * Must remain allocated until the render job completes.
> +	 */
> +	uint32_t bin_slots;
> +};
> +
>   struct vc4_exec_info {
>   	struct vc4_dev *dev;
>   
> +	struct vc4_bin_job *bin;
> +	struct vc4_render_job *render;
> +
>   	/* Sequence number for this bin/render job. */
>   	uint64_t seqno;
>   
> @@ -800,6 +907,8 @@ struct vc4_file {
>   
>   	struct xarray perfmons;
>   
> +	struct drm_sched_entity sched_entity[VC4_MAX_QUEUES];
> +
>   	bool bin_bo_used;
>   };
>   
> @@ -992,6 +1101,7 @@ extern struct platform_driver vc4_dsi_driver;
>   
>   /* vc4_fence.c */
>   extern const struct dma_fence_ops vc4_fence_ops;
> +struct dma_fence *vc4_fence_create(struct vc4_dev *vc4, enum vc4_queue queue);
>   
>   /* vc4_gem.c */
>   int vc4_gem_init(struct drm_device *dev);
> @@ -1007,6 +1117,7 @@ int vc4_wait_for_seqno(struct drm_device *dev, uint64_t seqno,
>   void vc4_job_handle_completed(struct vc4_dev *vc4);
>   int vc4_gem_madvise_ioctl(struct drm_device *dev, void *data,
>   			  struct drm_file *file_priv);
> +void vc4_save_hang_state(struct drm_device *dev);
>   
>   /* vc4_hdmi.c */
>   extern struct platform_driver vc4_hdmi_driver;
> @@ -1105,4 +1216,8 @@ int vc4_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
>   int vc4_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
>   				 struct drm_file *file_priv);
>   
> +/* vc4_sched.c */
> +int vc4_sched_init(struct vc4_dev *vc4);
> +void vc4_sched_fini(struct vc4_dev *vc4);
> +
>   #endif /* _VC4_DRV_H_ */
> diff --git a/drivers/gpu/drm/vc4/vc4_fence.c b/drivers/gpu/drm/vc4/vc4_fence.c
> index 580214e2158c..18e8c53563d6 100644
> --- a/drivers/gpu/drm/vc4/vc4_fence.c
> +++ b/drivers/gpu/drm/vc4/vc4_fence.c
> @@ -23,6 +23,24 @@
>   
>   #include "vc4_drv.h"
>   
> +struct dma_fence *vc4_fence_create(struct vc4_dev *vc4, enum vc4_queue q)
> +{
> +	struct vc4_queue_state *queue = &vc4->queue[q];
> +	struct vc4_fence *fence;
> +
> +	fence = kzalloc_obj(*fence);
> +	if (!fence)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fence->dev = &vc4->base;
> +	fence->queue = q;
> +	fence->seqno = ++queue->emit_seqno;
> +	dma_fence_init(&fence->base, &vc4_fence_ops, NULL, queue->fence_context,
> +		       fence->seqno);
> +
> +	return &fence->base;
> +}
> +
>   static const char *vc4_fence_get_driver_name(struct dma_fence *fence)
>   {
>   	return "vc4";
> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
> index f84d82b3bfbb..5b5cdfd122e2 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -150,7 +150,7 @@ vc4_get_hang_state_ioctl(struct drm_device *dev, void *data,
>   	return ret;
>   }
>   
> -static void
> +void
>   vc4_save_hang_state(struct drm_device *dev)
>   {
>   	struct vc4_dev *vc4 = to_vc4_dev(dev);
> @@ -1139,6 +1139,12 @@ int vc4_gem_init(struct drm_device *dev)
>   	INIT_LIST_HEAD(&vc4->job_done_list);
>   	spin_lock_init(&vc4->job_lock);
>   	spin_lock_init(&vc4->perfmon_state.lock);
> +	ret = drmm_mutex_init(dev, &vc4->reset_lock);
> +	if (ret)
> +		return ret;
> +	ret = drmm_mutex_init(dev, &vc4->sched_lock);
> +	if (ret)
> +		return ret;
>   
>   	INIT_WORK(&vc4->hangcheck.reset_work, vc4_reset_work);
>   	timer_setup(&vc4->hangcheck.timer, vc4_hangcheck_elapsed, 0);
> diff --git a/drivers/gpu/drm/vc4/vc4_sched.c b/drivers/gpu/drm/vc4/vc4_sched.c
> new file mode 100644
> index 000000000000..179a6b6c61fd
> --- /dev/null
> +++ b/drivers/gpu/drm/vc4/vc4_sched.c
> @@ -0,0 +1,331 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2026 Raspberry Pi */
> +
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <drm/drm_print.h>
> +
> +#include "vc4_drv.h"
> +#include "vc4_regs.h"
> +#include "vc4_trace.h"
> +
> +static struct vc4_job *
> +to_vc4_job(struct drm_sched_job *sched_job)
> +{
> +	return container_of(sched_job, struct vc4_job, base);
> +}
> +
> +static struct vc4_bin_job *
> +to_bin_job(struct drm_sched_job *sched_job)
> +{
> +	return container_of(sched_job, struct vc4_bin_job, base.base);
> +}
> +
> +static struct vc4_render_job *
> +to_render_job(struct drm_sched_job *sched_job)
> +{
> +	return container_of(sched_job, struct vc4_render_job, base.base);
> +}
> +
> +static void
> +vc4_flush_caches(struct drm_device *dev)
> +{
> +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> +
> +	/* Flush the GPU L2 caches.  These caches sit on top of system
> +	 * L3 (the 128kb or so shared with the CPU), and are
> +	 * non-allocating in the L3.
> +	 */
> +	V3D_WRITE(V3D_L2CACTL, V3D_L2CACTL_L2CCLR);
> +
> +	V3D_WRITE(V3D_SLCACTL,
> +		  VC4_SET_FIELD(0xf, V3D_SLCACTL_T1CC) |
> +		  VC4_SET_FIELD(0xf, V3D_SLCACTL_T0CC) |
> +		  VC4_SET_FIELD(0xf, V3D_SLCACTL_UCC) |
> +		  VC4_SET_FIELD(0xf, V3D_SLCACTL_ICC));
> +}
> +
> +static void
> +vc4_flush_texture_caches(struct drm_device *dev)
> +{
> +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> +
> +	V3D_WRITE(V3D_L2CACTL, V3D_L2CACTL_L2CCLR);
> +
> +	V3D_WRITE(V3D_SLCACTL,
> +		  VC4_SET_FIELD(0xf, V3D_SLCACTL_T1CC) |
> +		  VC4_SET_FIELD(0xf, V3D_SLCACTL_T0CC));
> +}
> +
> +static void
> +vc4_sched_job_free(struct drm_sched_job *sched_job)
> +{
> +	struct vc4_job *job = to_vc4_job(sched_job);
> +
> +	vc4_job_cleanup(job);
> +}
> +
> +static struct dma_fence *vc4_bin_job_run(struct drm_sched_job *sched_job)
> +{
> +	struct vc4_bin_job *job = to_bin_job(sched_job);
> +	struct vc4_dev *vc4 = job->base.vc4;
> +	struct drm_device *dev = &vc4->base;
> +	struct dma_fence *fence = NULL;
> +
> +	if (unlikely(job->base.base.s_fence->finished.error))
> +		goto out_clean_job;
> +
> +	/* Lock required around bin_job update vs vc4_overflow_mem_work(). */
> +	spin_lock_irq(&vc4->job_lock);
> +	vc4->bin_job = job;
> +
> +	/* Reset the overflow allocation registers to prevent the binner from
> +	 * writing to a slot that a concurrent render job might free. The first
> +	 * OUTOMEM interrupt will allocate a fresh slot.
> +	 */
> +	V3D_WRITE(V3D_BPOA, 0);
> +	V3D_WRITE(V3D_BPOS, 0);
> +	spin_unlock_irq(&vc4->job_lock);
> +
> +	vc4_flush_caches(dev);
> +
> +	fence = vc4_fence_create(vc4, VC4_BIN);
> +	if (IS_ERR(fence))
> +		goto out_clean_job;
> +
> +	/* Release the previous fence if the scheduler is resubmitting this
> +	 * job after a GPU reset.
> +	 */
> +	if (job->base.irq_fence)
> +		dma_fence_put(job->base.irq_fence);
> +	job->base.irq_fence = dma_fence_get(fence);
> +
> +	trace_vc4_submit_cl(dev, false, to_vc4_fence(fence)->seqno,
> +			    job->ct0ca, job->ct0ea);
> +
> +	vc4_perfmon_start(vc4, job->base.perfmon);
> +
> +	V3D_WRITE(V3D_CTNCA(0), job->ct0ca);
> +	V3D_WRITE(V3D_CTNEA(0), job->ct0ea);
> +
> +	return fence;
> +
> +out_clean_job:
> +	spin_lock_irq(&vc4->job_lock);
> +	vc4->bin_job = NULL;
> +	spin_unlock_irq(&vc4->job_lock);
> +	return fence;
> +}
> +
> +static struct dma_fence *vc4_render_job_run(struct drm_sched_job *sched_job)
> +{
> +	struct vc4_render_job *job = to_render_job(sched_job);
> +	struct vc4_dev *vc4 = job->base.vc4;
> +	struct drm_device *dev = &vc4->base;
> +	struct dma_fence *fence = NULL;
> +
> +	if (unlikely(job->base.base.s_fence->finished.error))
> +		goto out_clean_job;
> +
> +	spin_lock_irq(&vc4->job_lock);
> +	vc4->render_job = job;
> +	spin_unlock_irq(&vc4->job_lock);
> +
> +	/* A previous RCL may have written to one of our textures, and
> +	 * our full cache flush at bin time may have occurred before
> +	 * that RCL completed. Flush the texture cache now, but not
> +	 * the instructions or uniforms (since we don't write those
> +	 * from an RCL).
> +	 */
> +	vc4_flush_texture_caches(dev);
> +
> +	fence = vc4_fence_create(vc4, VC4_RENDER);
> +	if (IS_ERR(fence))
> +		goto out_clean_job;
> +
> +	/* Release the previous fence if the scheduler is resubmitting this
> +	 * job after a GPU reset.
> +	 */
> +	if (job->base.irq_fence)
> +		dma_fence_put(job->base.irq_fence);
> +	job->base.irq_fence = dma_fence_get(fence);
> +
> +	trace_vc4_submit_cl(dev, true, to_vc4_fence(fence)->seqno,
> +			    job->ct1ca, job->ct1ea);
> +
> +	vc4_perfmon_start(vc4, job->base.perfmon);
> +
> +	V3D_WRITE(V3D_CTNCA(1), job->ct1ca);
> +	V3D_WRITE(V3D_CTNEA(1), job->ct1ea);
> +
> +	return fence;
> +
> +out_clean_job:
> +	spin_lock_irq(&vc4->job_lock);
> +	vc4->render_job = NULL;
> +	spin_unlock_irq(&vc4->job_lock);
> +
> +	return fence;
> +}
> +
> +static void
> +vc4_reset(struct drm_device *dev)
> +{
> +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> +
> +	drm_err(dev, "Resetting GPU.\n");
> +
> +	mutex_lock(&vc4->power_lock);
> +	if (vc4->power_refcount) {
> +		/* Power the device off and back on the by dropping the
> +		 * reference on runtime PM.
> +		 */
> +		pm_runtime_put_sync_suspend(&vc4->v3d->pdev->dev);
> +		pm_runtime_get_sync(&vc4->v3d->pdev->dev);
> +	}
> +	mutex_unlock(&vc4->power_lock);
> +
> +	vc4_irq_reset(dev);
> +}
> +
> +static enum drm_gpu_sched_stat
> +vc4_gpu_reset_for_timeout(struct vc4_dev *vc4, struct drm_sched_job *sched_job)
> +{
> +	struct vc4_job *job = to_vc4_job(sched_job);
> +	enum vc4_queue q;
> +
> +	mutex_lock(&vc4->reset_lock);
> +
> +	/* block scheduler */
> +	for (q = 0; q < VC4_MAX_QUEUES; q++)
> +		drm_sched_stop(&vc4->queue[q].sched, sched_job);
> +
> +	if (sched_job) {
> +		drm_sched_increase_karma(sched_job);
> +
> +		/* If the guilty job is a BIN job, also increase the karma
> +		 * of its paired render job. Otherwise, the RENDER job would
> +		 * be submitted to the GPU without binner output.
> +		 */
> +		if (sched_job->sched == &vc4->queue[VC4_BIN].sched) {
> +			struct vc4_bin_job *bin = to_bin_job(sched_job);
> +
> +			drm_sched_increase_karma(&bin->render->base.base);
> +		}
> +	}
> +
> +	vc4_perfmon_stop(vc4, job->perfmon, false);
> +	vc4_save_hang_state(&vc4->base);
> +
> +	/* get the GPU back into the init state */
> +	vc4_reset(&vc4->base);
> +
> +	for (q = 0; q < VC4_MAX_QUEUES; q++)
> +		drm_sched_resubmit_jobs(&vc4->queue[q].sched);
> +
> +	/* Unblock schedulers and restart their jobs. */
> +	for (q = 0; q < VC4_MAX_QUEUES; q++)
> +		drm_sched_start(&vc4->queue[q].sched, 0);
> +
> +	mutex_unlock(&vc4->reset_lock);
> +
> +	return DRM_GPU_SCHED_STAT_RESET;
> +}
> +
> +static enum drm_gpu_sched_stat
> +vc4_cl_job_timedout(struct drm_sched_job *sched_job, enum vc4_queue q)
> +{
> +	struct vc4_job *job = to_vc4_job(sched_job);
> +	struct vc4_dev *vc4 = job->vc4;
> +	u32 ctca = V3D_READ(V3D_CTNCA(q));
> +	u32 ctra = V3D_READ(V3D_CTNRA0(q));
> +
> +	/* If the current address or return address have changed, then the GPU
> +	 * has probably made progress and we should delay the reset. This could
> +	 * fail if the GPU got in an infinite loop in the CL, but that is pretty
> +	 * unlikely outside of an i-g-t testcase.
> +	 */
> +	if (job->timedout_ctca != ctca || job->timedout_ctra != ctra) {
> +		job->timedout_ctca = ctca;
> +		job->timedout_ctra = ctra;
> +
> +		return DRM_GPU_SCHED_STAT_NO_HANG;
> +	}
> +
> +	return vc4_gpu_reset_for_timeout(vc4, sched_job);
> +}
> +
> +static enum drm_gpu_sched_stat
> +vc4_bin_job_timedout(struct drm_sched_job *sched_job)
> +{
> +	return vc4_cl_job_timedout(sched_job, VC4_BIN);
> +}
> +
> +static enum drm_gpu_sched_stat
> +vc4_render_job_timedout(struct drm_sched_job *sched_job)
> +{
> +	return vc4_cl_job_timedout(sched_job, VC4_RENDER);
> +}
> +
> +static const struct drm_sched_backend_ops vc4_bin_sched_ops = {
> +	.run_job = vc4_bin_job_run,
> +	.timedout_job = vc4_bin_job_timedout,
> +	.free_job = vc4_sched_job_free,
> +};
> +
> +static const struct drm_sched_backend_ops vc4_render_sched_ops = {
> +	.run_job = vc4_render_job_run,
> +	.timedout_job = vc4_render_job_timedout,
> +	.free_job = vc4_sched_job_free,
> +};
> +
> +static int
> +vc4_queue_sched_init(struct vc4_dev *vc4, const struct drm_sched_backend_ops *ops,
> +		     enum vc4_queue q, const char *name)
> +{
> +	struct vc4_queue_state *queue = &vc4->queue[q];
> +	struct drm_sched_init_args args = {
> +		.credit_limit = 1,
> +		.timeout = msecs_to_jiffies(500),
> +		.dev = vc4->base.dev,
> +	};
> +
> +	args.ops = ops;
> +	args.name = name;
> +
> +	queue->fence_context = dma_fence_context_alloc(1);
> +
> +	return drm_sched_init(&queue->sched, &args);
> +}
> +
> +int
> +vc4_sched_init(struct vc4_dev *vc4)
> +{
> +	int ret;
> +
> +	ret = vc4_queue_sched_init(vc4, &vc4_bin_sched_ops,
> +				   VC4_BIN, "vc4_bin");
> +	if (ret)
> +		return ret;
> +
> +	ret = vc4_queue_sched_init(vc4, &vc4_render_sched_ops,
> +				   VC4_RENDER, "vc4_render");
> +	if (ret) {
> +		vc4_sched_fini(vc4);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void
> +vc4_sched_fini(struct vc4_dev *vc4)
> +{
> +	enum vc4_queue q;
> +
> +	for (q = 0; q < VC4_MAX_QUEUES; q++) {
> +		if (vc4->queue[q].sched.ready)

What is the ready check for?

> +			drm_sched_fini(&vc4->queue[q].sched);
> +	}
> +}
> 

Overall looks tidy to me and from the cover letter it sounds it works 
well. If you haven't already, give it a lockdep pass, including the GPU 
reset path and then with the entity error unwind you can have my r-b.

Regards,

Tvrtko

