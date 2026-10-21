Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A49A606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHPGemAi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C28B910FD2C;
	Wed, 21 Oct 2026 10:16:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B1F10E03E
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 10:16:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 68C0360267;
 Wed, 21 Oct 2026 10:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FBC1F000C9;
 Wed, 21 Oct 2026 10:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792577771;
 bh=cKUe5IwHUjQYZew75vh56Dlqlg6T8tYngaw1KM/MXzU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MHPGemAiAW2Jug6EZznAFs9tuWxk+FLNmrx/dceiS0wCPQOu3PAQBo7fZ4HkZScPS
 vMLhTkkoRTFMZgZyVjt49DDvzY0KGnVQ9Cj6a43Qm/aYPeWkDOCPj5XZjP/5sx/dqr
 5X1d4ypRjYekowwPMPptDFbi2lguHYKjiiryr2Ih1/bcIdbivXa1tYxE2Q4vQFykVe
 gJBOJp5aZMXcLLpoqo9zJqZPcPfbVBr2zeeqBxvpeAtYuJYTkQyRJwwPAc/VZQW3e7
 AH6TJKUJk4Jg5AwLAkW3DrFil+nHlNoviQaL3AcUZer7TcfWr/n6XecjiN0yAPaaol
 H3fncMiWhNgtg==
Message-ID: <sashiko-outbox-180089@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] dma-buf/dma-fence: Order setting of the
 signaled-bit properly
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261021095512.1345191-4-phasta@kernel.org>
References: <20261021095512.1345191-2-phasta@kernel.org>
 <20261021095512.1345191-4-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 10:16:10 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] dma-fence: deadlock and UAF in dma_fence_release() on put in c=
allback
- [Critical] dma-fence: broken state and re-entrancy in dma_fence_signal_ti=
mestamp_locked()
- [High] dma-fence: lost wakeups in waiters when running callbacks before s=
etting bit
- [High] dma-fence: build failure and missing barrier from set_bit_release()
--

commit 1792aa61ea7d70257b20df7aab8e20f6da404551
Author: Philipp Stanner <phasta@kernel.org>

dma-buf/dma-fence: Order setting of the signaled-bit properly

This commit defers setting DMA_FENCE_FLAG_SIGNALED_BIT in
dma_fence_signal_timestamp_locked() until after all fence callbacks have
completed, using set_bit_release() and test_bit_acquire() to order the
signaled state.

> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index bd58688b81a72..07d499fa35ac9 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -359,8 +359,7 @@ void dma_fence_signal_timestamp_locked(struct dma_fen=
ce *fence,
> =20
>  	dma_fence_assert_held(fence);
> =20
> -	if (unlikely(test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
> -				      &fence->flags)))
> +	if (unlikely(dma_fence_test_signaled_flag(fence)))
>  		return;

[Severity: Critical]
Previously, test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)
marked the fence as signaled at entry before clearing fence->ops, replacing
fence->cb_list with fence->timestamp, and invoking callbacks. With
DMA_FENCE_FLAG_SIGNALED_BIT remaining zero until the end of
dma_fence_signal_timestamp_locked(), what happens if a callback queries or
signals the fence?

In include/linux/dma-fence.h:

    static inline bool
    dma_fence_is_signaled_locked(struct dma_fence *fence)
    {
            const struct dma_fence_ops *ops;

            if (dma_fence_test_signaled_flag(fence))
                    return true;

            rcu_read_lock();
            ops =3D rcu_dereference(fence->ops);
            if (ops && ops->signaled && ops->signaled(fence)) {
                    rcu_read_unlock();
                    dma_fence_signal_locked(fence);
                    return true;
            }
            rcu_read_unlock();

            return false;
    }

If a callback calls dma_fence_signal_locked(fence), or calls
dma_fence_is_signaled_locked(fence) or dma_fence_get_status_locked(fence)
when ops->signaled(fence) returns true, dma_fence_signal_timestamp_locked()
is re-entered while DMA_FENCE_FLAG_SIGNALED_BIT is still zero. If
fence->ops was cleared to NULL (when !ops->release && !ops->wait), the
recursive call dereferences a NULL ops pointer; otherwise,
list_replace(&fence->cb_list, &cb_list) runs on the union already
overwritten by fence->timestamp, corrupting memory by treating the timestamp
as list pointers.

Conversely, if ops->signaled is NULL (or fence->ops was cleared), calling
dma_fence_is_signaled_locked(fence) or dma_fence_get_status_locked(fence)
from a callback now returns false or 0 for a fence that is being signaled.
If a callback instead calls unlocked helpers such as
dma_fence_is_signaled(fence) (when ops->signaled returns true) or
dma_fence_add_callback(fence, ...), dma_fence_test_signaled_flag(fence)
returns false and those helpers attempt to re-acquire fence->lock on the
same CPU, causing a spinlock self-deadlock.

Similarly, in include/linux/dma-fence.h:

    static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
    {
            if (WARN_ON(!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flag=
s)))
                    return ktime_get();

            while (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
                    cpu_relax();

            return fence->timestamp;
    }

Won't calling dma_fence_timestamp(fence) from a fence callback (or from a
worker woken by a callback before set_bit_release() runs) now trigger the
WARN_ON and return ktime_get() even though fence->timestamp and
DMA_FENCE_FLAG_TIMESTAMP_BIT have already been set?

> =20
>  	trace_dma_fence_signaled(fence);
> @@ -384,6 +383,14 @@ void dma_fence_signal_timestamp_locked(struct dma_fe=
nce *fence,
>  		INIT_LIST_HEAD(&cur->node);
>  		cur->func(fence, cur);
>  	}

[Severity: Critical]
In struct dma_fence, cb_list, timestamp, and rcu share a union whose
comment notes that cb_list is only valid until the signal bit is set:

    union {
            struct list_head cb_list;
            /* @cb_list replaced by @timestamp on dma_fence_signal() */
            ktime_t timestamp;
            /* @timestamp replaced by @rcu on dma_fence_release() */
            struct rcu_head rcu;
    };

In dma_fence_signal_timestamp_locked(), list_replace(&fence->cb_list,
&cb_list) and fence->timestamp =3D timestamp overwrite that union before
cur->func(fence, cur) runs, while DMA_FENCE_FLAG_SIGNALED_BIT is still 0.

Many in-tree callbacks drop a reference to the fence via dma_fence_put()
inside cur->func(), such as dma_fence_chain_cb(), dma_buf_poll_cb(),
drm_sched_entity_wakeup(), drm_sched_entity_kill_jobs_cb(),
vmw_event_fence_action_seq_passed(), amdgpu_pasid_free_cb(), and
amdgpu_display_flip_callback(). When the signaler does not hold an extra
reference across dma_fence_signal_locked() (for example in
sw_sync_debugfs_release() or __vmw_fences_update()), or when a waiter woken
by cur->func() drops the last reference before set_bit_release() executes,
dma_fence_put() invokes dma_fence_release():

    if (!list_empty(&fence->cb_list) &&
        !dma_fence_test_signaled_flag(fence)) {
            ...
            WARN(1,
                 "Fence %s:%s:%llx:%llx released with pending signals!\n",
                 ...);

            dma_fence_lock_irqsave(fence, flags);
            fence->error =3D -EDEADLK;
            dma_fence_signal_locked(fence);
            dma_fence_unlock_irqrestore(fence, flags);
    }

Because fence->cb_list now holds fence->timestamp (making !list_empty()
evaluate to true) and DMA_FENCE_FLAG_SIGNALED_BIT is not yet set, won't
dma_fence_release() emit a false WARN, self-deadlock on fence->lock when
called from cur->func() (or re-enter dma_fence_signal_locked() on a
corrupted cb_list from another CPU), and then release or free the fence
before dma_fence_signal_timestamp_locked() writes to fence->flags and
unlocks fence->inline_lock?

> +
> +	/*
> +	 * This orders the signaled-state with the test_bit_acquire() in
> +	 * dma_fence_test_signaled_flag(). This ensures that functions like
> +	 * dma_fence_is_signaled() can only ever return true once signaling is
> +	 * completed (i.e., after the callbacks above ran).
> +	 */

[Severity: High]
Could deferring DMA_FENCE_FLAG_SIGNALED_BIT until after the callbacks have
run cause lost wakeups for waiters, pollers, and work items that are woken
by cur->func()?

Waiters register a one-shot callback with dma_fence_add_callback() that
wakes the task or waitqueue (for example dma_fence_default_wait_cb(),
syncobj_wait_fence_func(), fence_check_cb_func(), and
radeon_fence_wait_cb()), and then check whether the fence is signaled
without acquiring fence->lock.

For instance, in drivers/dma-buf/dma-fence.c:dma_fence_wait_any_timeout():

    while (ret > 0) {
            if (intr)
                    set_current_state(TASK_INTERRUPTIBLE);
            else
                    set_current_state(TASK_UNINTERRUPTIBLE);

            if (dma_fence_test_signaled_any(fences, count, idx))
                    break;

            ret =3D schedule_timeout(ret);

If CPU0 runs dma_fence_default_wait_cb() and wakes the waiting task on CPU1
before CPU0 finishes the callback loop and calls set_bit_release(), CPU1 can
set its task state and call dma_fence_test_signaled_any() ->
dma_fence_test_signaled_flag(fence), observe DMA_FENCE_FLAG_SIGNALED_BIT =
=3D=3D
0, and go to sleep in schedule_timeout(ret) with its callback already
removed and executed.

Doesn't the same race also affect:

1. drm_syncobj_array_wait_timeout() in drivers/gpu/drm/drm_syncobj.c, where
   woken task checks dma_fence_is_signaled(fence) while
   entries[i].fence_cb.func is already non-NULL (and after fence->ops was
   cleared to NULL), sees false, and sleeps again in schedule_timeout()?

2. sync_file_poll() in drivers/dma-buf/sync_file.c, where
   fence_check_cb_func() wakes sync_file->wq while
   DMA_FENCE_FLAG_SIGNALED_BIT is still 0, causing the woken poller to see
   POLL_ENABLED already set and dma_fence_is_signaled(sync_file->fence)
   returning false, missing EPOLLIN?

3. radeon_fence_default_wait() in drivers/gpu/drm/radeon/radeon_fence.c and
   __i915_request_wait() in drivers/gpu/drm/i915/i915_request.c, which wake
   the waiter from a fence callback and test DMA_FENCE_FLAG_SIGNALED_BIT
   before calling schedule_timeout()?

4. nouveau_cli_work() in drivers/gpu/drm/nouveau/nouveau_drm.c, where
   nouveau_cli_work_fence() schedules cli->work from the callback, and if
   nouveau_cli_work() runs before set_bit_release() and sees
   dma_fence_is_signaled(fence) =3D=3D false, it skips the work item with no
   further callback to reschedule it?

> +	set_bit_release(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);

[Severity: High]
Does set_bit_release() build on all architectures and provide a hardware
release barrier on weakly-ordered CPUs?

set_bit_release() is only defined in
include/asm-generic/bitops/instrumented-atomic.h:

    static __always_inline void set_bit_release(long nr, volatile unsigned =
long *addr)
    {
            kcsan_wmb();
            instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
            arch_set_bit(nr, addr);
    }

Architectures that define their own atomic bitops without including
asm-generic/bitops/instrumented-atomic.h (such as 32-bit arm, mips, sparc,
parisc, m68k, alpha, sh, openrisc, and hexagon) do not declare
set_bit_release(), which breaks compiling drivers/dma-buf/dma-fence.c.

Furthermore, on architectures that do include
asm-generic/bitops/instrumented-atomic.h (such as arm64, riscv, powerpc, and
loongarch), kcsan_wmb() is only a KCSAN annotation (a no-op when
CONFIG_KCSAN=3Dn) and arch_set_bit() is a relaxed atomic operation without
release semantics:

    static __always_inline void
    arch_set_bit(unsigned int nr, volatile unsigned long *p)
    {
            p +=3D BIT_WORD(nr);
            raw_atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
    }

Unlike test_and_set_bit(), which implies a full memory barrier, doesn't
set_bit_release() omit the CPU release barrier needed to pair with
test_bit_acquire() on weakly-ordered architectures?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021095512.1345=
191-2-phasta@kernel.org?part=3D2
