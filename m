Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9F6F46C45
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D8910E1ED;
	Mon,  6 Apr 2026 15:09:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gz9i3GGo";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C204E10E266
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 15:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yLIlTmDcP7xKOuoL7fw/RMIpfu04aItyJUG2Fm0iPb4=; b=gz9i3GGoa3Iss8QOeGr//bWmwi
 p1RIG1ZZ1QWtfffFM28MRdAwp9VNhuryb15SNfrzwV9Q1Ra56eYv9oyV+jsb+qnvLbxfY9OQ96Cd7
 wHtTe4JUusNXZ4TEHPOhh0t8KcO7gl/MCiBL8XabmbGRISePikKXAw+6m6X7B+ETBSMFtpVvNWqsL
 dqETMInfRO7WblpIwOv3j+XDkCKD2WPbk3nUfQOsxnfvRwnDZZAJRBFxnEdWsoKWmA0mUHrlUNaWL
 nhvfj98KuKPJsNRZ4+ZKHEXp96G1NXFFgU8xqZIROo5fCQjKv0Pf75YxUkaOvAly72k8jGVhJe+Fh
 mG3sYzwA==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w9la1-00CcAc-BW; Mon, 06 Apr 2026 17:09:33 +0200
Message-ID: <39d288c0-8fb8-49bc-9c23-e8f90e00e579@igalia.com>
Date: Mon, 6 Apr 2026 16:09:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] drm/vc4: Add per-file descriptor seqno tracking
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260402-vc4-drm-scheduler-v2-0-d84afd35c602@igalia.com>
 <20260402-vc4-drm-scheduler-v2-5-d84afd35c602@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260402-vc4-drm-scheduler-v2-5-d84afd35c602@igalia.com>
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
> Implement per-file descriptor seqno tracking using an xarray, allowing
> userspace to wait on specific job completions via vc4_wait_seqno_ioctl.
> 
> While this interface should ideally be deprecated in favor of syncobjs,
> it has long been exposed to userspace and therefore must continue to be
> supported.
> 
> Lay the groundwork to replace the existing `finished_seqno` logic with
> DMA fence-based tracking. Each allocated seqno is associated with the
> job's done_fence in a per-fd xarray. This allows vc4_wait_seqno_ioctl()
> to simply look up the corresponding fence and wait on it.
> 
> This changes seqno semantics from global to per-file descriptor.
> However, this doesn't affect userspace because a client can only wait
> on seqnos returned from its own submissions.
> 
> Having per-fd seqnos is an intentional choice, as job ordering with the
> DRM scheduler can only be guaranteed within an entity, which is per-fd.
> Jobs from different file descriptors can complete out of order, so a
> global seqno would break user-space expectations. Therefore, using
> per-fd seqnos guarantees that the seqno monotonicity contract holds.
> 
> This design is inspired by the user fence handling in the Etnaviv and
> msm drivers.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/vc4/vc4_drv.c    |  2 ++
>   drivers/gpu/drm/vc4/vc4_drv.h    | 11 +++++++
>   drivers/gpu/drm/vc4/vc4_submit.c | 66 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 79 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index d0e515c900af6e7400a96e42a9141dab5d5bca2d..9534fdc67b1147a170083801b9c4459a0b8e1e2d 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -168,6 +168,7 @@ static int vc4_open(struct drm_device *dev, struct drm_file *file)
>   	}
>   
>   	kref_init(&vc4file->refcount);
> +	xa_init_flags(&vc4file->seqno_xa, XA_FLAGS_ALLOC1);
>   	vc4_perfmon_open_file(vc4file);
>   	file->driver_priv = vc4file;
>   
> @@ -185,6 +186,7 @@ static void vc4_file_release(struct kref *ref)
>   {
>   	struct vc4_file *vc4file = container_of(ref, struct vc4_file, refcount);
>   
> +	xa_destroy(&vc4file->seqno_xa);
>   	vc4_perfmon_close_file(vc4file);
>   	kfree(vc4file);
>   }
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index 2a331dd053cab1e55476cb028f399a5d25eb4309..98d7fad07c541887f0d7ae7539c2cc24941992b7 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -10,6 +10,7 @@
>   #include <linux/of.h>
>   #include <linux/refcount.h>
>   #include <linux/uaccess.h>
> +#include <linux/xarray.h>
>   
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_debugfs.h>
> @@ -770,6 +771,10 @@ struct vc4_render_job {
>   	 * Must remain allocated until the render job completes.
>   	 */
>   	uint32_t bin_slots;
> +
> +	/* For userspace fence tracking. */
> +	struct vc4_file *file;
> +	u32 seqno;
>   };
>   
>   struct vc4_exec_info {
> @@ -904,6 +909,12 @@ struct vc4_file {
>   
>   	struct drm_sched_entity sched_entity[VC4_MAX_QUEUES];
>   
> +	/* Mapping of seqno to dma_fence for job completion tracking.
> +	 * Allows userspace to wait on specific submissions.
> +	 */
> +	struct xarray seqno_xa;
> +	u32 next_seqno;
> +
>   	bool bin_bo_used;
>   };
>   
> diff --git a/drivers/gpu/drm/vc4/vc4_submit.c b/drivers/gpu/drm/vc4/vc4_submit.c
> index ea87dc8d6b5f860bf47406906d3cb5aa37f176cd..fb1679e54250d7a3568a35090a252a9d03ae3cee 100644
> --- a/drivers/gpu/drm/vc4/vc4_submit.c
> +++ b/drivers/gpu/drm/vc4/vc4_submit.c
> @@ -201,6 +201,57 @@ vc4_get_bcl(struct drm_device *dev, struct vc4_exec_info *exec)
>   	return ret;
>   }
>   
> +int
> +vc4_wait_seqno_ioctl(struct drm_device *dev, void *data,
> +		     struct drm_file *file_priv)
> +{
> +	struct vc4_file *vc4_priv = file_priv->driver_priv;
> +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> +	struct drm_vc4_wait_seqno *args = data;
> +	unsigned long timeout_jiffies = nsecs_to_jiffies(args->timeout_ns);
> +	unsigned long start = jiffies;
> +	struct dma_fence *fence;
> +	long ret;
> +
> +	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
> +		return -ENODEV;
> +
> +	/*
> +	 * While RCU guarantees the xarray entry won't be freed during the
> +	 * lookup, it does not prevent the fence's refcount from being
> +	 * concurrently dropped to zero from the IRQ context.
> +	 *
> +	 * dma_fence_get_rcu() pretends we didn't find a fence in that case.
> +	 */
> +	rcu_read_lock();
> +	fence = xa_load(&vc4_priv->seqno_xa, args->seqno);
> +	if (fence)
> +		fence = dma_fence_get_rcu(fence);
> +	rcu_read_unlock();
> +
> +	if (!fence)
> +		return 0;
> +
> +	trace_vc4_wait_for_seqno_begin(dev, args->seqno, args->timeout_ns);
> +	ret = dma_fence_wait_timeout(fence, true, timeout_jiffies);
> +	trace_vc4_wait_for_seqno_end(dev, args->seqno);
> +
> +	dma_fence_put(fence);
> +
> +	if (ret == -ERESTARTSYS) {
> +		u64 delta = jiffies_to_nsecs(jiffies - start);
> +
> +		if (args->timeout_ns >= delta)
> +			args->timeout_ns -= delta;
> +		else
> +			args->timeout_ns = 0;
> +
> +		return ret;
> +	}
> +
> +	return ret > 0 ? 0 : -ETIME;
> +}
> +
>   static void
>   vc4_job_free(struct kref *ref)
>   {
> @@ -260,6 +311,10 @@ vc4_render_job_free(struct kref *ref)
>   	vc4->bin_alloc_used &= ~job->bin_slots;
>   	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
>   
> +	if (job->seqno)
> +		xa_erase(&job->file->seqno_xa, job->seqno);
> +
> +	vc4_file_put(job->file);
>   	vc4_job_free(ref);
>   }
>   
> @@ -428,6 +483,7 @@ vc4_submit_cl_ioctl(struct drm_device *dev, void *data,
>   		return ret;
>   
>   	exec.render = render;
> +	render->file = vc4_file_get(vc4_priv);
>   	INIT_LIST_HEAD(&render->unref_list);
>   
>   	ret = vc4_lookup_bos(dev, file_priv, render, args->bo_handles,
> @@ -483,10 +539,20 @@ vc4_submit_cl_ioctl(struct drm_device *dev, void *data,
>   	vc4_push_job(&render->base);
>   	mutex_unlock(&vc4->sched_lock);
>   
> +	ret = xa_alloc_cyclic(&vc4_priv->seqno_xa, &render->seqno,
> +			      render->base.done_fence,
> +			      xa_limit_32b, &vc4_priv->next_seqno, GFP_KERNEL);
> +	if (ret < 0) {
> +		/* Jobs are already queued, just skip seqno tracking. */

Why it is not better to allocate the seqno earlier and avoid the problem 
of false positive waits?

Regards,

Tvrtko

> +		render->seqno = 0;
> +	}
>   
>   	vc4_attach_fences(file_priv, render, args->out_sync, render->base.done_fence);
>   	drm_exec_fini(&exec_ctx);
>   
> +	/* Return the seqno for our job. */
> +	args->seqno = render->seqno;
> +
>   	vc4_job_put((void *)bin);
>   	vc4_job_put((void *)render);
>   
> 

