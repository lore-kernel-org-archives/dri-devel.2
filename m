Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355E2C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 749AA10E80C;
	Wed, 23 Sep 2026 15:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kL2rrf4l";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 368F010E80C
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:13:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6515E600AA;
 Wed, 23 Sep 2026 15:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CFA1F000FF;
 Wed, 23 Sep 2026 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790176437;
 bh=HjtMDyGnAkfOBFh2gCpCVa3rruaToQCHTBZYqd603hc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kL2rrf4l8d8Nd7spL/Qv6L6NdtX1GHqjvmOB5+D4huh/H+cE67LMnAt+FIIQysSEn
 HE1MbRvRpBC3MMnVSfVGfpI/sJPCHLJHzVoVZZ9S1mviSNH4XqG/8gLyAjQ8CrwWGm
 ITYhfQt/xAPHXniaqEvt3GsRXTmvxQi2mCFU8eAcY/ZWihslpNVZvmiO5WnvMnG8vj
 MocuD/rwwVheoZix4p3hegfotgjnoV6vaGS3L4+FJd0XQi80TBLA5znq9qhmzO7HAu
 r3PHZOWNYJ1Nxhv5s2yceKZHPk1k1Xp5rGg89WFTNqppRiv2qRVNHBoCvJyCkBO+Fc
 eaZXBcYtG1DTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dma-buf/dma-fence: Mark two callbacks as deprecated
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260923150308.1294592-2-phasta@kernel.org>
References: <20260923150308.1294592-2-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 15:13:56 +0000
Message-Id: <20260923151356.E5CFA1F000FF@smtp.kernel.org>
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
- [High] dma-buf: UAF race condition trap in ops->release deprecation doc
- [High] dma-buf: strict memory layout constraint imposed by ops->release d=
eprecation
- [Low] dma-buf: misleading wait callback documentation for consumers
--

commit ee4b5cb11d9ee9ea134098d9b200f3aba6ab22fe
Author: Philipp Stanner <phasta@kernel.org>

dma-buf/dma-fence: Mark two callbacks as deprecated

This commit deprecates the dma_fence ops->release() and ops->wait()
callbacks to facilitate driver-unload support. It adds documentation to
guide users away from implementing these callbacks and suggests alternative=
s.

> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3b..59af0159cd258 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h

[ ... ]

> @@ -236,6 +238,10 @@ struct dma_fence_ops {
>  	 * Implementing this callback prevents the fence from detaching after
>  	 * signaling and so it is necessary for the module providing the
>  	 * dma_fence_ops to stay loaded as long as the dma_fence exists.
> +	 *
> +	 * Deprecated for the reason mentioned above. No new users must be
> +	 * implemented. Consumers of a fence can instead notify themselves by
> +	 * registering a callback on the fence.
>  	 */

[Severity: Low]
Is this advice to consumers accurate? Consumers typically call the frontend
dma_fence_wait() function.

If the producer drops the ops->wait callback, dma_fence_wait() automatically
falls back to dma_fence_default_wait(), which handles registering
dma_fence_default_wait_cb natively.

It seems consumers do not need to change their code or manually register
callbacks, but this documentation instructs them to reinvent the core's
default wait logic.

>  	signed long (*wait)(struct dma_fence *fence,
>  			    bool intr, signed long timeout);
> @@ -243,6 +249,8 @@ struct dma_fence_ops {
>  	/**
>  	 * @release:
>  	 *
> +	 * DEPRECATED!
> +	 *
>  	 * Called on destruction of fence to release additional resources.
>  	 * Can be called from irq context.  This callback is optional. If it is
>  	 * NULL, then dma_fence_free() is instead called as the default

[Severity: High]
Does forbidding new implementations of ops->release() impose an unstated
memory layout constraint?

If a driver omits ops->release(), dma_fence_release() automatically falls
back to dma_fence_free(), which calls kfree_rcu(fence, rcu).

The kfree_rcu() function requires the exact base pointer returned by the
allocator. Drivers commonly embed struct dma_fence inside a larger custom
structure.

If the fence is at a non-zero offset, passing its pointer to kfree_rcu()
will attempt to free an interior pointer, which can corrupt the memory
allocator.

Could this default behavior be problematic without warning developers about
this layout requirement?

> @@ -254,6 +262,12 @@ struct dma_fence_ops {
>  	 *
>  	 * If the callback is implemented the memory backing the dma_fence
>  	 * object must be freed RCU safe.
> +	 *
> +	 * Deprecated because it prevents the producer of a fence from
> +	 * unloading. No new users must be implemented. Parties with a
> +	 * hypothetical need for this callback can instead simply and directly
> +	 * perform their custom release operations one RCU grace period after
> +	 * they have signaled the fence.
>  	 */

[Severity: High]
Could this suggested cleanup pattern lead to a use-after-free?

Signaling a fence does not guarantee all kref references are dropped,
as consumers like sync_file or other drivers might still hold references.

If a producer frees the containing structure asynchronously after signaling
instead of waiting for the kref to reach zero, any consumer that subsequent=
ly
calls dma_fence_put() will trigger dma_fence_release() on freed memory.

Even if the structure is left to dma_fence_free(), tearing down associated
sub-resources before kref reaches zero creates race conditions with
consumers.

>  	void (*release)(struct dma_fence *fence);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923150308.1294=
592-2-phasta@kernel.org?part=3D1
