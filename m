Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C7FC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16C410E0C9;
	Mon, 21 Sep 2026 18:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l9cggEwm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA6C10E0C9;
 Mon, 21 Sep 2026 18:33:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 81B7460008;
 Mon, 21 Sep 2026 18:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDD11F000FF;
 Mon, 21 Sep 2026 18:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790015604;
 bh=5nxDQ/4UntL2urb45XOKI69w5u7JlAvfbWn6zqpqiv0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l9cggEwmsf70Rbt4pViug11tDr4UdjlgeyM/bLDJUHzP1Jflg6qoSJzfOd3eF450v
 J+y+25Xk+lKC2eYoF7W276RfeCUb84Kkdu5S2/KurEgucNf5uemWjqCOJhn6Ya+TJo
 7bhTIyy6XO2DG2CEaPDnIbG7kdzacLPovtd/HUg4Ta7hiEr536z+32dtWlXfhIF362
 VRQgKCbWfZ8+z5/Jitz1h50GxAZkze2WF6wdoX905wyQAuWx1SOFB038oxjZ+PWCSA
 5AbSgWTY9kxqU4X53izDnPC/337TUKCbnLgxfgR8woL0HfI9rqSKuQlwbj4iq/OEgw
 6I0VmaH6RTObw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] drm/xe: Capture devcoredump on TLB invalidation
 timeout
To: =?utf-8?b?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260921182121.308217-2-talesam@gmail.com>
References: <20260921182121.308217-1-talesam@gmail.com>
 <20260921182121.308217-2-talesam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:33:23 +0000
Message-Id: <20260921183324.0DDD11F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/xe: MMIO access without PM reference in devcoredump on TLB tim=
eout
--

commit a463de937c804fe9be7ed86bfbfa297e4f35c466
Author: Tales A. Mendon=C3=A7a <talesam@gmail.com>

drm/xe: Capture devcoredump on TLB invalidation timeout

This commit adds xe_devcoredump_gt() to capture the GuC log and CT state
for GT-level hangs that are not tied to a specific queue or job. It then
hooks this capture mechanism into the TLB invalidation timeout path. This
helps in diagnosing firmware stalls where the invalidation request was
consumed but the ack was delayed.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678

> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_=
devcoredump.c
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
[ ... ]
> @@ -323,40 +318,44 @@ static void devcoredump_snapshot(struct xe_devcored=
ump *coredump,
>  				 struct xe_gt *gt,
>  				 struct xe_exec_queue *q,
>  				 struct xe_sched_job *job)
>  {
[ ... ]
>  	/* keep going if fw fails as we still want to save the memory and SW da=
ta */
> -	CLASS(xe_force_wake, fw_ref)(gt_to_fw(q->gt), XE_FORCEWAKE_ALL);
> +	CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FORCEWAKE_ALL);

[Severity: High]
If this capture path is reached without holding a PM runtime reference, does
acquiring the forcewake here attempt MMIO accesses while the device is in a
low-power state? Accessing MMIO registers when the device has entered
autosuspend (D3cold) typically causes unhandled PCIe errors or system
crashes.

[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tl=
b_inval.c
> --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
> +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
[ ... ]
> @@ -90,13 +98,27 @@ static void xe_tlb_inval_fence_timeout(struct work_st=
ruct *work)
>  			"TLB invalidation fence timeout, seqno=3D%d recv=3D%d",
>  			fence->seqno, tlb_inval->seqno_recv);
> =20
> +		timedout_seqno =3D fence->seqno;
> +
>  		fence->base.error =3D -ETIME;
>  		xe_tlb_inval_fence_signal(fence);

[Severity: High]
Can this sequence drop the last PM runtime reference before the devcoredump
is captured?

Looking at xe_tlb_inval_fence_signal(), it calls xe_tlb_inval_fence_fini()
which drops the PM runtime reference (xe_pm_runtime_put). If this was the
last active reference, the device could begin autosuspending.

>  	}
>  	if (!list_empty(&tlb_inval->pending_fences))
>  		queue_delayed_work(tlb_inval->timeout_wq, &tlb_inval->fence_tdr,
>  				   timeout_delay);
> +	seqno_recv =3D tlb_inval->seqno_recv;
>  	spin_unlock_irq(&tlb_inval->pending_lock);
> +
> +	/*
> +	 * Capture the GuC log and CT state so the firmware side of the hang
> +	 * can be inspected; there is no queue or job to blame here. Must be
> +	 * outside pending_lock as the capture takes sleeping locks, hence
> +	 * @seqno_recv is sampled above while the lock is still held.
> +	 */
> +	if (timedout_seqno)
> +		xe_devcoredump_gt(tlb_inval_to_gt(tlb_inval),
> +				  "TLB invalidation fence timeout, seqno=3D%d recv=3D%d",
> +				  timedout_seqno, seqno_recv);

Since the PM reference was dropped earlier in the loop, would this call to
xe_devcoredump_gt() proceed without holding one? If the thread gets
preempted long enough for the autosuspend delay to expire, the forcewake
operation inside devcoredump_snapshot() might hit the hardware while it is
unpowered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921182121.3082=
17-1-talesam@gmail.com?part=3D1
