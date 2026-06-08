Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF3CCD8CAA
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF6F910F520;
	Mon,  8 Jun 2026 14:43:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mX/JpbM3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A9C10F521
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:43:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3BE4840A55
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94611F00A05;
 Mon,  8 Jun 2026 14:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929798;
 bh=SiOz+EaWQLpTNnWUBed/5uaugQ1N9TW/odXdDg4bV4M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mX/JpbM3gF+YZWlzAZb/nNlVGDn3xt6Bc3QW++Hb/LOntTh+SH0RpDUGWKuLaV41N
 lmiHjBSiq9daZtI7WOtZ0V4pamMjzuz4bCj9ud7D8RwiYCEAI5nOIpr/Qzz/G+aloZ
 g2gWhOA2Fhjp8r25Ok4Jhe8c+K3wpiaymfkVDPOo9ZH3CAhej8mGfjlDPuocSTz3V0
 iCfYivr9Yy0Q76a2JnsG4dkKowkKPSYYfdZ+oyakmHJIdZ5OTNwC/7tK8lclvDzpGc
 Wzi0bQJKVM4YTw8LdcJQJ/fw+Da144+ZhimC6jrW3ta954aEkkofFEuBYInDtojt7o
 1cyv6u9MH1d7w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] dma-fence: Fix races of fence callbacks versus
 destructors by locking
To: "Philipp Stanner" <phasta@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260608142436.265820-2-phasta@kernel.org>
References: <20260608142436.265820-2-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 14:43:17 +0000
Message-Id: <20260608144317.E94611F00A05@smtp.kernel.org>
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
- [High] Double acquisition of the fence spinlock in `__dma_fence_enable_si=
gnaling` causes an unconditional self-deadlock.
- [High] Acquiring the fence spinlock in `dma_fence_set_deadline` causes de=
adlocks with backend drivers.
--

commit a0ed8f208472e7d15328c05be3bdfe3b20342e3b
Author: Philipp Stanner <phasta@kernel.org>

dma-fence: Fix races of fence callbacks versus destructors by locking

This patch modifies dma-fence backend operations to take the fence lock
before executing callbacks. This aims to prevent races between a driver
signaling a fence and freeing its resources while a callback is accessing
driver-specific data.

> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
[ ... ]
> @@ -629,7 +629,8 @@ EXPORT_SYMBOL(dma_fence_free);
>  static bool __dma_fence_enable_signaling(struct dma_fence *fence)
>  {
[ ... ]
>  	if (!was_set && ops && ops->enable_signaling) {
>  		trace_dma_fence_enable_signal(fence);
> =20
> -		if (!ops->enable_signaling(fence)) {
> +		dma_fence_lock_irqsave(fence, flags);
> +		success =3D ops->enable_signaling(fence);
> +		dma_fence_unlock_irqrestore(fence, flags);
> +		if (!success) {

[Severity: High]
Will this cause an unconditional deadlock?

Looking at the beginning of __dma_fence_enable_signaling(), there is a
dma_fence_assert_held(fence) check, meaning the fence spinlock is already
held when entering this function.

Since standard Linux spinlocks are not recursive, won't attempting to
acquire the same lock a second time here immediately deadlock the CPU?

[ ... ]
> @@ -1020,11 +1024,20 @@ EXPORT_SYMBOL(dma_fence_wait_any_timeout);
>  void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>  {
[ ... ]
> +	dma_fence_lock_irqsave(fence, flags);
> +	if (!dma_fence_is_signaled_locked(fence))
>  		ops->set_deadline(fence, deadline);
> +
> +	dma_fence_unlock_irqrestore(fence, flags);
>  	rcu_read_unlock();
>  }

[Severity: High]
Could taking the lock around this callback cause deadlocks with backend
drivers?

Historically this callback was invoked unlocked, and multiple backend
implementations (such as drm_sched_fence_set_deadline_finished or
msm_fence_set_deadline) explicitly acquire the fence spinlock internally.

If the core now calls them with the lock already held, it appears they will
deadlock trying to acquire the non-recursive lock again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608142436.2658=
20-2-phasta@kernel.org?part=3D1
