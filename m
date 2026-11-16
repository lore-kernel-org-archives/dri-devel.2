Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A2606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W24oYjyy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B86810EF4B;
	Mon, 16 Nov 2026 10:49:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1192910E324;
 Mon, 16 Nov 2026 10:49:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0DE0060626;
 Mon, 16 Nov 2026 10:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9086B1F000C4;
 Mon, 16 Nov 2026 10:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794826146;
 bh=RU8BBvhcIoIyJa9mSVMvvxw6G87pTtcvlOmJQZpfEW8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=W24oYjyyXKXI6EyNnrgC7c9/vDDxQRBQqlPrNZZSZYZtrvq87FkCugrJiMC8BTLB0
 g+/cYyh6HQsuT1wuTEYcuuCfz3kTx7kJUyUVyy82Sw/y3KdVVQZjgGKVXRc25bmess
 Qc88DVRo5A04YroNcvwNNZKVlPliRwrBmzMhYK6Hs5BsNwHWmGpaQvt4sYv8mIXETx
 PSu6e0MVsvsYOVDm42oDnr/z8qqTBULTbqc+l9d/6c0+HCeZtJpVYMXPgys5LiE9Tv
 I/wZ2j9B0hlpioGzR3PvAX/GoQZ6oj9o/pQ5jUsNfo8hZNrlydrx2jf0oUR/OxP8rk
 CuTdVoC7aXQsg==
Message-ID: <sashiko-outbox-216777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe/guc: Do not trigger TDR from the memory CAT
 error handler
To: "Arvind Yadav" <arvind.yadav@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261116102020.1567127-1-arvind.yadav@intel.com>
References: <20261116102020.1567127-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:49:06 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/xe/guc: unbanned reset state in
  xe_guc_exec_queue_reset_trigger_cleanup()
- [High] drm/xe/guc: LR queue hang in
  xe_guc_exec_queue_memory_cat_error_handler()
- [Medium] drm/xe/guc: xe_guc_exec_queue_wake_ufence() allows early TDR
  via queue kill
- [Medium] drm/xe/guc: multi-queue ban and wakeups in
  xe_guc_exec_queue_wake_ufence()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] drm/xe: concurrent work_tdr execution in guc_exec_queue_stop()
  on suspend [1]
--

commit 9843a5ccba927d9fc2ffb48f6d5f11c6006bc0ea
Author: Arvind Yadav <arvind.yadav@intel.com>

drm/xe/guc: Do not trigger TDR from the memory CAT error handler

This commit separates waking user-fence waiters from triggering TDR so
that the GuC memory CAT error handler marks the exec queue reset and wakes
waiters without queuing TDR before the context-reset notification arrives.

> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_g=
uc_submit.c
> index b14b37b767f5e..87b22284675e4 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -557,17 +557,39 @@ static bool vf_recovery(struct xe_guc *guc)
>  	return xe_gt_recovery_pending(guc_to_gt(guc));
>  }
> =20
> -static void xe_guc_exec_queue_trigger_cleanup(struct xe_exec_queue *q)
> +static void xe_guc_exec_queue_wake_ufence(struct xe_exec_queue *q)
>  {
>  	struct xe_guc *guc =3D exec_queue_to_guc(q);
>  	struct xe_device *xe =3D guc_to_xe(guc);
> =20
>  	/** to wakeup xe_wait_user_fence ioctl if exec queue is reset */
>  	wake_up_all(&xe->ufence_wq);
> +}
> +
> +static void xe_guc_exec_queue_trigger_cleanup(struct xe_exec_queue *q)
> +{
> +	xe_guc_exec_queue_wake_ufence(q);
> =20
>  	xe_sched_tdr_queue_imm(&q->guc->sched);
>  }

[Severity: High]
This problem wasn't introduced by this patch, but calling
xe_guc_exec_queue_trigger_cleanup() from guc_exec_queue_stop() during
system suspend [1] queues sched->base.work_tdr on gt->ordered_wq
while the GT is suspending.

Unlike GT reset, where xe_guc_submit_stop() runs on gt->ordered_wq,
xe_pm_suspend() calls xe_guc_submit_stop() from the suspend thread while
gt->ordered_wq is still active. When guc_exec_queue_stop() bans a queue
with an incomplete job and calls xe_guc_exec_queue_trigger_cleanup(),
guc_exec_queue_timedout_job() runs concurrently on gt->ordered_wq with
xe_device_is_in_reset() false, attempting forcewake and MMIO register
reads for devcoredump capture as the device enters D3 and then calling
xe_sched_submission_start() while GuC submission is stopped.

> +
> +/*
> + * Allow callers to wake user-fence waiters without triggering the TDR.
> + * The memory CAT handler uses this to avoid starting cleanup before
> + * the context-reset notification arrives.
> + */
> +static void xe_queue_trigger_cleanup_for_reset(struct xe_exec_queue *q,
> +					       bool trigger_tdr)
> +{
> +	if (exec_queue_banned(q))
> +		return;
> +
> +	if (trigger_tdr)
> +		xe_guc_exec_queue_trigger_cleanup(q);
> +	else
> +		xe_guc_exec_queue_wake_ufence(q);
> +}

[Severity: Medium]
Does waking ufence_wq here still allow TDR to run before the context-reset
notification arrives when userspace is waiting in
xe_wait_user_fence_ioctl()?

Because EXEC_QUEUE_STATE_RESET is already set, a thread woken in
xe_wait_user_fence_ioctl() sees q->ops->reset_status(q) return true and
returns -EIO to userspace immediately. If userspace responds to -EIO by
destroying the exec queue or closing the DRM fd, xe_exec_queue_kill() ->
guc_exec_queue_kill() calls xe_guc_exec_queue_trigger_cleanup(q), queuing
TDR and sending the scheduling-disable H2G before the context-reset
notification arrives.

[ ... ]

> @@ -653,7 +675,8 @@ static void xe_guc_exec_queue_group_trigger_cleanup(s=
truct xe_exec_queue *q)
>  	mutex_unlock(&group->list_lock);
>  }
> =20
> -static void xe_guc_exec_queue_reset_trigger_cleanup(struct xe_exec_queue=
 *q)
> +static void xe_guc_exec_queue_reset_trigger_cleanup(struct xe_exec_queue=
 *q,
> +						    bool trigger_tdr)
>  {
>  	if (xe_exec_queue_is_multi_queue(q)) {
>  		struct xe_exec_queue *primary =3D xe_exec_queue_multi_queue_primary(q);
> @@ -664,20 +687,17 @@ static void xe_guc_exec_queue_reset_trigger_cleanup=
(struct xe_exec_queue *q)
>  		WRITE_ONCE(group->banned, true);
> =20
>  		set_exec_queue_reset(primary);
> -		if (!exec_queue_banned(primary))
> -			xe_guc_exec_queue_trigger_cleanup(primary);
> +		xe_queue_trigger_cleanup_for_reset(primary, trigger_tdr);
> =20
>  		mutex_lock(&group->list_lock);
>  		list_for_each_entry(eq, &group->list, multi_queue.link) {
>  			set_exec_queue_reset(eq);
> -			if (!exec_queue_banned(eq))
> -				xe_guc_exec_queue_trigger_cleanup(eq);
> +			xe_queue_trigger_cleanup_for_reset(eq, trigger_tdr);
>  		}
>  		mutex_unlock(&group->list_lock);

[Severity: Medium]
When trigger_tdr is false, should xe_guc_exec_queue_reset_trigger_cleanup()
still set group->banned and call xe_guc_exec_queue_wake_ufence() for every
queue in the group?

Setting group->banned to true causes xe_guc_exec_queue_group_stop() and
guc_exec_queue_timedout_job() on any sibling queue to treat the group as
banned and immediately trigger TDR and disable_scheduling() even though
trigger_tdr was false. In addition, xe_guc_exec_queue_wake_ufence() wakes
the device-wide xe->ufence_wq waitqueue, so calling it inside the
group->list loop calls wake_up_all(&xe->ufence_wq) repeatedly for every
secondary queue while holding group->list_lock.

>  	} else {
>  		set_exec_queue_reset(q);
> -		if (!exec_queue_banned(q))
> -			xe_guc_exec_queue_trigger_cleanup(q);
> +		xe_queue_trigger_cleanup_for_reset(q, trigger_tdr);
>  	}
>  }

[Severity: High]
Does setting EXEC_QUEUE_STATE_RESET without banning the queue or stopping
the scheduler leave the queue in an inconsistent state where
q->ops->reset_status(q) is true while
exec_queue_killed_or_banned_or_wedged(q) is false?

Because guc_exec_queue_suspend() only checks
exec_queue_killed_or_banned_or_wedged(q), preempt_fence_enable_signaling()
succeeds in calling q->ops->suspend(q) on the reset queue (which queues
STATIC_MSG_SUSPEND and sends an early disable_scheduling() H2G via
__guc_exec_queue_process_msg_suspend()). Then preempt_fence_work_func()
checks !q->ops->reset_status(q), sees EXEC_QUEUE_STATE_RESET, skips
q->ops->suspend_wait(q), and signals the preemption fence immediately
while the context is still active on hardware:

drivers/gpu/drm/xe/xe_preempt_fence.c:preempt_fence_work_func() {
	...
	} else if (!q->ops->reset_status(q)) {
		int err =3D q->ops->suspend_wait(q);

		if (err)
			dma_fence_set_error(&pfence->base, err);
	} else {
		dma_fence_set_error(&pfence->base, -ENOENT);
	}

	dma_fence_signal(&pfence->base);
	...
}

wait_for_existing_preempt_fences() ignores -ENOENT, allowing VM unbind or
BO eviction to proceed while the GPU context is still running. In
addition, because the scheduler is not stopped and
guc_exec_queue_run_job() only checks
exec_queue_killed_or_banned_or_wedged(q), queued jobs continue to be
submitted to GuC after the CAT error, and a GT reset in
guc_exec_queue_stop() masks q->guc->state without EXEC_QUEUE_STATE_RESET,
losing the reset state on LR or idle queues.

[ ... ]

> @@ -3592,8 +3612,12 @@ int xe_guc_exec_queue_memory_cat_error_handler(str=
uct xe_guc *guc, u32 *msg,
> =20
>  	trace_xe_exec_queue_memory_cat_error(q);
> =20
> -	/* Treat the same as engine reset */
> -	xe_guc_exec_queue_reset_trigger_cleanup(q);
> +	/*
> +	 * Starting the TDR here can send a scheduling-disable request before
> +	 * the context-reset notification arrives. Mark the queue reset and
> +	 * wake user-fence waiters, leaving that notification to trigger cleanu=
p.
> +	 */
> +	xe_guc_exec_queue_reset_trigger_cleanup(q, false);
> =20
>  	return 0;
>  }

[Severity: High]
Can skipping TDR here leave long-running (LR) queues stuck forever if GuC
does not follow the memory CAT error with a context-reset notification?

In guc_exec_queue_init(), queues on an LR-mode VM set timeout to
MAX_SCHEDULE_TIMEOUT, so drm_sched_start_timeout() never arms a fallback
TDR timer. If no XE_GUC_ACTION_CONTEXT_RESET_NOTIFICATION arrives,
guc_exec_queue_timedout_job() never runs: the context is never banned or
disabled in GuC, pending xe_sched_job entries remain on pending_list
holding their exec queue and runtime PM references, and callers waiting in
xe_wait_user_fence_ioctl() without an exec_queue_id (where q is NULL and
reset_status() is not checked) wake once on ufence_wq and go back to sleep
until their full timeout expires.

[1] https://sashiko.dev/#/bug/linux-449968a5-0b4a-4c5d-acd3-7ced29f0129b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116102020.1567=
127-1-arvind.yadav@intel.com?part=3D1
