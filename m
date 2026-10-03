Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4392BCA5FE2
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 02:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A78010E741;
	Sat,  3 Oct 2026 02:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WefmQVvo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA57E10E741
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 02:51:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 605D860D77;
 Sat,  3 Oct 2026 02:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2A81F00893;
 Sat,  3 Oct 2026 02:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790995897;
 bh=EAXnuhEVDWIo82jtfzSLzDgPXfiSzvFtjS84CXWCP8w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WefmQVvoxFz5VQ4KYsFFDSMOaFaiwuNt3x6Ob0AxV1cfrOwl2Yn/X4NRKT8wzG7l7
 M+3qtDu3M03e9GhvLCF35IXL6UQED0nB4ioVEOROVHciycd4RdB7d39AjqfLuNH/ZX
 m9520pYAixC8bWNMAI0AjLOqIXTNrpuRdP2j4B9kkeKu7yD+AMItaH5fzhnzJmrZYo
 T25efpOFYPh+O5v5JMJKrahnIF0hgsLzwK5Qtv3MV4tFFMDRPW0XAWjVZrx3Mygs1n
 ug2W6E4QnvdNXDBqrjk56Om7mBRrpDIqYF0BtON8NlSNiLugJ6i7FoMHgiYbroYxno
 ZWQax6e1Edljg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] accel/qaic: Use DRM_SCHED to handle FIFO submission
To: "Carl Vanderlip" <carl.vanderlip@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261003023818.1161666-5-carl.vanderlip@oss.qualcomm.com>
References: <20261003023818.1161666-1-carl.vanderlip@oss.qualcomm.com>
 <20261003023818.1161666-5-carl.vanderlip@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 02:51:36 +0000
Message-Id: <20261003025136.ED2A81F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] accel/qaic: Aborted jobs leave unsignaled hardware fences in d=
ma_resv
- [Critical] accel/qaic: Resetting sequence numbers across slices overwrite=
s fences
- [Critical] accel/qaic: Deadlock in decode_deactivate due to ignored inter=
rupts
- [High] accel/qaic: Error rollback with mutex_lock_interruptible hangs BO
- [High] accel/qaic: Job credit overflow triggers DRM scheduler WARN_ON_ONCE
--

commit 188a88e259ba9f726c46ba938ac70127cfee6105
Author: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>

accel/qaic: Use DRM_SCHED to handle FIFO submission

This commit replaces the custom FIFO submission process with the DRM
scheduler, introducing a scheduler entity credit system to prevent overflow.
It calculates a scaling ratio to map variable FIFO sizes to a fixed credit
limit.

> diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_=
control.c
> --- a/drivers/accel/qaic/qaic_control.c
> +++ b/drivers/accel/qaic/qaic_control.c
[ ... ]
> @@ -919,7 +919,12 @@ static int decode_deactivate(struct qaic_device *qde=
v, void *trans, u32 *msg_len
>  		 * Releasing resources failed on the device side, which puts
>  		 * us in a bind since they may still be in use, so enable the
>  		 * dbc. User is expected to retry deactivation.
> +		 *
> +		 * Scheduler entity must be destroyed before it's reinitialized
> +		 * in enable_dbc, otherwise entity list element points to itself
> +		 * and causes a cycle in any list it was a node of.
>  		 */
> +		drm_sched_entity_destroy(&qdev->dbc[dbc_id].sched_entity);
>  		enable_dbc(qdev, dbc_id, usr);
>  		return -ECANCELED;

[Severity: Critical]
Can this synchronous destroy call cause a deadlock?

When shutting down a user context, the driver first calls disable_dbc(),
which sets dbc->usr =3D NULL. If the device replies with an error status he=
re,
we call drm_sched_entity_destroy() which blocks waiting for all pending jobs
to complete.

However, since dbc->usr is already NULL, the hardware interrupt handler
dbc_irq_threaded_fn() will skip processing and ignore all completions, which
deadlocks the control workqueue forever.

> diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_dat=
a.c
> --- a/drivers/accel/qaic/qaic_data.c
> +++ b/drivers/accel/qaic/qaic_data.c
[ ... ]
> -static inline int copy_partial_exec_reqs(struct bo_slice *slice, u64 res=
ize)
> +static int create_slice_jobs(struct drm_file *file_priv, struct bo_slice=
 *slice, bool partial,
> +			     u64 resize, struct list_head *tmp_list)
>  {
[ ... ]
> -	ret =3D qaic_submit_reqs_to_hw(slice, nents_xfer, true, last_bytes);
> +	if (partial)
> +		nents_xfer =3D first_n + 1;
> +	else
> +		nents_xfer =3D slice->nents;
> =20
> -	return ret;
> +	job =3D qaic_create_job(file_priv, slice, nents_xfer, 0, tmp_list);

[Severity: Critical]
Is it safe to hardcode 0 for the sequence number across multiple slices?

Because all slices of a BO share the exact same bo->fence_context,
dma_resv_add_fence() sees subsequent slice fences as having the same context
and an overlapping sequence number (e.g., 0 >=3D 0). The dma_resv logic
therefore assumes they are on the same timeline and overwrites the earlier
slice's fence, which could allow userspace or other drivers to access the
buffer while earlier slices are still undergoing DMA.

[ ... ]
> @@ -1290,13 +1232,7 @@ static int send_bo_list_to_sched(...)
[ ... ]
>  unlock_bo:
> -	drm_gem_object_put(&bo->base);
>  	mutex_unlock(&bo->lock);
> -failed_to_send_bo:
> -	for (j =3D 0; j < i; j++) {
> -		drm_gem_object_put(&exec->bo_arr[j]->base);
> -		spin_lock_irqsave(&dbc->xfer_lock, flags);
> -		bo =3D list_last_entry(&dbc->xfer_list, struct qaic_bo, xfer_list);
> -		list_del_init(&bo->xfer_list);
> -		spin_unlock_irqrestore(&dbc->xfer_lock, flags);
> -		dma_sync_sgtable_for_cpu(&qdev->pdev->dev, bo->sgt, bo->dir);
> +free_jobs:
> +	for (j =3D i - 1; i > 0 && j >=3D 0; j--) {
> +		bo =3D exec->bo_arr[j];
> +		ret =3D mutex_lock_interruptible(&bo->lock);
> +		if (!ret) {
> +			bo->need_dev_sync =3D false;
> +			dma_fence_put(bo->fence);
> +			bo->fence =3D NULL;
> +			mutex_unlock(&bo->lock);
> +		}

[Severity: High]
Does using an interruptible lock in this error rollback path risk permanent=
ly
deadlocking the buffer object?

If a thread has a pending signal, the lock acquisition fails and this
critical cleanup block is skipped. Failing to perform this rollback leaves
the BO permanently waiting on jobs that will never be scheduled.

>  	}
> +	list_for_each_entry_safe_reverse(job_i, tmp, &tmp_list, queue)
> +		qaic_cleanup_job(job_i);
>  unlock_resv:
>  	drm_gem_unlock_reservations((struct drm_gem_object **)exec->bo_arr,
>  				    exec->count, &acquire_ctx);

[Severity: Critical]
Does this error path leak unsignaled hardware fences into the global
dma_resv object?

The internal hardware irq_fence is extracted from these jobs and added
directly to the BO's dma_resv during qaic_create_bo_fence(). If we jump to
free_jobs and drop these jobs here using qaic_cleanup_job(), their
irq_fence is never signaled, which could permanently deadlock the buffer
object.

Similarly, if the DRM scheduler fails to execute the job, it signals its
software s_fence->finished but leaves the hardware irq_fence unsignaled.

> diff --git a/drivers/accel/qaic/qaic_sched.c b/drivers/accel/qaic/qaic_sc=
hed.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/accel/qaic/qaic_sched.c
[ ... ]
> +void set_dbc_scaling_ratio(struct dma_bridge_chan *dbc, u32 nelem)
> +{
> +	if (!nelem) {
[ ... ]
> +		dbc->credit_ratio =3D QAIC_CREDITS;
> +		return;
> +	}
> +	if (QAIC_CREDITS % nelem !=3D 0)
> +		pr_debug("Credits not evenly divisible by queue size: size =3D %d\n", =
nelem);
> +	dbc->credit_ratio =3D DIV_ROUND_UP(QAIC_CREDITS, nelem);
> +}
[ ... ]
> +struct qaic_job *qaic_create_job(struct drm_file *file_priv, struct bo_s=
lice *slice,
> +				 unsigned int num_req, u64 seq_no, struct list_head *tmp_list)
> +{
[ ... ]
> +	u32 credits;
[ ... ]
> +
> +	if (check_mul_overflow((u32)num_req, dbc->credit_ratio, &credits))
> +		return ERR_PTR(-EINVAL);

[Severity: High]
Can this math result in credits exceeding the DRM scheduler's limit?

By rounding up the scaling ratio, (nelem - 1) * credit_ratio can exceed
QAIC_CREDITS - 1. For example, if nelem =3D 5456, ratio =3D 13, and num_req=
 =3D
5455, the required credits evaluate to 70915, exceeding the 65535 limit.

While check_mul_overflow() prevents 32-bit integer overflow, it does not
verify if credits exceeds the DRM scheduler's static credit_limit.
Exceeding this limit will trip the WARN_ON_ONCE in drm_sched_can_queue()
and permanently stall the entity queue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003023818.1161=
666-1-carl.vanderlip@oss.qualcomm.com?part=3D4
