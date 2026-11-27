Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EAA606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUhbvbkf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8A4A10E835;
	Fri, 27 Nov 2026 10:48:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E4D10E183;
 Fri, 27 Nov 2026 10:48:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 282FE60D5B;
 Fri, 27 Nov 2026 10:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0BC1F000C1;
 Fri, 27 Nov 2026 10:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795776516;
 bh=O3MxPaxvvtd9vg9JYVMVazjBPxBYjVya+zy+O/Uro9s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oUhbvbkfPZ3/DIYwWCnkv8QgcHqOlFPt4JE16nAy+EQCw0HpIyp8Iudt3yIHtzv4I
 3ZOWfnxaP+k89U4YdimMA078SKld6LNbEmuq7trqwIviRUJ/5jtGT4wCfqma+5o0zo
 dqiV53V5uak4K/8i5CUWr9xny10/VDgX9QqYE0IVYJaIoeKhRZCFNdv87muywIoV8a
 CgVp2poDDU6yJlg+ifA5PTR4VLgU6HiCUMT7cvi888sFPstcvLPcSDH7TmfK0KkLeO
 lzjBxRyc5+N72cwocBCAyK2C+B53f1CzlQmD9aPtfNLN+KJ58Ar5KVFJ1POR2L4Xp+
 eXdXWLr2Rx+Qw==
Message-ID: <sashiko-outbox-237167@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/8] dma-buf: dma-fence: Ensure ordering with locks
 for timestamps
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261127101812.2706432-5-phasta@kernel.org>
References: <20261127101812.2706432-2-phasta@kernel.org>
 <20261127101812.2706432-5-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:48:36 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] dma-buf: dma-fence: union cb_list pointer read in
  dma_fence_timestamp()
- [High] dma-buf: dma-fence: dma_fence_timestamp() locks fence after
  signaling
- [Medium] dma-buf: dma-fence: unconditional spin_lock_irqsave in
  dma_fence_timestamp()
- [Medium] dma-buf: dma-fence: undocumented lock and no locked
  dma_fence_timestamp()
--

commit 2dafcb9d7a9ed94c64a7c7994912a38c5f4e4ac5
Author: Philipp Stanner <phasta@kernel.org>

dma-buf: dma-fence: Ensure ordering with locks for timestamps

This commit replaces the spin-wait on DMA_FENCE_FLAG_TIMESTAMP_BIT in
dma_fence_timestamp() with acquiring the fence's spinlock and drops the
corresponding smp_mb__before_atomic() barrier from
dma_fence_signal_timestamp_locked().

> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 9743d217264de..3a05fe9f64e8f 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -706,23 +706,23 @@ static inline void dma_fence_set_error(struct dma_f=
ence *fence,
>   * dma_fence_timestamp - helper to get the completion timestamp of a fen=
ce
>   * @fence: fence to get the timestamp from.
>   *
> - * After a fence is signaled the timestamp is updated with the signaling=
 time,
> - * but setting the timestamp can race with tasks waiting for the signali=
ng. This
> - * helper busy waits for the correct timestamp to appear.
> + * Return:
> + * The fence's timestamp if the fence is already signaled, the current t=
ime
> + * otherwise.
>   */
>  static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
>  {
> -	/*
> -	 * The test_bit_acquire() calls order against the
> -	 * smp_mb__before_atomic() in dma_fence_signal_timestamp_locked().
> -	 */
> -	if (WARN_ON(!test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flag=
s)))
> -		return ktime_get();
> +	unsigned long flags;
> +	ktime_t ret;
> =20
> -	while (!test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
> -		cpu_relax();
> +	dma_fence_lock_irqsave(fence, flags);
> +	if (WARN_ON(!test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flag=
s)))
> +		ret =3D ktime_get();
> +	else
> +		ret =3D fence->timestamp;
> +	dma_fence_unlock_irqrestore(fence, flags);
> =20
> -	return fence->timestamp;
> +	return ret;
>  }
> =20
>  signed long dma_fence_wait_timeout(struct dma_fence *,

[Severity: High]
Can dma_fence_timestamp() read fence->cb_list.next instead of a valid
timestamp on i915 request fences?

In struct dma_fence, cb_list and timestamp share an anonymous union.  In
drivers/gpu/drm/i915/gt/intel_breadcrumbs.c, irq_signal_request() and the
first loop of signal_irq_work() call __dma_fence_signal(&rq->fence), which
sets DMA_FENCE_FLAG_SIGNALED_BIT without holding rq->lock (the fence's
extern_lock) and before replacing rq->fence.cb_list or writing
rq->fence.timestamp:

CPU0                              CPU1
irq_signal_request()
  __dma_fence_signal(&rq->fence)
    test_and_set_bit(SIGNALED_BIT)
  irq_work_queue(&b->irq_work)
                                  sync_fill_fence_info()
                                    dma_fence_is_signaled() -> true
                                    dma_fence_timestamp(&rq->fence)
                                      dma_fence_lock_irqsave()
                                      ret =3D fence->timestamp
                                      /* reads fence->cb_list.next */
                                      dma_fence_unlock_irqrestore()
signal_irq_work()
  spin_lock(&rq->lock)
  list_replace(&rq->fence.cb_list, ...)
  __dma_fence_signal__timestamp()
  spin_unlock(&rq->lock)

Without the wait on DMA_FENCE_FLAG_TIMESTAMP_BIT, a caller running between
__dma_fence_signal() and the locked section in signal_irq_work() sees
DMA_FENCE_FLAG_SIGNALED_BIT set under rq->lock and reads
rq->fence.cb_list.next as the timestamp, corrupting merged fence timestamp
comparisons in __dma_fence_unwrap_merge() and copying a raw kernel heap
pointer to userspace via info->timestamp_ns in SYNC_IOC_FILE_INFO.

[Severity: High]
Does locking dma_fence_spinlock(fence) in dma_fence_timestamp() cause a
use-after-free on fence->extern_lock when the lock's owner frees it after
signaling?

The dma-fence lifetime rules in include/linux/dma-fence.h ("DOC: Safe
external access to driver provided object members") state that
fence->extern_lock must not be accessed after the fence has been signaled
because drivers may free the lock after an RCU grace period.  Unlike
helpers that check dma_fence_test_signaled_flag() before touching
fence->extern_lock, dma_fence_timestamp() is called on already-signaled
fences, such as in __dma_fence_unwrap_merge() during SYNC_IOC_MERGE.

For exporters where the structure holding extern_lock does not outlive
every reference to the signaled fence, such as ffs_dmabuf_release() freeing
priv (which holds the priv->lock passed to dma_fence_init() in
ffs_dmabuf_transfer()) or xe_hw_fence_irq_finish() freeing irq->lock after
synchronize_rcu(), dma_fence_lock_irqsave() in dma_fence_timestamp() writes
to freed memory.

[Severity: Medium]
Could taking dma_fence_lock_irqsave() on every dma_fence_timestamp() call
add unnecessary lock contention and irqsave overhead on hot paths?

Previously, dma_fence_timestamp() only performed read-only bit tests and a
timestamp load, keeping signaled fences in a shared cacheline state.
Acquiring and releasing the spinlock with local interrupts disabled dirties
the lock cacheline on every query.  In drm_sched_free_job_work(),
dma_fence_timestamp() is called multiple times per completed job (including
twice back-to-back on s_fence->scheduled and s_fence->finished in
drm_sched_entity_stats_job_add_gpu_time(), which share s_fence->lock).  In
__dma_fence_unwrap_merge(), every signaled fence in an unwrapped fence
array or chain now takes its spinlock in both passes, contending on the
global dma_fence_stub.inline_lock or on shared driver ring and IRQ locks.

[Severity: Medium]
Will dma_fence_timestamp() deadlock if called while the fence's spinlock is
already held?

dma_fence_timestamp() now acquires dma_fence_spinlock(fence) internally,
without documenting that callers must not hold the fence lock or providing
a dma_fence_timestamp_locked() helper.  Callers that already hold the fence
lock, such as fence completion callbacks invoked from
dma_fence_signal_timestamp_locked() or sync_print_fence() in
drivers/dma-buf/sync_debug.c (which runs under spin_lock(&obj->lock), the
extern_lock passed to dma_fence_init() in sync_pt_create(), and is
converted to call dma_fence_timestamp() in commit "dma-buf: sync_debug:
don't use TIMESTAMP bit" later in this series), will recursively deadlock
on the same spinlock:

sync_print_obj()
  spin_lock(&obj->lock)
  sync_print_fence(s, &pt->base, false)
    dma_fence_timestamp(&pt->base)
      dma_fence_lock_irqsave(&pt->base, flags)  <-- spins forever

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127101812.2706=
432-2-phasta@kernel.org?part=3D3
