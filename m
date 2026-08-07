Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AB8C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D0A10F51E;
	Fri,  7 Aug 2026 15:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jp3OlK1y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE5510F51E
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 15:22:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E8B94418A8;
 Fri,  7 Aug 2026 15:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750F11F000E9;
 Fri,  7 Aug 2026 15:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786116149;
 bh=7FaKSagHmoHZjUuapft1KbOwEQ94wymKg//qhLAygbY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jp3OlK1yDjC7hF2R3AiBxqiXg3hit2hdcaJRVzpwDeGG76jSKwZFyloVUPWBPsCt5
 5kd2c5WA+b3a+cbS5WTfFQcj9j1C44d9UEXRU+BL3GzEWI7j4vhe5LOpQeG8/LbRvN
 NRq3/Qg/Fk3nlXcldX+SWYBv9BOAeY68alrz/8nx3JGRk1WMCep+hauygOWEz8yMSA
 PjeKZvIeGRjev41nyesPKPwG2Aqw+Gk2CQMsUsdoWMZFxU4gA9HMqFDpW0orGMFNzQ
 SK4p/l+nW1If4vl1Qs6EQFeZ4FOYLb51eJCgMjk6CqRNFu2oHl3UQQcA2wj4apR3RZ
 olUBBezLFc4Zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 5/5] sched: use kfree_nolock() instead of kfree_rcu()
To: =?utf-8?b?Vmxhc3RpbWlsIEJhYmthIChTVVNFKQ==?= <vbabka@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, media-ci@linuxtv.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260807-kfree_nolock_kmalloc-v1-5-ba993cbf7a60@kernel.org>
References: <20260807-kfree_nolock_kmalloc-v1-0-ba993cbf7a60@kernel.org>
 <20260807-kfree_nolock_kmalloc-v1-5-ba993cbf7a60@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:22:28 +0000
Message-Id: <20260807152229.750F11F000E9@smtp.kernel.org>
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

New issues:
- [High] Replacing `kfree_rcu()` with `kfree_nolock()` introduces an 'Inval=
id wait context' lockdep warning and RT deadlock risk.

Pre-existing issues:
- [Critical] Pre-existing Use-After-Free (UAF) due to lockless access of `u=
ser_cpus_ptr` in `relax_compatible_cpus_allowed_ptr()` racing with concurre=
nt `sched_setaffinity()`.
--

--- Patch [5]: [PATCH RFC 5/5] sched: use kfree_nolock() instead of kfree_r=
cu() ---
commit 59f1ba4e68974041e778f52147c67a01b2854ec6
Author: Vlastimil Babka (SUSE) <vbabka@kernel.org>

sched: use kfree_nolock() instead of kfree_rcu()

This commit replaces kfree_rcu() with kfree_nolock() in set_cpus_allowed_fo=
rce()
to avoid unnecessary RCU grace period delays. It also updates
alloc_user_cpus_ptr() to no longer allocate extra space for the RCU head.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 96226707c2f61..d2929e4e23f13 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2807,20 +2807,15 @@ void set_cpus_allowed_force(struct task_struct *p=
, const struct cpumask *new_mas
>  		.user_mask =3D NULL,
>  		.flags     =3D SCA_USER,	/* clear the user requested mask */
>  	};
[ ... ]
>  	/*
>  	 * Because this is called with p->pi_lock held, it is not possible
> -	 * to use kfree() here (when PREEMPT_RT=3Dy), therefore punt to using
> -	 * kfree_rcu().
> +	 * to use kfree() here (when PREEMPT_RT=3Dy), thus use kfree_nolock()
>  	 */
> -	kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
> +	kfree_nolock(ac.user_mask);

[Severity: High]
Does this change trigger an "Invalid wait context" lockdep warning and RT
deadlock risk?

set_cpus_allowed_force() is called with the target task's pi_lock held, whi=
ch
is a raw_spinlock_t.

kfree_nolock() forwards the call to free_to_pcs():

mm/slub.c:kfree_nolock() {
    ...
	if (likely(can_free_to_pcs(slab)) && likely(free_to_pcs(s, x, false)))
    ...
}

free_to_pcs() then unconditionally acquires a local_trylock_t:

mm/slub.c:free_to_pcs() {
    ...
	if (!local_trylock(&s->cpu_sheaves->lock))
    ...
}

On PREEMPT_RT, local_trylock_t maps to a sleeping spinlock. Acquiring a
sleeping lock (even via a trylock) while holding a raw spinlock violates the
wait-context rules (WAIT_SLEEP under WAIT_RAW).

Could this cause a lockdep splat since CONFIG_PROVE_RAW_LOCK_NESTING checks
declared wait-types rather than runtime behavior?


[Severity: Critical]
This is a pre-existing issue, but can the lockless access of user_cpus_ptr =
in
relax_compatible_cpus_allowed_ptr() race with a concurrent sched_setaffinit=
y()?

relax_compatible_cpus_allowed_ptr() performs a lockless read of
p->user_cpus_ptr and passes it as ctx->new_mask:

kernel/sched/core.c:relax_compatible_cpus_allowed_ptr() {
    ...
	.new_mask  =3D task_user_cpus(p),
    ...
}

__sched_setaffinity() then allocates temporary masks with GFP_KERNEL:

kernel/sched/syscalls.c:__sched_setaffinity() {
    ...
	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
    ...
}

Since GFP_KERNEL can sleep or be preempted, a concurrent thread calling the
sched_setaffinity() syscall on the same task can update user_cpus_ptr and f=
ree
the old mask.

When __sched_setaffinity() resumes, it dereferences the potentially freed
memory:

kernel/sched/syscalls.c:__sched_setaffinity() {
    ...
	cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
    ...
}

Can this use-after-free lead to memory corruption or a kernel crash if
triggered by unprivileged userspace executing a compat binary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-kfree_nolo=
ck_kmalloc-v1-0-ba993cbf7a60@kernel.org?part=3D5
