Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B16C55182
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 02:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB7110E099;
	Tue,  4 Aug 2026 02:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CaH9dm03";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C3310E099
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 02:38:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A241660A59;
 Tue,  4 Aug 2026 02:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7561F000E9;
 Tue,  4 Aug 2026 02:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785811113;
 bh=uXE2mI4T2ESMJSQ2FmZA0ZktRXDVFE+FkdNkSRd4gE0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CaH9dm038UyGvUux73Ak1bJhEQcOgakkMu/wEGemu4Xgz2sB+rlFy5tXKtMG7aspN
 ngSyw8cIEH+M5wcBOCOa+IiN08qh6KHgeXHcaOslSzZ7ENvK8XR92TnBaUGFAPVrl+
 DYAVBhlwNYrjppanecJjkUjTgWp/ekE9G8rZe2aWjCtpQp9q+XTOGnaNZJilL8gbQl
 R9fz6nnz4ek99Tte7rS+ZqkYyxpJN6e8zcqP4yOxSA6U2hZ0BdEiQn3yV6bRnyHs27
 zhW0r0Rn8wyKo7rAy6jgxDK/Jpw62n+RnL2frtRNNsxeHWdBlQuClI4wugiBYu+b98
 49EQfWPe4KaIQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] drm/xe: Capture devcoredump on TLB invalidation
 timeout
To: =?utf-8?b?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804021441.3054424-2-talesam@gmail.com>
References: <20260804021441.3054424-1-talesam@gmail.com>
 <20260804021441.3054424-2-talesam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 02:38:32 +0000
Message-Id: <20260804023833.3B7561F000E9@smtp.kernel.org>
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
- [High] Missing synchronization in `xe_tlb_inval_reset()` during device te=
ardown leaves the `fence_tdr` worker running after `xe_device` is freed, le=
ading to Use-After-Free.
- [High] Devcoredump snapshot worker `ss->work` is not explicitly canceled =
during device teardown if it hasn't run yet, leading to Use-After-Free.
--

--- Patch [1]: [RFC PATCH 1/3] drm/xe: Capture devcoredump on TLB invalidat=
ion timeout ---
commit cb8081669b45d5d264497cf1169cfc3a90d4aadd
Author: Tales A. Mendon=C3=A7a <talesam@gmail.com>

drm/xe: Capture devcoredump on TLB invalidation timeout
   =20
Adds a new xe_devcoredump_gt variant to capture GuC logs and CT state
for GT-level hangs, particularly hooking it into the TLB invalidation
timeout path.
   =20
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678

> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_=
devcoredump.c
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c

[ ... ]

> @@ -403,6 +403,74 @@ void xe_devcoredump(struct xe_exec_queue *q, struct =
xe_sched_job *job, const cha
>  	mutex_unlock(&coredump->lock);
>  }
> =20
> +static void devcoredump_snapshot_gt(struct xe_devcoredump *coredump,
> +				    struct xe_gt *gt)
> +{
> +	struct xe_devcoredump_snapshot *ss =3D &coredump->snapshot;
> +	struct xe_guc *guc =3D &gt->uc.guc;
> +	bool cookie;
> +
> +	ss->snapshot_time =3D ktime_get_real();
> +	ss->boot_time =3D ktime_get_boottime();
> +
> +	strscpy(ss->process_name, "no process");
> +
> +	ss->gt =3D gt;
> +	INIT_WORK(&ss->work, xe_devcoredump_deferred_snap_work);
> +
> +	/* keep going if fw fails as we still want to save the SW data */
> +	CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FORCEWAKE_ALL);
> +
> +	cookie =3D dma_fence_begin_signalling();
> +
> +	ss->guc.log =3D xe_guc_log_snapshot_capture(&guc->log, true);
> +	ss->guc.ct =3D xe_guc_ct_snapshot_capture(&guc->ct);
> +
> +	queue_work(system_dfl_wq, &ss->work);
> +

[Severity: High]
This is a pre-existing issue, but is it possible for this deferred work
to cause a use-after-free if the device is unbound before the worker runs?

If the device is unbound before xe_devcoredump_deferred_snap_work()
executes, xe_driver_devcoredump_fini() calls dev_coredump_put().
However, since the devcoredump device hasn't been registered yet,
dev_coredump_put() does nothing and xe_devcoredump_free() is not called:

drivers/gpu/drm/xe/xe_devcoredump.c:xe_driver_devcoredump_fini() {
        ...
        dev_coredump_put(drm->dev);
}

Since there is no explicit cancel_work_sync(&coredump->snapshot.work) when
the core dump hasn't been created, does this leave the worker queued on
system_dfl_wq to eventually wake up and dereference freed device memory?

> +	dma_fence_end_signalling(cookie);
> +}
> +

[ ... ]

> diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tl=
b_inval.c
> --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
> +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c

[ ... ]

> @@ -97,6 +107,16 @@ static void xe_tlb_inval_fence_timeout(struct work_st=
ruct *work)
>  		queue_delayed_work(tlb_inval->timeout_wq, &tlb_inval->fence_tdr,
>  				   timeout_delay);
>  	spin_unlock_irq(&tlb_inval->pending_lock);
> +
> +	/*
> +	 * Capture the GuC log and CT state so the firmware side of the hang
> +	 * can be inspected; there is no queue or job to blame here. Must be
> +	 * outside pending_lock as the capture takes sleeping locks.
> +	 */
> +	if (timedout_seqno)
> +		xe_devcoredump_gt(tlb_inval_to_gt(tlb_inval),
> +				  "TLB invalidation fence timeout, seqno=3D%d recv=3D%d",
> +				  timedout_seqno, tlb_inval->seqno_recv);

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free
during device teardown?

Looking at xe_tlb_inval_reset() in drivers/gpu/drm/xe/xe_tlb_inval.c, it
cancels the timeout worker using cancel_delayed_work() rather than
cancel_delayed_work_sync():

xe_tlb_inval_reset() {
        ...
        cancel_delayed_work(&tlb_inval->fence_tdr);
        ...
}

Since the cancellation is not synchronous and the worker is scheduled on
system_wq, the teardown can proceed and free the device memory while
xe_tlb_inval_fence_timeout() is still running.

If the worker drops pending_lock and executes this new call to
xe_devcoredump_gt(), won't it access the already freed tlb_inval outside
of the lock?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804021441.3054=
424-1-talesam@gmail.com?part=3D1
