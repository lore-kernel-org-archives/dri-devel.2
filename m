Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5632CCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8519110E61C;
	Mon, 12 Oct 2026 17:28:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9199C10E61C
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 17:28:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FC0C412D2;
 Mon, 12 Oct 2026 17:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE941F0089B;
 Mon, 12 Oct 2026 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791826102;
 bh=/zqB14m/WUapRicILRGVEdKBbN7cNJ6/tcYq3qR4AAo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mJx4k+9ojLRGF41nCCUzrOEwvw7oIgI5ZKRvCSBxxMtBHnc8Wh3vUdxePvRsq7uFs
 bRo7UxOEbrJnWskVmTNxUENLqYtKtm+mCJgAaAGCaWCGy5hF/QZ7v/WP72L+yF0qQ8
 oNkr19LPkhr4YI00C7WOTGhdJamhSBnmwTBejmL8fnsqDsS93j9lD5GP7c5P/tzxf/
 CsusAfNKbLSoaNlCS2XnuKAa2frk3GhiG6vIkxNr6sg+3023O9RMnsA+k+g65/lcgP
 NlgLu1eUQvkxVO+VF04huWyum9x5K77EZETIBWkYFcK+1DtO9yoUYk5a443LUE0FLy
 HWmWP2kQAxxKg==
Message-ID: <sashiko-outbox-168456@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dma-buf/dma-fence: Mark two callbacks as deprecated
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261012171939.390365-2-phasta@kernel.org>
References: <20261012171939.390365-2-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:28:21 +0000
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
- [High] dma-fence: @release deprecation advice causes UAF/SLAB corruption =
for embedded fences
- [Low] dma-fence: Missing @wait callback alternative documentation
--

commit 491d04795e6f38b069b06a9246cd098fdc0a8b55
Author: Philipp Stanner <phasta@kernel.org>

dma-buf/dma-fence: Mark two callbacks as deprecated

This commit marks the ops->wait() and ops->release() callbacks in
dma_fence_ops as deprecated. It updates the documentation to advise against
implementing them, aiming to move towards a design that supports driver
unloading in all circumstances.

> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3b..388c07d11e708 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -220,6 +220,8 @@ struct dma_fence_ops {
>  	/**
>  	 * @wait:
>  	 *
> +	 * DEPRECATED!
> +	 *
>  	 * Custom wait implementation, defaults to dma_fence_default_wait() if
>  	 * not set.

[Severity: Low]
The commit message indicates it will "document what users should do instead"
for both ops->release() and ops->wait(). However, while instructions are
provided for @release, the alternative implementation details for @wait seem
to be missing here.

Could documentation be added to explain what developers should use instead
of the @wait callback?

[ ... ]

> @@ -243,6 +245,8 @@ struct dma_fence_ops {
>  	/**
>  	 * @release:
>  	 *
> +	 * DEPRECATED!
> +	 *
>  	 * Called on destruction of fence to release additional resources.

[ ... ]

>  	 * If the callback is implemented the memory backing the dma_fence
>  	 * object must be freed RCU safe.
> +	 *
> +	 * Deprecated because it prevents the producer of a fence from
> +	 * unloading. No new users must be implemented. Parties with a
> +	 * hypothetical need for this callback can instead simply and directly
> +	 * perform their custom release operations one RCU grace period after
> +	 * they have signaled the fence.
>  	 */
>  	void (*release)(struct dma_fence *fence);

[Severity: High]
Does this advice correctly account for embedded dma_fence objects?

If a driver embeds struct dma_fence inside a driver-specific container,
removes its .release callback to comply with this documentation, and frees
the container one RCU grace period after signaling, could this cause a
use-after-free for consumers still holding a long-term reference like
dma_resv?

Alternatively, if a driver simply omits .release to follow the "no new
users" guidance without changing its allocation strategy, the core will
execute dma_fence_free() on the final dma_fence_put(). This fallback
executes kfree_rcu() directly on the fence pointer. If the fence is
embedded and not placed at offset 0, passing an interior pointer to
kfree_rcu() can corrupt the SLAB allocator.

Would it make sense to update the documentation to explicitly warn that
omitting .release requires the dma_fence to either be a standalone
allocation or placed at offset 0 within its container?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012171939.3903=
65-2-phasta@kernel.org?part=3D1
