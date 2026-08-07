Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1B4C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E7110E2B6;
	Fri,  7 Aug 2026 11:18:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JUKW28a8";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF1110E2B6
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 11:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=cXlALVW4URfZOR5GbSN2w95REW/QWU4Mh60DPk16MHQ=; b=JUKW28a88DgNOrPhBWeiMRwYaN
 VZYt3iKndnft2zUS6ozmsqtGiDPTVxJ4VWxmwMxxNZ7faq66OTyytmYaH/KfmrI/I462LQYJOLTO/
 6Kyx98L2L4EwRmuZLIIpTmbgM4BJ0REX5mCcrz3vY2P8RrAJVbzSJMGfFTgcTC0WSrP8eW7qGuNcp
 1DRt5rtYMPw1b2F7r73ZnNChJWbgy+UoPlKzwhOiL9xQ9Al7rdGX5UTsecoJAlGjZFNXjsyyfj7rG
 j+Jq2/IyMnSBTjYcBK4nEOY6L95yDJTr485g/rPt/oWAGC3ByFOMFIoSbb3iT5zZbJg5vWkPufTWt
 8wWa2NAg==;
Received: from [90.243.171.171] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wsIak-00FOqM-Ml; Fri, 07 Aug 2026 13:18:22 +0200
Message-ID: <3802ef13-3891-4499-aecd-45cb94ab9ae2@igalia.com>
Date: Fri, 7 Aug 2026 12:18:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] drm/vc4: Add new job submission implementation
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
 <20260712-vc4-drm-scheduler-v3-4-ed6dc4defa53@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260712-vc4-drm-scheduler-v3-4-ed6dc4defa53@igalia.com>
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
> Introduce vc4_submit.c with the job submission path rewritten to
> integrate with the DRM GPU scheduler. Most of this code is adapted from
> vc4_gem.c, with key changes concentrated in the job creation and
> lifecycle management. This implementation follows the same design as the
> v3d driver.
> 
> This code coexists with the legacy path until the switchover commit.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/vc4/vc4_submit.c | 577 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 577 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_submit.c b/drivers/gpu/drm/vc4/vc4_submit.c
> new file mode 100644
> index 000000000000..5e839db2ba4d
> --- /dev/null
> +++ b/drivers/gpu/drm/vc4/vc4_submit.c
> @@ -0,0 +1,577 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright © 2014 Broadcom
> + * Copyright © 2026 Raspberry Pi
> + */
> +
> +#include <drm/drm_exec.h>
> +#include <drm/drm_print.h>
> +#include <drm/drm_syncobj.h>
> +
> +#include "vc4_drv.h"
> +#include "vc4_trace.h"
> +
> +/* Takes the reservation lock on all the BOs being referenced, so that
> + * at queue submit time we can update the reservations.
> + *
> + * We don't lock the RCL the tile alloc/state BOs, or overflow memory
> + * (all of which are on render->unref_list). They're entirely private
> + * to vc4, so we don't attach dma-buf fences to them.
> + */
> +static int
> +vc4_lock_bo_reservations(struct vc4_exec_info *exec, struct drm_exec *exec_ctx)
> +{
> +	struct vc4_render_job *render = exec->render;
> +	int ret;
> +
> +	/* Reserve space for our shared (read-only) fence references,
> +	 * before we commit the CL to the hardware.
> +	 */
> +	drm_exec_init(exec_ctx, DRM_EXEC_INTERRUPTIBLE_WAIT, render->bo_count);
> +	drm_exec_until_all_locked(exec_ctx) {
> +		ret = drm_exec_prepare_array(exec_ctx, render->bo, render->bo_count, 1);
> +	}
> +
> +	if (ret)
> +		drm_exec_fini(exec_ctx);
> +
> +	return ret;
> +}
> +
> +static int
> +vc4_add_implicit_dependencies(struct vc4_exec_info *exec)
> +{
> +	struct vc4_render_job *render = exec->render;
> +	struct vc4_bin_job *bin = exec->bin;
> +	struct drm_sched_job *reader;
> +	int ret;
> +
> +	/*
> +	 * Both the renderer and the binner only read the looked-up BOs, so
> +	 * they need to wait for prior writes to land before reading them.
> +	 *
> +	 * When a BIN job is present, the RENDER job already depends on
> +	 * the BIN job's completion fence and thus transitively waits for
> +	 * everything the BIN job waits for.
> +	 */
> +	reader = bin ? &bin->base.base : &render->base.base;
> +
> +	for (int i = 0; i < render->bo_count; i++) {
> +		ret = drm_sched_job_add_implicit_dependencies(reader,
> +							      render->bo[i], false);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * The renderer writes the RCL targets (color/Z/MSAA buffers), so it
> +	 * additionally has to wait for prior readers of those.
> +	 */
> +	for (int i = 0; i < render->rcl_write_bo_count; i++) {
> +		ret = drm_sched_job_add_implicit_dependencies(&render->base.base,
> +							      &render->rcl_write_bo[i]->base,
> +							      true);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * vc4_lookup_bos() - Sets up job->bo[] with the GEM objects
> + * referenced by the job.
> + * @dev: DRM device
> + * @file_priv: DRM file for this fd
> + * @job: VC4 render job being set up
> + * @bo_handles: GEM handles
> + * @bo_count: Number of GEM handles passed in
> + *
> + * The command validator needs to reference BOs by their index within
> + * the submitted job's BO list. This does the validation of the job's
> + * BO list and reference counting for the lifetime of the job.
> + *
> + * Note that this function doesn't need to unreference the BOs on
> + * failure, because that will happen at `vc4_job_free()`.
> + */
> +static int
> +vc4_lookup_bos(struct drm_device *dev, struct drm_file *file_priv,
> +	       struct vc4_render_job *job, u64 bo_handles, u32 bo_count)
> +{
> +	int i, ret;
> +
> +	if (!bo_count) {
> +		drm_dbg(dev, "Rendering requires BOs to validate\n");
> +		return -EINVAL;
> +	}
> +
> +	job->bo_count = bo_count;
> +
> +	ret = drm_gem_objects_lookup(file_priv, u64_to_user_ptr(bo_handles),
> +				     job->bo_count, &job->bo);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < job->bo_count; i++) {
> +		ret = vc4_bo_inc_usecnt(to_vc4_bo(job->bo[i]));
> +		if (ret)
> +			goto fail_dec_usecnt;
> +	}
> +
> +	return 0;
> +
> +fail_dec_usecnt:
> +	/* Decrease usecnt on acquired objects */
> +	for (i--; i >= 0; i--)
> +		vc4_bo_dec_usecnt(to_vc4_bo(job->bo[i]));
> +	return ret;
> +}
> +
> +static int
> +vc4_get_bcl(struct drm_device *dev, struct vc4_exec_info *exec)
> +{
> +	u32 shader_rec_offset, uniforms_offset, exec_size, bin_size;
> +	struct drm_vc4_submit_cl *args = exec->args;
> +	struct vc4_render_job *render_job = exec->render;
> +	struct vc4_bin_job *bin_job = exec->bin;
> +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> +	struct drm_gem_dma_object *exec_bo;
> +	struct vc4_bo *bo;
> +	void *bin = NULL;
> +	int ret;
> +
> +	shader_rec_offset = roundup(args->bin_cl_size, 16);
> +	uniforms_offset = shader_rec_offset + args->shader_rec_size;
> +	exec_size = uniforms_offset + args->uniforms_size;
> +	bin_size = exec_size + (sizeof(struct vc4_shader_state) * args->shader_rec_count);

No scope to overflow u32 I assume even if malicious userspace or 
something? (And to then maybe write past allocated buffer.)

> +
> +	if (shader_rec_offset < args->bin_cl_size ||
> +	    uniforms_offset < shader_rec_offset ||
> +	    exec_size < uniforms_offset ||
> +	    args->shader_rec_count >= (UINT_MAX / sizeof(struct vc4_shader_state)) ||
> +	    bin_size < exec_size) {
> +		drm_dbg(dev, "overflow in exec arguments\n");
> +		ret = -EINVAL;
> +		goto fail;

Cannot do a straight return, it's important to reset exec->bin_u?

> +	}
> +
> +	/* Allocate space where we'll store the copied in user command lists
> +	 * and shader records.
> +	 *
> +	 * We don't just copy directly into the BOs because we need to
> +	 * read the contents back for validation, and I think the
> +	 * bo->vaddr is uncached access.
> +	 */
> +	bin = kvmalloc(bin_size, GFP_KERNEL);
> +	if (!bin) {
> +		ret = -ENOMEM;
> +		goto fail;

Ditto?

> +	}
> +	exec->shader_rec_u = bin + shader_rec_offset;
> +	exec->uniforms_u = bin + uniforms_offset;
> +	exec->shader_state = bin + exec_size;
> +	exec->shader_state_size = args->shader_rec_count;
> +
> +	if (copy_from_user(bin, u64_to_user_ptr(args->bin_cl),
> +			   args->bin_cl_size)) {
> +		ret = -EFAULT;
> +		goto fail;
> +	}
> +
> +	if (copy_from_user(exec->shader_rec_u, u64_to_user_ptr(args->shader_rec),
> +			   args->shader_rec_size)) {
> +		ret = -EFAULT;
> +		goto fail;
> +	}
> +
> +	if (copy_from_user(exec->uniforms_u, u64_to_user_ptr(args->uniforms),
> +			   args->uniforms_size)) {
> +		ret = -EFAULT;
> +		goto fail;
> +	}
> +
> +	bo = vc4_bo_create(dev, exec_size, true, VC4_BO_TYPE_BCL);
> +	if (IS_ERR(bo)) {
> +		ret = PTR_ERR(bo);
> +		goto fail;
> +	}
> +	exec_bo = &bo->base;
> +
> +	list_add_tail(&bo->unref_head, &render_job->unref_list);
> +
> +	bin_job->ct0ca = exec_bo->dma_addr;
> +
> +	exec->bin_u = bin;
> +
> +	exec->shader_rec_v = exec_bo->vaddr + shader_rec_offset;
> +	exec->shader_rec_p = exec_bo->dma_addr + shader_rec_offset;
> +	exec->shader_rec_size = args->shader_rec_size;
> +
> +	exec->uniforms_v = exec_bo->vaddr + uniforms_offset;
> +	exec->uniforms_p = exec_bo->dma_addr + uniforms_offset;
> +	exec->uniforms_size = args->uniforms_size;
> +
> +	ret = vc4_validate_bin_cl(dev, exec_bo->vaddr, bin, exec);
> +	if (ret)
> +		goto fail;
> +
> +	ret = vc4_validate_shader_recs(dev, exec);
> +	if (ret)
> +		goto fail;
> +
> +	if (exec->found_tile_binning_mode_config_packet) {
> +		ret = vc4_v3d_bin_bo_get(vc4, &bin_job->bin_bo_used);
> +		if (ret)
> +			goto fail;
> +	}
> +
> +fail:
> +	kvfree(bin);
> +	exec->bin_u = NULL;
> +
> +	return ret;
> +}
> +
> +static void
> +vc4_job_free(struct kref *ref)
> +{
> +	struct vc4_job *job = container_of(ref, struct vc4_job, refcount);
> +
> +	dma_fence_put(job->irq_fence);
> +	dma_fence_put(job->done_fence);
> +
> +	if (job->perfmon)
> +		vc4_perfmon_put(job->perfmon);
> +
> +	vc4_v3d_pm_put(job->vc4);
> +	kfree(job);
> +}
> +
> +static void
> +vc4_bin_job_free(struct kref *ref)
> +{
> +	struct vc4_bin_job *job = container_of(ref, struct vc4_bin_job,
> +					       base.refcount);
> +	struct vc4_dev *vc4 = job->base.vc4;
> +
> +	/* Release the reference on the binner BO if needed. */
> +	if (job->bin_bo_used)
> +		vc4_v3d_bin_bo_put(vc4);
> +
> +	vc4_job_free(ref);
> +}
> +
> +static void
> +vc4_render_job_free(struct kref *ref)
> +{
> +	struct vc4_render_job *job = container_of(ref, struct vc4_render_job,
> +						  base.refcount);
> +	struct vc4_dev *vc4 = job->base.vc4;
> +	struct vc4_bo *bo, *tmp;
> +	unsigned long irqflags;
> +
> +	if (job->bo) {
> +		for (int i = 0; i < job->bo_count; i++) {
> +			struct vc4_bo *bo = to_vc4_bo(job->bo[i]);
> +
> +			vc4_bo_dec_usecnt(bo);
> +			drm_gem_object_put(job->bo[i]);
> +		}
> +		kvfree(job->bo);
> +	}
> +
> +	list_for_each_entry_safe(bo, tmp, &job->unref_list, unref_head) {
> +		list_del(&bo->unref_head);
> +		drm_gem_object_put(&bo->base.base);
> +	}
> +
> +	/* Free up the allocation of any bin slots we used. */
> +	spin_lock_irqsave(&vc4->job_lock, irqflags);

If job free callbacks are never called from the hardirq context you 
could use spin_(un)lock_irq().

> +	vc4->bin_alloc_used &= ~job->bin_slots;
> +	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
> +
> +	vc4_job_free(ref);
> +}
> +
> +static void
> +vc4_job_put(struct vc4_job *job)
> +{
> +	if (IS_ERR_OR_NULL(job))
> +		return;
> +
> +	kref_put(&job->refcount, job->free);
> +}
> +
> +void vc4_job_cleanup(struct vc4_job *job)
> +{
> +	if (IS_ERR_OR_NULL(job))
> +		return;
> +
> +	drm_sched_job_cleanup(&job->base);
> +	vc4_job_put(job);
> +}
> +
> +static const struct {
> +	size_t size;
> +	void (*free)(struct kref *ref);
> +} vc4_job_types[] = {
> +	[VC4_BIN]		= { sizeof(struct vc4_bin_job), vc4_bin_job_free },
> +	[VC4_RENDER]		= { sizeof(struct vc4_render_job), vc4_render_job_free },
> +};
> +
> +static struct vc4_job *
> +vc4_job_alloc(struct vc4_dev *vc4, struct drm_file *file_priv, u32 in_sync,
> +	      enum vc4_queue queue)
> +{
> +	struct vc4_file *vc4_priv = file_priv->driver_priv;
> +	struct vc4_job *job;
> +	int ret;
> +
> +	if (queue >= VC4_MAX_QUEUES)
> +		return ERR_PTR(-EINVAL);
> +
> +	job = kzalloc(vc4_job_types[queue].size, GFP_KERNEL);
> +	if (!job)
> +		return ERR_PTR(-ENOMEM);
> +
> +	job->vc4 = vc4;
> +	job->free = vc4_job_types[queue].free;
> +
> +	ret = drm_sched_job_init(&job->base, &vc4_priv->sched_entity[queue],
> +				 1, vc4_priv, file_priv->client_id);
> +	if (ret)
> +		goto fail_free;
> +
> +	if (in_sync > 0) {
> +		ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv,
> +							   in_sync, 0);
> +		if (ret)
> +			goto fail_deps;
> +	}
> +
> +	ret = vc4_v3d_pm_get(vc4);
> +	if (ret)
> +		goto fail_deps;
> +
> +	kref_init(&job->refcount);
> +
> +	return job;
> +
> +fail_deps:
> +	drm_sched_job_cleanup(&job->base);
> +fail_free:
> +	kfree(job);
> +	return ERR_PTR(ret);
> +}
> +
> +static int
> +vc4_push_jobs(struct vc4_exec_info *exec)
> +{
> +	struct vc4_render_job *render = exec->render;
> +	struct vc4_job *jobs[VC4_MAX_QUEUES];
> +	int ret, num_jobs = 0;
> +
> +	if (exec->bin)
> +		jobs[num_jobs++] = &exec->bin->base;
> +	jobs[num_jobs++] = &render->base;
> +
> +	for (int i = 0; i < num_jobs; i++) {
> +		drm_sched_job_arm(&jobs[i]->base);
> +
> +		jobs[i]->done_fence = dma_fence_get(&jobs[i]->base.s_fence->finished);
> +
> +		/* put by scheduler job completion */
> +		kref_get(&jobs[i]->refcount);
> +	}
> +
> +	if (exec->bin) {
> +		ret = drm_sched_job_add_dependency(&render->base.base,
> +						   dma_fence_get(exec->bin->base.done_fence));
> +		if (ret)
> +			goto err;
> +	}
> +
> +	for (int i = 0; i < num_jobs; i++)
> +		drm_sched_entity_push_job(&jobs[i]->base);
> +
> +	return 0;
> +
> +err:
> +	/* Mark every armed job as failed so run_job() skips execution */
> +	for (int i = 0; i < num_jobs; i++) {
> +		dma_fence_set_error(&jobs[i]->base.s_fence->finished, ret);

FWIW you could have the set_error loop inside the if (exec->bin) block, 
break after it, and jobs are pushed anway just return ret instead of 0. 
Not sure what is nicer, your call.

> +		drm_sched_entity_push_job(&jobs[i]->base);
> +	}
> +
> +	return ret;
> +}
> +
> +static void
> +vc4_attach_fences(struct vc4_render_job *job, struct drm_syncobj *sync_out,
> +		  struct dma_fence *done_fence)
> +{
> +	struct vc4_bo *bo;
> +	int i;
> +
> +	for (i = 0; i < job->bo_count; i++) {
> +		bo = to_vc4_bo(job->bo[i]);
> +		dma_resv_add_fence(bo->base.base.resv, job->base.done_fence,
> +				   DMA_RESV_USAGE_READ);
> +	}
> +
> +	for (i = 0; i < job->rcl_write_bo_count; i++) {
> +		bo = to_vc4_bo(&job->rcl_write_bo[i]->base);
> +		dma_resv_add_fence(bo->base.base.resv, job->base.done_fence,
> +				   DMA_RESV_USAGE_WRITE);
> +	}
> +
> +	if (sync_out) {
> +		drm_syncobj_replace_fence(sync_out, done_fence);
> +		drm_syncobj_put(sync_out);
> +	}
> +}
> +
> +/**
> + * vc4_submit_cl_ioctl() - Submits a job (frame) to VC4.
> + * @dev: DRM device
> + * @data: ioctl argument
> + * @file_priv: DRM file for this fd
> + *
> + * This is the main entrypoint for userspace to submit a 3D frame to
> + * the GPU. Userspace provides the binner command list (if
> + * applicable), and the kernel sets up the render command list to draw
> + * to the framebuffer described in the ioctl, using the command lists
> + * that the 3D engine's binner will produce.
> + */
> +int
> +vc4_submit_cl_ioctl(struct drm_device *dev, void *data,
> +		    struct drm_file *file_priv)
> +{
> +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> +	struct vc4_file *vc4_priv = file_priv->driver_priv;
> +	struct drm_vc4_submit_cl *args = data;
> +	struct vc4_exec_info exec = {
> +		.dev = vc4,
> +		.args = args,
> +	};
> +	struct vc4_bin_job *bin = NULL;
> +	struct vc4_render_job *render = NULL;
> +	struct drm_syncobj *sync_out = NULL;
> +	struct drm_exec exec_ctx;
> +	int ret;
> +
> +	trace_vc4_submit_cl_ioctl(dev, args->bin_cl_size, args->shader_rec_size,
> +				  args->bo_handle_count);
> +
> +	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
> +		return -ENODEV;
> +
> +	if (!vc4->v3d) {
> +		drm_dbg(dev, "VC4_SUBMIT_CL with no VC4 V3D probed\n");
> +		return -ENODEV;
> +	}
> +
> +	if ((args->flags & ~(VC4_SUBMIT_CL_USE_CLEAR_COLOR |
> +			     VC4_SUBMIT_CL_FIXED_RCL_ORDER |
> +			     VC4_SUBMIT_CL_RCL_ORDER_INCREASING_X |
> +			     VC4_SUBMIT_CL_RCL_ORDER_INCREASING_Y)) != 0) {
> +		drm_dbg(dev, "Unknown flags: 0x%02x\n", args->flags);
> +		return -EINVAL;
> +	}
> +
> +	if (args->pad2 != 0) {
> +		drm_dbg(dev, "Invalid pad: 0x%08x\n", args->pad2);
> +		return -EINVAL;
> +	}
> +
> +	if (args->out_sync) {
> +		sync_out = drm_syncobj_find(file_priv, args->out_sync);
> +		if (!sync_out)
> +			return -ENOENT;
> +	}
> +
> +	render = (struct vc4_render_job *)vc4_job_alloc(vc4, file_priv,
> +							args->in_sync, VC4_RENDER);
> +	if (IS_ERR(render)) {
> +		ret = PTR_ERR(render);
> +		goto fail;
> +	}
> +
> +	exec.render = render;
> +	INIT_LIST_HEAD(&render->unref_list);
> +
> +	ret = vc4_lookup_bos(dev, file_priv, render, args->bo_handles,
> +			     args->bo_handle_count);
> +	if (ret)
> +		goto fail;
> +
> +	if (args->bin_cl_size != 0) {
> +		bin = (struct vc4_bin_job *)vc4_job_alloc(vc4, file_priv,
> +							  args->in_sync, VC4_BIN);
> +		if (IS_ERR(bin)) {
> +			ret = PTR_ERR(bin);
> +			goto fail;
> +		}
> +
> +		exec.bin = bin;
> +		bin->render = render;
> +
> +		ret = vc4_get_bcl(dev, &exec);
> +		if (ret)
> +			goto fail;
> +	}
> +
> +	ret = vc4_get_rcl(dev, &exec);
> +	if (ret)
> +		goto fail;
> +
> +	if (args->perfmonid) {
> +		render->base.perfmon = vc4_perfmon_find(vc4_priv, args->perfmonid);
> +		if (!render->base.perfmon) {
> +			ret = -ENOENT;
> +			goto fail;
> +		}
> +
> +		if (bin) {
> +			bin->base.perfmon = render->base.perfmon;
> +			vc4_perfmon_get(bin->base.perfmon);
> +		}
> +	}
> +
> +	ret = vc4_lock_bo_reservations(&exec, &exec_ctx);
> +	if (ret)
> +		goto fail;
> +
> +	ret = vc4_add_implicit_dependencies(&exec);
> +	if (ret)
> +		goto fail_exec;
> +
> +	scoped_guard(mutex, &vc4->sched_lock) {
> +		ret = vc4_push_jobs(&exec);
> +	}

Maybe it would be a bit more intuitive to lock inside vc4_push_jobs 
since it is the only user of the mutex but up to you.

> +
> +	if (!ret) {
> +		vc4_attach_fences(render, sync_out, render->base.done_fence);
> +	} else if (sync_out) {
> +		/* The jobs were never submitted, so release the unpublished syncobj */
> +		drm_syncobj_put(sync_out);
> +	}

drm_syncobj_put from vc4_attach_fences could be consolidated to a single 
one here:

if (!ret)
	attach fences
if (sync_out)
	put syncobj

Your call again.

> +
> +	drm_exec_fini(&exec_ctx);
> +
> +	vc4_job_put((void *)bin);
> +	vc4_job_put((void *)render);
> +
> +	return ret;
> +
> +fail_exec:
> +	drm_exec_fini(&exec_ctx);
> +fail:
> +	vc4_job_cleanup((void *)bin);
> +	vc4_job_cleanup((void *)render);
> +
> +	if (sync_out)
> +		drm_syncobj_put(sync_out);
> +
> +	return ret;
> +}
> 

Overall looks tidy and proof is in the pudding. If everything works fine 
r-b.

Regards,

Tvrtko

