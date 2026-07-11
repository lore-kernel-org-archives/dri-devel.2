Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FABAC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1746D10E70B;
	Sat, 11 Jul 2026 03:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F/UiwZmC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B56FD10E70B
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:18:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 82B624379E;
 Sat, 11 Jul 2026 03:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CAA1F000E9;
 Sat, 11 Jul 2026 03:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783739928;
 bh=Ymlq4/mxPl1TkS/VBFhY9xs7LqaWhmbIoZDt2+pPhb0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F/UiwZmClPN3ZmXc/LKTbETDukoRmrVwzwaBzgPufF5XvX6l8DppFUsUAjh8JJeJG
 niKmOJj/bUPianzGw6znvktS6Tw55AY5FbxcYnCdRH2vpYk95CkC8+mz52MUNKPeGW
 JH3uKx+mO6BIGIZa17MYTRj5zig0YMjx2vTBdMs21nBOdqK8wpHquhFZ3GHf2y9Ngm
 0MB4j1IsIzLO4AkEE+LaC8lLmGUp8LNn7GjyzFANfE3Uvf/kMrYW1kpK/XYYb55JaK
 lGWYUxtwDgfAhvpVYeKxffmuR4rfWOGCWr1aAIEdF6jBCMJfwoSyIJXLbHaDJCo3cm
 Y8kv0/gZOPQNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 20/33] drm/xe: Add a page defragmentation worker
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-21-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-21-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:18:47 +0000
Message-Id: <20260711031848.33CAA1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The defrag worker can be scheduled during probe teardown but i=
s never canceled if probe fails early, leading to a UAF of the `xe_device`.
- [High] The defrag worker continuously polls at a high frequency (40Hz / 2=
5ms) while the device is runtime-suspended or idle, causing significant pow=
er regression.
- [High] The defrag worker enters an infinite 40Hz retry loop on the same B=
O when memory is fragmented, bypassing exponential backoff.
--

--- Patch [20]: [PATCH v3 20/33] drm/xe: Add a page defragmentation worker =
---
commit 1f23cf5472cb7a98f4987467477a919155eb0dc0
Author: Matthew Brost <matthew.brost@intel.com>
Subject: drm/xe: Add a page defragmentation worker

This patch adds a delayed worker to the DRM XE driver to periodically
defragment buffer objects whose backing TT pages were allocated below the
optimal order. It bounds the work done per run and applies exponential
backoff on failures.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
[ ... ]
> +static void xe_bo_defrag_worker(struct work_struct *w)
> +{
[ ... ]
> +	if (!drm_dev_enter(&xe->drm, &idx))
> +		return;
> +
> +	if (!xe_pm_runtime_get_if_in_use(xe)) {
> +		/*
> +		 * The device is (runtime) suspending/suspended. Reschedule so
> +		 * the pass retries once it is active again: the enqueue-time
> +		 * kick in xe_bo_defrag_add() only fires on an empty->non-empty
> +		 * transition, so it will not re-arm the worker while the list
> +		 * is still non-empty. Requeue here to avoid stranding tracked
> +		 * BOs. The get attempt does not resume the device, so this is
> +		 * just a lightweight CPU-side timer while suspended.
> +		 */
> +		if (atomic_read(&xe->mem.defrag.count))
> +			xe_bo_defrag_schedule(xe);
> +		drm_dev_exit(idx);
> +		return;
> +	}

[Severity: High]
Will this cause the worker to endlessly poll at a high frequency while the
device is suspended?

Looking at xe_bo_defrag_worker() in xe_bo.c, when the device is runtime
suspended, xe_pm_runtime_get_if_in_use(xe) returns false. The worker then
hits this early return path and schedules itself via
xe_bo_defrag_schedule(xe) if the defrag count is non-zero.

Since this rescheduling uses the current interval_ms (which is typically
25ms) and applies no backoff, the worker will repeatedly wake up the CPU
every 25ms (40Hz) endlessly while the device is suspended, preventing deep
sleep C-states.

> +
> +	/*
> +	 * Process at most XE_BO_DEFRAG_SIZE_LIMIT bytes of newly (re)allocated
[ ... ]
> +		if (ret || needs_more) {
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
> +
> +			xe_bo_put(bo);
> +			requeue =3D true;
> +			break;
> +		}

[Severity: High]
Does this create an infinite 40Hz retry loop on the same BO when memory is
fragmented, bypassing the exponential backoff?

When xe_bo_defrag_one() successfully satisfies an allocation using
lower-order pages, ret is 0 but needs_more is true. In this block, because
ret is 0, the else branch resets the interval_ms to 25ms, and the loop
breaks with requeue set to true.

Since the BO is never moved to the back of the list or removed, it remains
at the head. On the next run in 25ms, the worker attempts to defrag the
exact same BO again, likely hitting the exact same fragmentation fallback,
and reschedules at 25ms again.

> +
> +		xe_bo_put(bo);
> +	}
[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_devic=
e.c
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
[ ... ]
> @@ -1069,6 +1069,15 @@ int xe_device_probe(struct xe_device *xe)
>  			return err;
>  	}
> =20
> +	/*
> +	 * Register the defrag worker teardown now that the migrate contexts it
> +	 * depends on are initialized, so devm's reverse-order cleanup stops the
> +	 * worker before those contexts are torn down.
> +	 */
> +	err =3D xe_bo_defrag_init(xe);
> +	if (err)
> +		return err;

[Severity: Critical]
Is there a use-after-free risk if the device probe fails before this point?

The devm action to cleanly cancel the worker (xe_bo_defrag_init) is
registered late in xe_device_probe(). If the probe fails before this
registration (e.g., during xe_display_init_early() or xe_gt_init()), the
devm teardown will unpin BOs.

Unpinning a BO calls xe_bo_unpin() -> xe_bo_defrag_update(), which can
schedule the worker. Because the devm cleanup action was never registered,
the worker won't be cancelled during teardown, leaving it active after the
xe struct is freed.

> +
>  	err =3D xe_pagefault_init(xe);
>  	if (err)
>  		return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D20
