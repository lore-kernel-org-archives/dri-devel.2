Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B536606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DcqbUlmU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73AF810E029;
	Tue, 10 Nov 2026 16:43:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D0010E029
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:43:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B547340C2B
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710F01F0089F;
 Tue, 10 Nov 2026 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794329032;
 bh=zsab9H8XoGewsLDmLphXph8qD76A8Gtu3Pfwh3iF9Xo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DcqbUlmUevRw8GDAKd1be51hgcXWWf9XhRYAALpAzSoGPZkhGa6PnwABkM89EaDFa
 8aBzE+WnHBJRq7+gINbKhMxbSy7CUTZtihFnkhuCnNVgO+3XmfuMJValvFHwb034Bd
 JplzAp4AZBG4QfBiEpUbiWTHLPp34/gntUCGQ63TdQlvj6pcjyKanleUKKHLa590V8
 A0wHAqweMgJpPJK5G1QFVLCpsROo+tN91OnZ2wEXEFtnlpVkGwANZfJ9cyV8wxwFED
 TQnM0UHAVQDB0efkRR2Y6fJ+38FVay807PrmWe5sSufoXxp28YfJrH2beF6q1wnQbZ
 Z22wMcLIYm09g==
Message-ID: <sashiko-outbox-207402@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] dma-buf/dma-fence: Close race window against error
 checks
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110155817.1492359-3-phasta@kernel.org>
References: <20261110155817.1492359-3-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:43:51 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Critical] dma-buf/dma-fence: recursive lock deadlock in
  dma_fence_is_signaled()
- [Critical] dma-buf/dma-fence: extern_lock UAF in
  dma_fence_is_signaled() after signal
- [Medium] dma-buf/dma-fence: redundant IO rmb() in
  dma_fence_is_signaled_locked()
--

commit 9ba8604395f23b0369fb06fa36c061d180ce127f
Author: Philipp Stanner <phasta@kernel.org>

dma-buf/dma-fence: Close race window against error checks

This commit adds an rmb() to dma_fence_is_signaled_locked() and acquires the
fence spinlock in dma_fence_is_signaled() to order signaled-flag checks
against subsequent reads of fence->error.

Link: https://lore.kernel.org/dri-devel/20261020100034.759183-2-phasta@kern=
el.org/

> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3b..fe6fbc5a5a35d 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -517,8 +517,18 @@ static inline bool
>  dma_fence_is_signaled_locked(struct dma_fence *fence)
>  {
>  	const struct dma_fence_ops *ops;
> +	bool signaled;
> =20
> -	if (dma_fence_test_signaled_flag(fence))
> +	signaled =3D dma_fence_test_signaled_flag(fence);
> +	/*
> +	 * Whoever holds the lock might next try to obtain the fence's error
> +	 * code - but there is no ordering between reading the signaled flag
> +	 * and the reading of the error code.
> +	 *
> +	 * Order properly with rmb() since fences might be involved in IO.
> +	 */
> +	rmb();
> +	if (signaled)
>  		return true;
> =20
>  	rcu_read_lock();

[Severity: Medium]
Why is a mandatory I/O rmb() executed unconditionally here, even when
signaled is false and the caller already holds the fence spinlock?

Because dma_fence_signal_timestamp_locked() sets DMA_FENCE_FLAG_SIGNALED_BIT
with test_and_set_bit() under the same spinlock, a reader holding that lock
is already ordered against any prior dma_fence_set_error() once the bit is
observed set, and running rmb() before checking if (signaled) adds a heavy
I/O barrier to every unsignaled check in dma_fence_get_status().  Meanwhile,
because dma_fence_test_signaled_flag() still uses relaxed test_bit() instead
of test_bit_acquire(), lockless callers such as the -ENOENT fast path in
dma_fence_add_callback() remain unordered when callers like
dma_fence_array_enable_signaling() immediately read fence->error.

> @@ -553,9 +563,17 @@ static inline bool
>  dma_fence_is_signaled(struct dma_fence *fence)
>  {
>  	const struct dma_fence_ops *ops;
> +	unsigned long flags;
> =20
> -	if (dma_fence_test_signaled_flag(fence))
> +	/*
> +	 * Take the lock to order against people reading the fence's error code.
> +	 */
> +	dma_fence_lock_irqsave(fence, flags);
> +	if (dma_fence_test_signaled_flag(fence)) {
> +		dma_fence_unlock_irqrestore(fence, flags);
>  		return true;
> +	}
> +	dma_fence_unlock_irqrestore(fence, flags);
> =20
>  	rcu_read_lock();
>  	ops =3D rcu_dereference(fence->ops);

[Severity: Critical]
Does taking the fence spinlock in dma_fence_is_signaled() cause a recursive
spinlock deadlock when signaling is enabled on an AMDKFD eviction fence?

dma_fence_enable_signaling() and dma_fence_add_callback() acquire the fence
spinlock before calling __dma_fence_enable_signaling(), which invokes
ops->enable_signaling() with the lock held and interrupts disabled:

  dma_fence_enable_signaling()
    dma_fence_lock_irqsave(fence, flags)
    __dma_fence_enable_signaling(fence)
      amdkfd_fence_enable_signaling(fence)
        dma_fence_is_signaled(fence)
          dma_fence_lock_irqsave(fence, flags)  <-- spins forever

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c:amdkfd_fence_enable_signal=
ing() {
	struct amdgpu_amdkfd_fence *fence =3D to_amdgpu_amdkfd_fence(f);

	if (!fence)
		return false;

	if (dma_fence_is_signaled(f))
		return true;
    ...
}

Any wait, callback registration, or TTM eviction on an unsignaled AMDKFD
fence will lock up the CPU.

[Severity: Critical]
Can taking the fence spinlock before testing DMA_FENCE_FLAG_SIGNALED_BIT
cause a use-after-free on fence->extern_lock when querying an already
signaled fence?

As documented in "Safe external access to driver provided object members" in
include/linux/dma-fence.h, data not embedded in struct dma_fence, including
the external spinlock passed to dma_fence_init(), must not be accessed after
the fence has signaled because drivers may free the lock container once the
fence signals and an RCU grace period elapses:

  CPU0                              CPU1
  ffs_dmabuf_signal_done()
    dma_fence_signal(&fence->base)
  ffs_dmabuf_detach()
    ...
      ffs_dmabuf_release()
        kfree(priv)
                                    dma_resv_add_fence()
                                      dma_fence_is_signaled(fence)
                                        dma_fence_lock_irqsave(fence, flags)
                                          <-- use-after-free on priv->lock

Drivers such as f_fs, panthor, xe, and msm allocate the spinlock in a driver
object that can be freed after signaling while references to the signaled
struct dma_fence remain in dma_resv or sync_file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110155817.1492=
359-3-phasta@kernel.org?part=3D1
