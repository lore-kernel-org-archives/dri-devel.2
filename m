Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8E9CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 10:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5035110F45D;
	Fri, 12 Jun 2026 10:56:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jUT09DO3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E392D10F43B
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 10:56:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A8D8C4063F
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 10:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782161F000E9;
 Fri, 12 Jun 2026 10:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781261800;
 bh=0QgIPsrSN1hhANEaXwlX+8JHAZcTYFG5WUFpdRZ4NEo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jUT09DO35amoo5yNjbekq7dj5n91ZU4BH86/lJn9qxOS3eEhYYgEpnGnDBqmRlj0g
 X5wabzD05rohxG3Y5vXc41IpTcLeiqpeAESzO985xCb4QCMj25asX2G2R6cnlFSDFK
 8o1dVyTk3MLkxz4u+zTJUtu4WHJz/XZO+jUV8bYE7B18ur730ln5yPRqCc1rRvEpkz
 nYhQueEpmqO67GxgcDBtdGNbKaxNj8KEEQ/H06Y46vBh1THmGSmFN6j98yQ9eRPjy9
 4UviIJ5GEMUFTjdUYZZ36zPw3M7ll3XomFnCnRWjZxclNeoWgV3wgKBmT/+scRgvve
 5NIIepZ3q743A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] dma-buf/dma_fence: Make races for
 dma_fence_is_signaled() less likely
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612104251.2264707-2-phasta@kernel.org>
References: <20260612104251.2264707-2-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 10:56:39 +0000
Message-Id: <20260612105640.782161F000E9@smtp.kernel.org>
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
- [Critical] Moving the signaled bit update creates a window where `fence->=
ops` is cleared to NULL but the fence is not yet marked as signaled, causin=
g a NULL pointer dereference in lockless accessors.
- [High] Missing release memory barrier before setting the signaled bit, de=
feating the purpose of the patch on weakly-ordered architectures and riskin=
g use-after-free.
- [High] Delaying the signaled bit breaks the fast-path lockless check in `=
dma_fence_is_signaled()`, leading to lock contention, recursive deadlocks, =
and API contract violations.
--

commit 0ba6de5d00b831f763affe10965d5c591e6f0b5f
Author: Philipp Stanner <phasta@kernel.org>

dma-buf/dma_fence: Make races for dma_fence_is_signaled() less likely

This commit addresses a race condition where dma_fence_is_signaled() can
return true while fence callbacks are still executing. It delays setting
the DMA_FENCE_FLAG_SIGNALED_BIT until after the callbacks have completed,
instead of setting it at the beginning of dma_fence_signal_timestamp_locked=
().

> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -359,8 +359,19 @@ void dma_fence_signal_timestamp_locked(struct dma_fe=
nce *fence,
> =20
>  	dma_fence_assert_held(fence);
> =20
> -	if (unlikely(test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
> -				      &fence->flags)))
> +	/*
> +	 * First test the bit, so we don't signal an already signaled fence aga=
in.
> +	 * The lock protects against multiple parties setting the bit. The bit
> +	 * is then set at the end of the function.
> +	 *
> +	 * The background is that there is a fast path check in
> +	 * dma_fence_is_signaled() which does not use lock protection and can
> +	 * return true *while* the fence callbacks are still executing.
> +	 *
> +	 * This fast path check supposedly cannot be guarded by the lock because
> +	 * of significant performance regressions.
> +	 */
> +	if (unlikely(test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
>  		return;
> =20
>  	trace_dma_fence_signaled(fence);

[Severity: Critical]
Because the signaled bit is no longer set here, is there a risk of a NULL
pointer dereference for concurrent lockless readers?

Just below this in dma_fence_signal_timestamp_locked(), fence->ops can be
cleared:

    ops =3D rcu_dereference_protected(fence->ops, true);
    if (!ops->release && !ops->wait)
        RCU_INIT_POINTER(fence->ops, NULL);

With the signaled bit still false, could lockless accessors like
dma_fence_driver_name() see the unsignaled state and evaluate
ops->get_driver_name(fence) on the NULL ops pointer?

[ ... ]
> @@ -384,6 +395,9 @@ void dma_fence_signal_timestamp_locked(struct dma_fen=
ce *fence,
>  		INIT_LIST_HEAD(&cur->node);
>  		cur->func(fence, cur);
>  	}

[Severity: High]
If a callback executes while the signaled bit is still false, won't this
break the lockless fast-path check in dma_fence_is_signaled()?

If dma_fence_is_signaled() or dma_fence_timestamp() is called from within
a callback, the unsignaled state would cause dma_fence_timestamp() to hit
a WARN_ON(!test_bit(...)).

Additionally, dma_fence_is_signaled() would fall back to dma_fence_signal(),
which attempts to acquire the fence->lock. Since the lock is already held
by the current thread executing the callbacks, would this result in a
recursive deadlock?

> +
> +	// TODO: we need some barrier here, don't we?
> +	set_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);

[Severity: High]
Does this missing memory barrier reintroduce the use-after-free risk on
weakly-ordered architectures?

Since set_bit() does not imply a memory barrier, could the CPU reorder
this assignment to become globally visible before the memory writes perform=
ed
by the callbacks?

If a concurrent lockless reader using dma_fence_test_signaled_flag()
observes the bit as set but reads stale data, this might defeat the purpose
of the patch. Is an explicit smp_mb__before_atomic() needed here?

>  }
>  EXPORT_SYMBOL(dma_fence_signal_timestamp_locked);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612104251.2264=
707-2-phasta@kernel.org?part=3D1
