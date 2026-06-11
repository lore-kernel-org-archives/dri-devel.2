Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667F5CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F98E10ED2B;
	Thu, 11 Jun 2026 07:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hb+Aljif";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C3710ED2B
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:30:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4268143729;
 Thu, 11 Jun 2026 07:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BCC1F00893;
 Thu, 11 Jun 2026 07:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781163051;
 bh=nygukIEHKp7U38KsGjNFvp81aDUj3gXvd/nLvNSRBbI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hb+Aljifhek3G41v4pznbSv2J2Bkv7f5XgrANvZQYxoF22czQvc+jqZNb7wTM279v
 C+dLoaVdxzfoHloND1TNi49nar3A55VzjWFoHRmDvEE3XIG6YiNIaytKWsDifPqnbw
 TYaNWEauj3aGvmdNNt4axyp963pvpJuCF089cNTZzgePIMiA673QzMLPRBPeyGfnGE
 6+4wezLePJMIyYovIi0x5EhrpEQt+6a+a9FwHYZlj8uVKkRwkRrU55ANm0DVxP9aQd
 sfpq5BypcViB0I1R42X06tr5kxHp4PesH24Xj8YPEpVKs7EfxvBC2yD+1F/fEQaXRR
 m9SooK0TDuc1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/imagination: Fix double call to
 drm_sched_entity_fini()
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611-b4-sched_fix-v3-1-693beb50ea01@imgtec.com>
References: <20260611-b4-sched_fix-v3-1-693beb50ea01@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 07:30:50 +0000
Message-Id: <20260611073051.07BCC1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Dangling pointer in `ctx->fw_obj` leads to use-after-free on `=
xa_alloc()` failure in `pvr_context_create()`.
- [High] Concurrent job submission and context destruction pushes jobs to a=
 destroyed DRM scheduler entity, leaking jobs and corrupting memory.
--

commit 251c2d0e7e2826c41929b77248365d4ff3fa7a98
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>

drm/imagination: Fix double call to drm_sched_entity_fini()

This patch removes an extra call to drm_sched_entity_fini() during context
teardown. It fixes a use-after-free underflow issue in the DRM scheduler
entity stats refcounting.

Fixes: eaf01ee5ba28 ("drm/imagination: Implement job submission and schedul=
ing")
References: fd177135f0e6 ("drm/sched: Account entity GPU time")

> diff --git a/drivers/gpu/drm/imagination/pvr_context.c b/drivers/gpu/drm/=
imagination/pvr_context.c
> index eba4694400b5a..e2e30908dfce4 100644
> --- a/drivers/gpu/drm/imagination/pvr_context.c
> +++ b/drivers/gpu/drm/imagination/pvr_context.c

[ ... ]

> @@ -349,7 +374,7 @@ int pvr_context_create(struct pvr_file *pvr_file, str=
uct drm_pvr_ioctl_create_co
>  	pvr_fw_object_destroy(ctx->fw_obj);
> =20
>  err_destroy_queues:
> -	pvr_context_destroy_queues(ctx);
> +	pvr_context_destroy_queues(ctx, true);

[Severity: Critical]
This is a pre-existing issue, but can this cause a use-after-free if
xa_alloc() fails?

If xa_alloc() fails for the context handle, the code jumps to
err_destroy_fw_obj:

err_destroy_fw_obj:
        pvr_fw_object_destroy(ctx->fw_obj);

err_destroy_queues:
        pvr_context_destroy_queues(ctx, true);

This frees the pvr_fw_object but does not set ctx->fw_obj to NULL. Execution
then falls through to err_destroy_queues, where pvr_context_destroy_queues()
will iterate through the queues and call pvr_queue_destroy().

Inside pvr_queue_destroy(), it eventually calls
pvr_queue_cleanup_fw_context():

pvr_queue_cleanup_fw_context() {
        if (!queue->ctx->fw_obj)
                return 0;
        return pvr_fw_structure_cleanup(..., queue->ctx->fw_obj, ...);
}

Since the freed pointer is not NULL, does it bypass this check and
dereference the freed memory in pvr_fw_structure_cleanup()?

> =20
>  err_free_ctx_id:
>  	/*

[ ... ]

> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> index 7ed60e1c1a866..15cd8adc7528f 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
> @@ -1445,15 +1445,11 @@ void pvr_queue_kill(struct pvr_queue *queue)
>   */
>  void pvr_queue_destroy(struct pvr_queue *queue)
>  {

[Severity: High]
This is a pre-existing issue, but does a race condition exist
between pvr_submit_jobs() and pvr_context_destroy()?

If pvr_submit_jobs() acquires a reference to the context and sets up a job,
and another thread concurrently calls the context destruction ioctl,
pvr_context_destroy() calls pvr_context_kill_queues() and then
pvr_queue_kill().

pvr_queue_kill() executes:

        drm_sched_entity_destroy(&queue->entity);
        dma_fence_put(queue->last_queued_job_scheduled_fence);
        queue->last_queued_job_scheduled_fence =3D NULL;

If the submit thread concurrently reaches pvr_queue_job_push():

        dma_fence_put(queue->last_queued_job_scheduled_fence);
        queue->last_queued_job_scheduled_fence =3D dma_fence_get(...);
        ...
        drm_sched_entity_push_job(&job->base);

Can this lead to a data race on queue->last_queued_job_scheduled_fence,
potentially causing a double free?=20

Also, wouldn't this push a job to a scheduler entity that was already
destroyed by pvr_queue_kill(), leaking the stranded jobs?

> -	if (!queue)
> -		return;
> -
>  	mutex_lock(&queue->ctx->pvr_dev->queues.lock);
>  	list_del_init(&queue->node);
>  	mutex_unlock(&queue->ctx->pvr_dev->queues.lock);
> =20
>  	drm_sched_fini(&queue->scheduler);
> -	drm_sched_entity_fini(&queue->entity);
> =20
>  	if (WARN_ON(queue->last_queued_job_scheduled_fence))
>  		dma_fence_put(queue->last_queued_job_scheduled_fence);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-b4-sched_f=
ix-v3-1-693beb50ea01@imgtec.com?part=3D1
