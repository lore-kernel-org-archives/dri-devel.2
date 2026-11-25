Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD28606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E17QLWmD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDAE110E05A;
	Wed, 25 Nov 2026 23:48:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB3F10E05A
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 23:48:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 677CD6121D;
 Wed, 25 Nov 2026 23:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F335D1F000C0;
 Wed, 25 Nov 2026 23:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795650489;
 bh=EfpwgV9uWS5NDOMks3ujIwFV5v1jexh5+o78fOSvAOk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E17QLWmD9OEjt7ANMuAcam5I6YywT3di/vpFLxvWwfwJYURSn6IX1Z2gFq7Iow+f/
 uvw1s6+JzHr4dFuMMlUJtna9swCs41XOP/mBzTwtQ/x7Dghyip/7Ry7Gb3fykfz6g0
 sLMH6Fd3xBO0T1aJG50KlSYn5dIwdQXLqRq97REHGTeu4bRn32omF4ItCq8Uw+fdz3
 ZS4FaHSSVtx9XXA+qI8hyL+JLw8dTdQISmMYY5Rz0sorglOHRyE9suYNU1xGJfS2Cv
 MWpWSo2z9qAZfyFd1BgI8dBfTFaN0PoE4edxjgyZY/ioc4qeT7WH7RiXjei0pTfaCy
 Sru11W5+5AaGA==
Message-ID: <sashiko-outbox-234410@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imagination: Don't hold queues.lock across
 drm_sched_stop() on reset
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261125-rbrue-suez-pvr-pre-reset-lock-v1-1-0207245c5109@gmail.com>
References: <20261125-rbrue-suez-pvr-pre-reset-lock-v1-1-0207245c5109@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 23:48:08 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/imagination: UAF when pvr_context_create() fails during
  hard reset
--

commit 56c699205a21c02f74c49f4ededa3a23cd759daf
Author: Ryan Brue <ryanbrue.dev@gmail.com>

drm/imagination: Don't hold queues.lock across drm_sched_stop() on reset

This commit pins each queue's context and moves the queues onto
pvr_dev->queues.resetting under pvr_dev->queues.lock so
pvr_queue_device_pre_reset() and pvr_queue_device_post_reset() can stop and
restart the schedulers without holding queues.lock.

> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> index 34b826381aa2b..56751c192ce68 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
> @@ -1242,6 +1242,23 @@ static void reg_state_init(void *cpu_ptr, void *pr=
iv)
>  	}
>  }
> =20
> +static void pvr_queue_reset_put_work(struct work_struct *w)
> +{
> +	struct pvr_queue *queue =3D container_of(w, struct pvr_queue, reset_put=
_work);
> +
> +	pvr_context_put(queue->ctx);
> +}
> +
> +static void pvr_queue_reset_hold(struct pvr_queue *queue, struct list_he=
ad *list)
> +{
> +	/* A put still pending from the last reset hands its reference over. */
> +	if (!cancel_work(&queue->reset_put_work) &&
> +	    !pvr_context_get_if_referenced(queue->ctx))
> +		return;
> +
> +	list_add_tail(&queue->reset_node, list);
> +}
> +
[ ... ]
> @@ -1402,26 +1422,39 @@ struct pvr_queue *pvr_queue_create(struct pvr_con=
text *ctx,
> =20
>  void pvr_queue_device_pre_reset(struct pvr_device *pvr_dev)
>  {
> +	struct list_head *resetting =3D &pvr_dev->queues.resetting;
>  	struct pvr_queue *queue;
> =20
> +	lockdep_assert_held_write(&pvr_dev->reset_sem);
> +
> +	/*
> +	 * drm_sched_stop() waits for the run_job work, which takes
> +	 * queues.lock, so it can't be called with queues.lock held. Pin the
> +	 * queues and stop them without it. A queue whose context is already
> +	 * being released has no jobs left, so it needs no stopping.
> +	 */
>  	mutex_lock(&pvr_dev->queues.lock);
>  	list_for_each_entry(queue, &pvr_dev->queues.idle, node)
> -		pvr_queue_stop(queue, NULL);
> +		pvr_queue_reset_hold(queue, resetting);
>  	list_for_each_entry(queue, &pvr_dev->queues.active, node)
> -		pvr_queue_stop(queue, NULL);
> +		pvr_queue_reset_hold(queue, resetting);
>  	mutex_unlock(&pvr_dev->queues.lock);
> +
> +	list_for_each_entry(queue, resetting, reset_node)
> +		pvr_queue_stop(queue, NULL);
>  }

[Severity: High]
Can this cause a use-after-free on queue and ctx if pvr_context_create()
fails after pvr_queue_create() has added a queue to pvr_dev->queues.idle?

pvr_context_create() initializes ctx->ref_count to 1 and calls
pvr_context_create_queues(), where pvr_queue_create() publishes queue->node
onto pvr_dev->queues.idle under pvr_dev->queues.lock.  If a hard reset runs
before pvr_context_create() finishes and a later step such as init_fw_objs()
fails, pvr_context_create() unwinds by calling pvr_context_destroy_queues()
and kfree(ctx) directly instead of dropping ctx->ref_count:

drivers/gpu/drm/imagination/pvr_context.c:pvr_context_create() {
	...
	err =3D pvr_context_create_queues(ctx, args, ctx->data);
	if (err)
		goto err_free_ctx_id;

	err =3D init_fw_objs(ctx, args, ctx->data);
	if (err)
		goto err_destroy_queues;
	...
err_destroy_queues:
	pvr_context_destroy_queues(ctx, true);
	...
err_free_ctx:
	kfree(ctx);
	return err;
}

Because ctx->fw_obj is still NULL when init_fw_objs() fails,
pvr_queue_cleanup_fw_context() returns without taking pvr_dev->reset_sem,
and pvr_queue_destroy() only removes queue->node under pvr_dev->queues.lock
before freeing queue:

CPU0                                  CPU1
pvr_context_create()
  kref_init(&ctx->ref_count)
  pvr_context_create_queues()
    pvr_queue_create()
      list_add_tail(&queue->node,
                    &queues.idle)
                                      pvr_queue_device_pre_reset()
                                        mutex_lock(&queues.lock)
                                        pvr_queue_reset_hold()
                                          pvr_context_get_if_referenced()
                                          list_add_tail(&queue->reset_node,
                                                        resetting)
                                        mutex_unlock(&queues.lock)
  init_fw_objs() -> fails
  pvr_context_destroy_queues()
    pvr_queue_destroy()
      list_del_init(&queue->node)
      kfree(queue)
  kfree(ctx)
                                        pvr_queue_stop(queue, NULL)
                                          <-- use-after-free

pvr_queue_device_post_reset() and pvr_queue_reset_put_work() will then also
access the freed queue and ctx.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-rbrue-suez=
-pvr-pre-reset-lock-v1-1-0207245c5109@gmail.com?part=3D1
