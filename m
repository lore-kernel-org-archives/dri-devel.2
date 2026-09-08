Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADDDC79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5018410E09E;
	Tue,  8 Sep 2026 11:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l9VlG/Aj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E427B10EB2F
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 11:12:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A14B840407
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 11:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642D91F00A3D;
 Tue,  8 Sep 2026 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788865944;
 bh=ryq3156UMj4hk94mWoStQtsVoMeUlA5M8L1u2D6B39g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l9VlG/Ajke1+S9jLnC4Scwph51RvJDlqnGsPpHoNQ9r0cDEAjH8JszuU1ck1edAAr
 M0lwQo1FyT+OVYoHVo8lUBqDx0E19OVj5dhtzUtHcCauGqsSPx2VKGLU0NRtb26/RT
 Q0IljgOScLMlW4+MKOyyQwTIsuQIQAYqKjMDduUC8TC0GveZB4fFUKwuW1NDBcd9+l
 oF4eWJ+QbeOw/FEA/0UQo0qFVScgPFb9kEJfliAY2C1VcM7eQRZPlJTRMuMmiZPuwm
 VamIiJd40BkyICkh74z7yQsZNrzl8CJXpIKxjnREVBC2LQYK1NqHuRFslLXXTUS4kh
 j0flFbyqC252A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] dma-fence: Solve dma_fence's problems with
 additional spinlock
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908105926.1120378-2-phasta@kernel.org>
References: <20260908105926.1120378-2-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 11:12:23 +0000
Message-Id: <20260908111224.642D91F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Synchronous freeing of `dma_fence` objects causes a Use-After-=
Free for concurrent lockless RCU readers.
- [High] Self-deadlock in `dma_fence_is_signaled` and `dma_fence_is_signale=
d_locked` due to recursive `full_lock` acquisition.
- [High] Accessing `fence->ops` after a driver module has unloaded causes a=
 fatal page fault or control flow hijack.
- [High] Tracepoints and other callers fail to compile because `dma_fence_d=
river_name` now returns `void`.
- [High] ABBA deadlock between per-fence `full_lock` and shared `external_l=
ock`.
- [High] Missing `external_lock` in `dma_fence_set_deadline` causes data ra=
ces and list corruption on `cb_list`.
- [High] Executing callbacks with `full_lock` held causes recursive deadloc=
ks.
--

commit 525455b941dbaf30c6ab94a87c9eed2d046b6ee0
Author: Philipp Stanner <phasta@kernel.org>

dma-fence: Solve dma_fence's problems with additional spinlock
   =20
This commit introduces a dedicated internal full_lock spinlock to dma_fence
to guard its state. It removes the RCU grace periods from the implementatio=
n,
opting instead for synchronous resource freeing and deterministic decoupling
once a fence is signaled.

> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
[ ... ]
>  void dma_fence_signal_timestamp_locked_full(struct dma_fence *fence,
>  				      ktime_t timestamp)
>  {
[ ... ]
> -	/*
> -	 * When neither a release nor a wait operation is specified set the ops
> -	 * pointer to NULL to allow the fence structure to become independent
> -	 * from who originally issued it.
> -	 */
> -	ops =3D rcu_dereference_protected(fence->ops, true);
> -	if (!ops->release && !ops->wait)
> -		RCU_INIT_POINTER(fence->ops, NULL);
> -

[Severity: High]
Since fence->ops is no longer cleared here, could we dereference a dangling
pointer later in dma_fence_release() if the driver module unloads before the
fence is released by all users? If a user holds a sync_file descriptor for =
an
old fence and the driver is unloaded, the driver's functions are freed, whi=
ch
could lead to a fatal page fault when the release callback is eventually
invoked.

>  	/* Stash the cb_list before replacing it with the timestamp */
>  	list_replace(&fence->cb_list, &cb_list);
> =20
> @@ -385,7 +378,6 @@ void dma_fence_signal_timestamp_locked(struct dma_fen=
ce *fence,
>  		cur->func(fence, cur);
>  	}
>  }

[Severity: High]
Will executing the callbacks synchronously here while holding full_lock lead
to a deadlock? If a user callback attempts to query the fence status via
dma_fence_get_status(), it will try to reacquire full_lock and hang.

[ ... ]
>  void dma_fence_signal(struct dma_fence *fence)
>  {
> -	unsigned long flags;
> +	unsigned long flags, flags_full;
>  	bool tmp;
> =20
>  	if (WARN_ON(!fence))
> @@ -495,9 +500,13 @@ void dma_fence_signal(struct dma_fence *fence)
> =20
>  	tmp =3D dma_fence_begin_signalling();
> =20
> +	dma_fence_lock_full(fence, &flags_full);
>  	dma_fence_lock_irqsave(fence, flags);

[Severity: High]
Is there an ABBA deadlock risk established by this lock ordering?
Here, dma_fence_signal() takes full_lock and then takes the external lock.
However, dma_fence_signal_locked() is called with the external lock already
held, and then it acquires full_lock. If CPU 1 calls dma_fence_signal() on
one fence, and CPU 2 calls dma_fence_signal_locked() on another fence shari=
ng
the same external lock, couldn't this cause a deadlock?

[ ... ]
>  void dma_fence_free(struct dma_fence *fence)
>  {
> -	kfree_rcu(fence, rcu);
> +	kfree(fence);
>  }

[Severity: Critical]
By switching from kfree_rcu() to a synchronous kfree(), does this introduce=
 a
use-after-free for concurrent lockless readers? Lockless paths such as
dma_fence_get_rcu_safe() rely on the RCU grace period to safely elevate the
reference count. Freeing the memory instantly invalidates that assumption.

[ ... ]
>  void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline)
>  {
> -	const struct dma_fence_ops *ops;
> +	unsigned long flags;
> =20
> -	rcu_read_lock();
> -	ops =3D rcu_dereference(fence->ops);
> -	if (ops && ops->set_deadline && !dma_fence_is_signaled(fence))
> -		ops->set_deadline(fence, deadline);
> -	rcu_read_unlock();
> +	dma_fence_lock_full(fence, &flags);
> +	if (dma_fence_is_signaled_locked_full(fence))
> +		goto out;
> +
> +	if (fence->ops->set_deadline && !dma_fence_is_signaled_locked_full(fenc=
e))
> +		fence->ops->set_deadline(fence, deadline);
> +
> +out:
> +	dma_fence_unlock_full(fence, &flags);
>  }

[Severity: High]
Does acquiring only full_lock here create a data race on cb_list?
If the deadline triggers a signal, the ops->set_deadline callback can
ultimately mutate cb_list. Concurrently, functions like
dma_fence_default_wait() mutate cb_list while holding only the external loc=
k.
Could this result in linked list corruption if both locks are not held?

> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
[ ... ]
> -const char __rcu *dma_fence_driver_name(struct dma_fence *fence);
> -const char __rcu *dma_fence_timeline_name(struct dma_fence *fence);
> +void dma_fence_driver_name(struct dma_fence *fence, char *buff, unsigned=
 short len);
> +void dma_fence_timeline_name(struct dma_fence *fence, char *buff, unsign=
ed short len);

[Severity: High]
Does changing the return type to void break compilation for tracepoints?
The TRACE_EVENT definitions for dma_fence in include/trace/events/dma_fence=
.h
still use __string(driver, dma_fence_driver_name(fence)). The macro expects=
 a
valid string pointer for its length computation and copying, and will fail =
to
compile when it encounters a void return type.

[ ... ]
>  static inline bool
>  dma_fence_is_signaled(struct dma_fence *fence)
>  {
> -	const struct dma_fence_ops *ops;
> +	unsigned long flags;
> +	bool ret =3D false;
> =20
> -	if (dma_fence_test_signaled_flag(fence))
> -		return true;
> +	dma_fence_lock_full(fence, &flags);
> +
> +	if (dma_fence_test_signaled_flag(fence)) {
> +		ret =3D true;
> +		goto out;
> +	}
> =20
> -	rcu_read_lock();
> -	ops =3D rcu_dereference(fence->ops);
> -	if (ops && ops->signaled && ops->signaled(fence)) {
> -		rcu_read_unlock();
>  		dma_fence_signal(fence);
> -		return true;
>  	}
> -	rcu_read_unlock();
> =20
> -	return false;
> +out:
> +	dma_fence_unlock_full(fence, &flags);
> +	return ret;
>  }

[Severity: High]
Could this result in a recursive self-deadlock?
dma_fence_is_signaled() acquires full_lock, and if fence->ops->signaled(fen=
ce)
evaluates to true, it directly calls dma_fence_signal(fence).
dma_fence_signal() will then immediately try to acquire full_lock again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908105926.1120=
378-2-phasta@kernel.org?part=3D1
