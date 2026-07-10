Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80624C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E476710F998;
	Fri, 10 Jul 2026 22:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aO8XyCKD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 216A910F998
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:24:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DF23F43942;
 Fri, 10 Jul 2026 22:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CEC1F000E9;
 Fri, 10 Jul 2026 22:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783722245;
 bh=mj06Yu/K+ReXPYYN0deQmi3+WUTtPW2XpRSH3L4BMl8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aO8XyCKDIBAjeaGB4fC9ZrhGhSTN3vH+5t/EyJtq+SgOuFrFiFANkIOUJIZE7O7qi
 UQ1yIsMm6eKxoU77hMSnT+k0mipbYwfqpBLq4cgO1SGuGZbiTDKGy94uMi7DSmdBcJ
 E8aCd42qKsq3mF6cjk4QaJ8Uvy9oo5Gmz/6r2S6VTM3VyM/TCRs2WEfSAW8y5YGlTm
 E78BNLDT36wv6Ak5F1ZSoJX0E4r6M8ZQFmyO4Wx4EsznJPSOeR0zq9g4uzXDfsy55y
 rzop7wgZ5jO94lGt11mPeFns67YycmSA8ds4ksZfw8Bv7nopoEafITe0RuDMiy473M
 CHQb+5k8ZjhyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/33] drm/xe: Add a page defragmentation worker
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-21-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-21-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:24:04 +0000
Message-Id: <20260710222405.A1CEC1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Accessing `bo->ttm.ttm` outside of the BO's dma-resv lock can =
cause a NULL pointer dereference or data race.
- [Critical] The defrag delayed worker can be scheduled during device probe=
 before its teardown is registered, leading to a UAF if the probe fails.
- [High] The defrag worker permanently stalls if the device enters runtime =
suspend.
- [High] The defrag worker fails to apply exponential backoff on sub-optima=
l fallback, causing an infinite spin loop.
--

--- Patch [20]: [PATCH v2 20/33] drm/xe: Add a page defragmentation worker =
---
commit 7f5402dce2516caf0e93f47b50a3f18b01fe034e
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Add a page defragmentation worker
   =20
This patch adds a per-device defrag list and delayed worker to track and
reallocate BOs whose backing TT pages were allocated below the device's
beneficial order. The worker runs periodically and attempts to re-back BOs
with beneficial-order pages, up to a maximum size budget per run.

> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
[ ... ]
> @@ -1271,6 +1364,96 @@ static void xe_bo_defrag_worker(struct work_struct=
 *w)
>  	struct delayed_work *dwork =3D to_delayed_work(w);
>  	struct xe_device *xe =3D
>  		container_of(dwork, struct xe_device, mem.defrag.worker);
>  	u64 defrag_bytes =3D 0;
>  	bool requeue =3D false;
>  	int idx;
> =20
>  	if (!drm_dev_enter(&xe->drm, &idx))
>  		return;
> =20
>  	if (!xe_pm_runtime_get_if_in_use(xe)) {
>  		drm_dev_exit(idx);
>  		return;
>  	}

[Severity: High]
Does the defrag worker permanently stall if the device enters runtime suspe=
nd?

If the worker executes while the device is suspending,
xe_pm_runtime_get_if_in_use() returns false and the worker exits immediately
without rescheduling itself.

Because the list is not emptied, subsequent additions to the list in
xe_bo_defrag_add() will not see an empty-to-non-empty transition, meaning
xe_bo_defrag_schedule() will never be called again.

[ ... ]
> +		ret =3D xe_bo_defrag_one(xe, bo, XE_BO_DEFRAG_SIZE_LIMIT - defrag_byte=
s,
> +				       &consumed);
> +		defrag_bytes +=3D consumed;
> +
> +		if (ret || ttm_tt_is_beneficial_order_failed(bo->ttm.ttm)) {

[Severity: Critical]
Can accessing bo->ttm.ttm here cause a NULL pointer dereference?

The xe_bo_defrag_one() function releases the BO's dma-resv lock before it
returns. If a concurrent operation, such as evicting to VRAM or swapping ou=
t,
destroys the TT while the BO is unlocked, checking
ttm_tt_is_beneficial_order_failed(bo->ttm.ttm) might dereference a NULL
pointer.

> +			scoped_guard(spinlock, &xe->mem.defrag.lock) {
> +				if (ret)
> +					/*
> +					 * Abort the pass and retry the whole
> +					 * list later, backing off exponentially
> +					 * on every failure.
> +					 */
> +					xe->mem.defrag.interval_ms =3D
> +						min(xe->mem.defrag.interval_ms * 2,
> +						    (unsigned int)XE_BO_DEFRAG_INTERVAL_MAX_MS);
> +				else
> +					/* Progress, reset interval */
> +					xe->mem.defrag.interval_ms =3D XE_BO_DEFRAG_INTERVAL_MS;
> +			}

[Severity: High]
Does the backoff logic fail to apply when a fallback allocation succeeds?

If system memory is highly fragmented, the TTM pool allocator might fail to
allocate beneficial-order pages but successfully fall back to a smaller ord=
er.
In this case, xe_bo_defrag_one() returns 0 for success, but
ttm_tt_is_beneficial_order_failed() remains true.

The backoff block checks if (ret). Since ret is 0, it takes the else branch,
interprets the run as progress, and resets the interval to 25ms. This could
result in a tight loop of repeated failed upgrades that wastes CPU time wit=
hout
ever backing off.

> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
[ ... ]
> @@ -1063,6 +1063,15 @@ int xe_device_probe(struct xe_device *xe)
>  			return err;
>  	}
> =20
> +	/*
> +	 * Register the defrag worker teardown now that the migrate contexts it
> +	 * depends on are initialized, so devm's reverse-order cleanup stops the
> +	 * worker before those contexts are torn down.
> +	 */
> +	err =3D xe_bo_defrag_init(xe);

[Severity: Critical]
Can the delayed worker outlive the device if probe fails before the teardown
is registered?

During early probe, components might allocate BOs. If these BOs fail to get
beneficial order pages, they are added to the defrag list, which schedules
the delayed worker via xe_bo_defrag_schedule().

If a probe step fails before reaching this late xe_bo_defrag_init() call,
the devm cleanup will roll back and free the device without cancelling the
worker. When the timer expires, the worker will access freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D20
