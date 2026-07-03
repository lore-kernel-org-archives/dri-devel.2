Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93688C44501
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E27CC10E5BC;
	Fri,  3 Jul 2026 11:43:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="huG/CzHz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 311A710E5BC
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 11:43:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE8E540A1F;
 Fri,  3 Jul 2026 11:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE1B1F000E9;
 Fri,  3 Jul 2026 11:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783079003;
 bh=a99Mtc3bfHDxNC4GdIa609Zreo4WHx8Aye4vjc/uTq8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=huG/CzHzJbCdvv/hn1dud67cZi1UguRdz56xmrD7ZCHTjNwVFM5NHxehSBwU4NNO5
 1KATDrKUs7pr1S4UDL9gQqJuGQDMhHLLa0mu8WV3JpBlIRj0LtpRUKjGw4hL6586l7
 Hn7GN2oEit/kDu4fJlBxbSg9rOMTOF25FNexz3kbz0qE9AmLlwLnjpoKw2xoV0Ds/8
 L+fY61vCfApXSINDpAq7QQru+C9dI1TA/bc2nccFQMNqBW6c2xjBQLsjJuAEDBv3wF
 0+RF26y2I3e9KMFoQ6PfV7577+Jm7pKERRLW2ITnPIjBdCfTsdyX/UW7W1xn8PmZx3
 Sz7dtjfXS51AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] drm/i915/gt: Use a spinlock to prevent
 starvation of irq_work.
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703113259.801374-8-dev@lankhorst.se>
References: <20260703113259.801374-1-dev@lankhorst.se>
 <20260703113259.801374-8-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 11:43:23 +0000
Message-Id: <20260703114323.7DE1B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Concurrent modification and lockless traversal of the `b->signaler=
s` list.
- [High] Failure to restore interrupt state on early return in `i915_reques=
t_cancel_breadcrumb()`.
- [High] Use-after-free of `ce->signal_lock` in `signal_irq_work()` due to =
early `intel_context_put()`.
- [High] Double `list_add()` causing list corruption due to dropped lock in=
 `unlock_and_maybe_remove_signaling_context()`.
- [High] Double `list_del()` and double `intel_context_put()` on already re=
moved contexts in `intel_context_remove_breadcrumbs()`.
- [Medium] Incorrect locking used for iterating `ce->signals` in `print_sig=
nals()`.
--

commit e3123b26bfbdb1e44033e9e8c3f7ae5f8b76d837
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
drm/i915/gt: Use a spinlock to prevent starvation of irq_work.

This patch aims to prevent irq_work starvation on PREEMPT_RT by removing
RCU and introducing a global spinlock to force completion. It replaces
list_add_rcu/list_del_rcu with standard list operations and adds a
signaler_active spinlock.

> diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/dr=
m/i915/gt/intel_breadcrumbs.c
> --- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> +++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
[ ... ]
> @@ -208,12 +208,12 @@ static void signal_irq_work(struct irq_work *work)
>  	if (!signal && READ_ONCE(b->irq_armed) && list_empty(&b->signalers))
>  		intel_breadcrumbs_disarm_irq(b);
> =20
> -	rcu_read_lock();
> -	atomic_inc(&b->signaler_active);
> -	list_for_each_entry_rcu(ce, &b->signalers, signal_link) {
> -		struct i915_request *rq;
> +	spin_lock(&b->signaler_active);
> +	list_for_each_entry_safe(ce, next, &b->signalers, signal_link) {

[Severity: High]
Is the b->signalers list properly protected against concurrent
modifications during this traversal?

This loop traverses b->signalers holding only b->signaler_active. However,
add_signaling_context() and remove_signaling_context() modify this same
list while holding b->signalers_lock, without acquiring b->signaler_active.

Any thread queuing a request could trigger an insertion while this
traversal is happening, which might cause data races or pointer corruption
since they are in different lock domains.

> +		spin_lock(&ce->signal_lock);
> +		list_for_each_entry_safe(rq, rq_next, &ce->signals, signal_link) {
[ ... ]
> -			spin_lock(&ce->signal_lock);
> -			list_del_rcu(&rq->signal_link);
> +			list_del(&rq->signal_link);
>  			release =3D remove_signaling_context(b, ce);
> -			spin_unlock(&ce->signal_lock);
>  			if (release) {
>  				if (intel_timeline_is_last(ce->timeline, rq))
>  					add_retire(b, ce->timeline);
> @@ -244,9 +242,9 @@ static void signal_irq_work(struct irq_work *work)
>  			else
>  				i915_request_put(rq);
>  		}
> +		spin_unlock(&ce->signal_lock);

[Severity: High]
Could this lead to a use-after-free of ce->signal_lock?

If intel_context_put(ce) drops the final reference to the context, the
memory backing ce (including the lock itself) could be freed immediately.

Since RCU read-side protection was removed, the memory might be scheduled
for freeing before the loop concludes and calls
spin_unlock(&ce->signal_lock).

[ ... ]
> +static void unlock_and_maybe_remove_signaling_context(struct intel_conte=
xt *ce,
> +						      struct intel_breadcrumbs *b,
> +						      unsigned long flags)
> +{
> +	bool release =3D false, retry =3D false;
> +
> +	if (list_empty(&ce->signals)) {
> +		if (spin_trylock(&b->signaler_active)) {
> +			release =3D remove_signaling_context(b, ce);
> +			spin_unlock(&b->signaler_active);
> +		} else {
> +			retry =3D true;
> +		}
> +	}
> +	spin_unlock_irqrestore(&ce->signal_lock, flags);
> +
> +	if (retry) {

[Severity: High]
Could dropping the lock here result in double list additions?

If spin_trylock(&b->signaler_active) fails, this function drops
ce->signal_lock and retries to avoid an AB-BA deadlock. During this
lockless window, ce->signals is empty but ce->signal_link is still linked
in the global b->signalers list.

If a concurrent thread calls insert_breadcrumb(), it will observe an empty
ce->signals list and call add_signaling_context():

insert_breadcrumb() {
    if (list_empty(&ce->signals)) {
        intel_context_get(ce);
        add_signaling_context(b, ce);
}

This would blindly execute list_add(&ce->signal_link, &b->signalers) while
it is already linked, which might corrupt the pointers.

[ ... ]
>  void i915_request_cancel_breadcrumb(struct i915_request *rq)
>  {
>  	struct intel_breadcrumbs *b =3D READ_ONCE(rq->engine)->breadcrumbs;
>  	struct intel_context *ce =3D rq->context;
> -	bool release;
> +	unsigned long flags;
> =20
> -	spin_lock(&ce->signal_lock);
> +	spin_lock_irqsave(&ce->signal_lock, flags);
>  	if (!test_and_clear_bit(I915_FENCE_FLAG_SIGNAL, &rq->fence.flags)) {
>  		spin_unlock(&ce->signal_lock);
>  		return;
>  	}

[Severity: High]
Will this early return leave local interrupts permanently disabled?

The lock acquisition is upgraded to spin_lock_irqsave(), which disables
local interrupts and saves the state in the flags variable. However, this
early return path uses plain spin_unlock(&ce->signal_lock) instead of
spin_unlock_irqrestore(&ce->signal_lock, flags).

If a request is cancelled that has already been signaled, the CPU will
return from this function with IRQs disabled, which might cause a hard
lockup.

[ ... ]
>  void intel_context_remove_breadcrumbs(struct intel_context *ce,
>  				      struct intel_breadcrumbs *b)
>  {
[ ... ]
> -	release =3D remove_signaling_context(b, ce);
> =20
>  unlock:
> -	spin_unlock_irqrestore(&ce->signal_lock, flags);
> -	if (release)
> -		intel_context_put(ce);
> -
> -	while (atomic_read(&b->signaler_active))
> -		cpu_relax();
> +	unlock_and_maybe_remove_signaling_context(ce, b, flags);
>  }

[Severity: High]
Does this cause a double list_del() on contexts that are already removed?

If ce->signals is already empty when intel_context_remove_breadcrumbs()
is called (which happens for cleanly destroyed contexts), it will jump
to the unlock label and call unlock_and_maybe_remove_signaling_context().

That helper checks if ce->signals is empty, sees that it is, and calls
remove_signaling_context(), which blindly executes
list_del(&ce->signal_link). Since the link was already deleted when the
list originally became empty, this executes list_del() on LIST_POISON.
It could also cause a double intel_context_put() from the refcount
underflow.

[ ... ]
>  static void print_signals(struct intel_breadcrumbs *b, struct drm_printe=
r *p)
>  {
>  	struct intel_context *ce;
>  	struct i915_request *rq;
> +	unsigned long flags;
> =20
>  	drm_printf(p, "Signals:\n");
> =20
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(ce, &b->signalers, signal_link) {
> -		list_for_each_entry_rcu(rq, &ce->signals, signal_link)
> +	spin_lock_irqsave(&b->signaler_active, flags);
> +	list_for_each_entry(ce, &b->signalers, signal_link) {
> +		spin_lock(&b->signalers_lock);
> +		list_for_each_entry(rq, &ce->signals, signal_link)

[Severity: Medium]
Is b->signalers_lock the correct lock to protect the ce->signals list?

This acquires b->signalers_lock instead of ce->signal_lock to protect
the traversal of the ce->signals list. Since insert_breadcrumb()
modifies ce->signals under ce->signal_lock, traversing it here with the
wrong lock allows concurrent mutations during iteration.

When i915_engine_info is read via debugfs, this could lead to list
corruption or an oops.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703113259.8013=
74-1-dev@lankhorst.se?part=3D7
