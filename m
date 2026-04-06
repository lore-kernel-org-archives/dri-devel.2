Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5272F46C44
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFDDB10E064;
	Mon,  6 Apr 2026 14:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OiRzXS5A";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F3F10E064
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GynVvveUHWLXJLbacbsd113IaSsrMPwhMsZC1HjsSW4=; b=OiRzXS5ALwp18M3zo3sNLq41NT
 0XHuh3rrr6R6TsceeGPV7haa4sPvF/XhK2IfZkSBr/KVM6xgzN5AfHC0R1d6OJwa5+Mz6UZ1HTc00
 zCex+qQevTYDO16lN9RsbaC2yDPNr/JV11wxzkmNdvsSqTfDpaOsMUv9h+afkKom2KA1jZivnT5X8
 ShR+YH3cvPINeJDOjOvMWi54kBmdzzHey4ytPl1TiqLwWvaa5hcmwmrQZo7ICycpKpGeskUAk/c56
 PPiZyEpBLRLw73tHBLDLxXj+83EvzwdEQqyd0nX4LspafZcIHXMJwfzVTbA+yPgNdrQANv4WSckGA
 Gislqr7A==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w9lIC-00CbeU-2U; Mon, 06 Apr 2026 16:51:08 +0200
Message-ID: <984bf7eb-82c6-465d-ab04-cc25bbc7ba48@igalia.com>
Date: Mon, 6 Apr 2026 15:51:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] drm/vc4: Add new job submission implementation
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260402-vc4-drm-scheduler-v2-0-d84afd35c602@igalia.com>
 <20260402-vc4-drm-scheduler-v2-3-d84afd35c602@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260402-vc4-drm-scheduler-v2-3-d84afd35c602@igalia.com>
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


On 02/04/2026 19:36, Maíra Canal wrote:
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
>   drivers/gpu/drm/vc4/vc4_submit.c | 515 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 515 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_submit.c b/drivers/gpu/drm/vc4/vc4_submit.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ea87dc8d6b5f860bf47406906d3cb5aa37f176cd
> --- /dev/null
> +++ b/drivers/gpu/drm/vc4/vc4_submit.c
> @@ -0,0 +1,515 @@
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
> +#include "vc4_regs.h"
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
> +vc4_lock_bo_reservations(struct vc4_render_job *job, struct drm_exec *exec)
> +{
> +	int ret;
> +
> +	/* Reserve space for our shared (read-only) fence references,
> +	 * before we commit the CL to the hardware.
> +	 */
> +	drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT, job->bo_count);
> +	drm_exec_until_all_locked(exec) {
> +		ret = drm_exec_prepare_array(exec, job->bo, job->bo_count, 1);
> +	}
> +
> +	if (ret)
> +		goto fail;
> +
> +	for (int i = 0; i < job->bo_count; i++) {
> +		ret = drm_sched_job_add_implicit_dependencies(&job->base.base,
> +							      job->bo[i], true);
> +		if (ret)
> +			goto fail;
> +	}
> +
> +	return 0;
> +fail:
> +	drm_exec_fini(exec);
> +	return ret;
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
> +	job->bo_count = bo_count;
> +
> +	if (!job->bo_count) {
> +		drm_warn(dev, "Rendering requires BOs to validate\n");

This warning looks trivially triggerable from userspace in which case it 
would be best to either remove or demote to drm_dbg.

It is also a bit odd to assign job->bo_count before erroring out so 
maybe turn that around too when changing the above.

> +		return -EINVAL;
> +	}
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
> +
> +	if (shader_rec_offset < args->bin_cl_size ||
> +	    uniforms_offset < shader_rec_offset ||
> +	    exec_size < uniforms_offset ||
> +	    args->shader_rec_count >= (UINT_MAX / sizeof(struct vc4_shader_state)) ||
> +	    bin_size < exec_size) {
> +		drm_dbg(dev, "overflow in exec arguments\n");
> +		ret = -EINVAL;
> +		goto fail;
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
> +		drm_err(dev, "Couldn't allocate BO for binning\n");
> +		ret = PTR_ERR(bo);

On a related note, check if vc4_bo_create() should maybe be fixed to 
propagate the error here:

	if (IS_ERR(dma_obj)) {
		struct drm_printer p = drm_info_printer(vc4->base.dev);
		drm_err(dev, "Failed to allocate from GEM DMA helper:\n");
		vc4_bo_stats_print(&p, vc4);
		return ERR_PTR(-ENOMEM);
	}

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

A bit odd exec->bin_u is left pointing to freed memory so I guess it is 
not dereferenced by anyone later and it is just a convenience to store 
it in struct vc4_exec_info.

> +	return ret;
> +}
> +
> +static void
> +vc4_job_free(struct kref *ref)
> +{
> +	struct vc4_job *job = container_of(ref, struct vc4_job, refcount);
> +
> +	dma_fence_put(job->irq_fence);

Ah I was looking for this while reading the previous patch, all good then.

> +	dma_fence_put(job->done_fence);
> +
> +	if (job->perfmon)
> +		vc4_perfmon_put(job->perfmon);

Could the pointer to this job->perfmon be left in vc4->active_perfmon if 
no new job was queued to reset that pointer?

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
> +	int i;
> +
> +	if (job->bo) {
> +		for (i = 0; i < job->bo_count; i++) {
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
> +	vc4->bin_alloc_used &= ~job->bin_slots;
> +	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
> +
> +	vc4_job_free(ref);
> +}
> +
> +static void
> +vc4_job_put(struct vc4_job *job)
> +{
> +	if (!job)
> +		return;
> +
> +	kref_put(&job->refcount, job->free);
> +}
> +
> +void vc4_job_cleanup(struct vc4_job *job)
> +{
> +	if (!job)
> +		return;
> +
> +	drm_sched_job_cleanup(&job->base);
> +	vc4_job_put(job);
> +}
> +
> +static int
> +vc4_job_alloc(struct vc4_dev *vc4, struct drm_file *file_priv,
> +	      void **container, size_t size, void (*free)(struct kref *ref),
> +	      u32 in_sync, enum vc4_queue queue)
> +{
> +	struct vc4_file *vc4_priv = file_priv->driver_priv;
> +	struct vc4_job *job;
> +	int ret;
> +
> +	*container = kcalloc(1, size, GFP_KERNEL);
> +	if (!*container)
> +		return -ENOMEM;
> +
> +	job = *container;
> +	job->vc4 = vc4;
> +	job->free = free;
> +
> +	ret = drm_sched_job_init(&job->base, &vc4_priv->sched_entity[queue],
> +				 1, vc4_priv, file_priv->client_id);
> +	if (ret)
> +		goto fail;
> +
> +	if (in_sync > 0) {
> +		ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv,
> +							   in_sync, 0);
> +		if (ret)
> +			goto fail_deps;
> +	}
> +
> +	ret = vc4_v3d_pm_get(vc4);

As a side note, if vc4 ever gets into a territory of "who is leaking a 
PM reference" bugs, you can have a look at struct ref_tracker and how 
for example intel_runtime_pm_get() (& co) uses it track which objects 
are holding PM references. That was super useful to debug that sort of 
issues.

> +	if (ret)
> +		goto fail_deps;
> +
> +	kref_init(&job->refcount);
> +
> +	return 0;
> +
> +fail_deps:
> +	drm_sched_job_cleanup(&job->base);
> +fail:
> +	kfree(*container);
> +	*container = NULL;
> +
> +	return ret;
> +}
> +
> +static void
> +vc4_push_job(struct vc4_job *job)
> +{
> +	drm_sched_job_arm(&job->base);
> +
> +	job->done_fence = dma_fence_get(&job->base.s_fence->finished);
> +
> +	/* put by scheduler job completion */
> +	kref_get(&job->refcount);
> +
> +	drm_sched_entity_push_job(&job->base);
> +}
> +
> +static void
> +vc4_attach_fences(struct drm_file *file_priv, struct vc4_render_job *job,
> +		  u32 out_sync, struct dma_fence *done_fence)
> +{
> +	struct drm_syncobj *sync_out;
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
> +	if (out_sync > 0) {
> +		/* Update the return sync object for the job */
> +		sync_out = drm_syncobj_find(file_priv, out_sync);
> +		if (sync_out) {
> +			drm_syncobj_replace_fence(sync_out, done_fence);
> +			drm_syncobj_put(sync_out);
> +		}

Is it okay to succeed if sync_out passed in by userspace was not found?

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
> +	ret = vc4_job_alloc(vc4, file_priv, (void *)&render, sizeof(*render),
> +			    vc4_render_job_free, args->in_sync, VC4_RENDER);

On the topic of void * games, I wonder if it would be cleaner for 
vc4_job_alloc to take struct vc4_job **? Or it could even return ERR_PTR.

> +	if (ret)
> +		return ret;
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
> +		ret = vc4_job_alloc(vc4, file_priv, (void *)&bin, sizeof(*bin),
> +				    vc4_bin_job_free, args->in_sync, VC4_BIN);
> +		if (ret)
> +			goto fail;
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
> +	ret = vc4_lock_bo_reservations(render, &exec_ctx);
> +	if (ret)
> +		goto fail;
> +
> +	if (args->perfmonid) {
> +		render->base.perfmon = vc4_perfmon_find(vc4_priv, args->perfmonid);
> +		if (!render->base.perfmon) {
> +			ret = -ENOENT;
> +			goto fail_perfmon;
> +		}
> +
> +		if (bin) {
> +			bin->base.perfmon = render->base.perfmon;
> +			vc4_perfmon_get(bin->base.perfmon);
> +		}
> +	}
> +
> +	mutex_lock(&vc4->sched_lock);
> +	if (bin) {
> +		vc4_push_job(&bin->base);
> +
> +		ret = drm_sched_job_add_dependency(&render->base.base,
> +						   dma_fence_get(bin->base.done_fence));
> +		if (ret)
> +			goto fail_dependency;
> +	}
> +
> +	vc4_push_job(&render->base);
> +	mutex_unlock(&vc4->sched_lock);

Is it significant that vc4->sched_lock is held across both render and 
bin, or it would work the same if it was held over individual 
arm-to-push sections?

> +
> +

Two blank lines.

> +	vc4_attach_fences(file_priv, render, args->out_sync, render->base.done_fence);
> +	drm_exec_fini(&exec_ctx);
> +
> +	vc4_job_put((void *)bin);
> +	vc4_job_put((void *)render);

Could vc4_job_put not work on &bin->base and so not need the void * casts?

> +
> +	return 0;
> +
> +fail_dependency:
> +	mutex_unlock(&vc4->sched_lock);
> +	drm_exec_fini(&exec_ctx);
> +
> +	/* BIN job has already been pushed; the scheduler owns it. Just drop
> +	 * our ref. As the RENDER job has not been armed, normal cleanup still
> +	 * applies.
> +	 */

What is the consequence if this path would trigger? GPU hang?

Regards,

Tvrtko

> +	vc4_job_put((void *)bin);
> +	vc4_job_cleanup((void *)render);
> +
> +	return ret;
> +
> +fail_perfmon:
> +	drm_exec_fini(&exec_ctx);
> +fail:
> +	vc4_job_cleanup((void *)bin);
> +	vc4_job_cleanup((void *)render);
> +
> +	return ret;
> +}
> 

