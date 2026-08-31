Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A621AC624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F6010E908;
	Mon, 31 Aug 2026 14:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fo+QIdog";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C2B610E7C7;
 Mon, 31 Aug 2026 14:25:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D0BC43694;
 Mon, 31 Aug 2026 14:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DEB1F000E9;
 Mon, 31 Aug 2026 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788186305;
 bh=di9qEjKKd0VVRqslCe5nvGUW8RjwVopxxn0bOnbXg/w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fo+QIdog4pATyubwj0aoMs/NOEACXcbm1hM332zpUURAmdIVu/7THavS+bq4HjP1Y
 DxLb2Jkhg4Ua1gMFDcW2lWOU2AH99LobYCQpJ9RkXz/SgNwNLLO3SyPsFse9L+FILl
 9QdKZBgPrkcyf/YnaI5sRIaG0GrJ4/ahu0AdXi9WeaZXMlYMJZSsiJNYpC970pwzZI
 Zf5wjKigptu9NlJ89XFWhLSLEmP/mJQPl3+dOfYjMMUf2/MOpSN33yQ0mUBEAN+kWe
 2E8mtoFpCUbem2BOiWOsuKhQbFgQue9Mk+N0bde8vB7K2s7b5+eGOK1j7HPVHuYks6
 qUiL3O1pmVZRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] drm: Add per-signal compare functionality to
 drm_user_fence
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260831134539.112690-5-srinivasan.shanmugam@amd.com>
References: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
 <20260831134539.112690-5-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:25:04 +0000
Message-Id: <20260831142505.18DEB1F000E9@smtp.kernel.org>
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
- [High] Per-signal comparison silently drops events and hangs userspace if=
 the underlying dma_fence signals with an error (e.g., GPU hang).
- [High] `get_user()` is called in a workqueue thread without disabling pag=
e faults, allowing indefinite stalls via userfaultfd.
- [Medium] The comparison API exposes user-triggerable kernel WARNINGs and =
performs non-atomic 64-bit reads on 32-bit systems, leading to torn reads a=
nd lost events.
--

commit 9b6e7653adf98ad34fe45f552b39016755ccc0e5
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: drm: Add per-signal compare functionality to drm_user_fence

This commit adds optional comparison fields to drm_user_fence to support
per-signal filtering, which is used in AMDGPU's EOP eventfd path. It
introduces drm_user_fence_set_compare() to configure these fields,
allowing the worker to be called conditionally based on a value read
from a userspace address.

> diff --git a/drivers/gpu/drm/drm_user_fence.c b/drivers/gpu/drm/drm_user_=
fence.c
> index 664178e2d74cf..e55d03ebf75f5 100644
> --- a/drivers/gpu/drm/drm_user_fence.c
> +++ b/drivers/gpu/drm/drm_user_fence.c

[ ... ]

> @@ -34,7 +49,32 @@ static void drm_user_fence_do_work(struct drm_work_fen=
ce *wfence)
>  		mm_ok =3D true;
>  	}
> =20
> -	ufence->ops->worker(ufence, mm_ok);
> +	/*
> +	 * Per-signal comparison: read a value from userspace and compare
> +	 * with the expected value. Skip ops->worker if the condition is
> +	 * not met. Drivers that do not need filtering leave cmp_addr NULL.
> +	 *
> +	 * If the MM is gone and cmp_addr is set we cannot perform the
> +	 * comparison, so skip the worker rather than calling it without
> +	 * having verified the condition.
> +	 */
> +	if (ufence->cmp_op !=3D DRM_USER_FENCE_CMP_NONE) {
> +		if (!mm_ok) {
> +			call_worker =3D false;
> +		} else {
> +			u64 cur_val;
> +
> +			if (get_user(cur_val, ufence->cmp_addr) ||
> +			    !drm_user_fence_cmp_match(cur_val,
> +						      ufence->cmp_value,
> +						      ufence->cmp_op))
> +				call_worker =3D false;

[Severity: High]
Is it possible for a page fault here to indefinitely stall the workqueue?

If a malicious user maps cmp_addr to a region backed by userfaultfd, they
could intentionally avoid resolving the fault. Because this executes in a
workqueue thread context without page faults disabled, this would block the
thread forever and stall all other tasks queued on the same workqueue.
Should pagefault_disable() be used around get_user()?

[Severity: High]
What happens if the underlying dma_fence signals with an error, such as
during a GPU hang?

If a GPU hang occurs, the hardware will fail to write the expected sequence
value to userspace. Instead, the GPU reset mechanism will signal all pending
fences with an error code (e.g., -ECANCELED). When this executes, get_user()
reads stale memory, causing drm_user_fence_cmp_match() to fail and
call_worker to be set to false.

Since the worker is completely skipped and the fence only signals once, the
event is permanently dropped, causing waiting userspace processes to hang.
Could the logic check the fence's error state (e.g., wfence->fence->error)
and bypass the comparison when an error is present?

[Severity: Medium]
Can this lead to torn reads on 32-bit architectures?

The get_user() macro on a 64-bit sequence number is not natively atomic on
32-bit systems and is implemented as two separate 32-bit loads. If the GPU
concurrently updates this value, the CPU may read a torn value. A torn read
can cause the comparison to falsely fail, resulting in a permanently lost
event.

> +		}
> +	}
> +
> +	if (call_worker)
> +		ufence->ops->worker(ufence, mm_ok);
> =20
>  	if (mm_ok) {
>  		kthread_unuse_mm(ufence->mm);

[ ... ]

> +/**
> + * drm_user_fence_set_compare - Configure per-signal value comparison
> + * @ufence: user fence
> + * @addr: userspace VA to read when the fence signals
> + * @value: expected value to compare against
> + * @op: comparison operator (see &enum drm_user_fence_cmp)
> + *
> + * When set, drm_user_fence reads @addr via get_user() each time the
> + * fence signals and calls ops->worker() only if the comparison passes.
> + * This enables per-signal filtering without open-coding the read+compare
> + * pattern in each driver.
> + *
> + * Must be called after drm_user_fence_init() and before
> + * drm_user_fence_add_callback().
> + */
> +void drm_user_fence_set_compare(struct drm_user_fence *ufence,
> +				u64 __user *addr, u64 value,
> +				enum drm_user_fence_cmp op)
> +{
> +	WARN_ON_ONCE(!IS_ENABLED(CONFIG_64BIT));
> +
> +	if (WARN_ON(op !=3D DRM_USER_FENCE_CMP_NONE && !addr))
> +		return;

[Severity: Medium]
Are these warnings triggerable by unprivileged userspace?

Because this function is used to configure user fences based on ioctl input=
s,
this allows unprivileged userspace to trivially trigger kernel WARNINGs.
This creates a denial of service vector on systems with panic_on_warn.
Additionally, the 64-bit warning triggers unconditionally on 32-bit kernels.

> +
> +	ufence->cmp_addr =3D addr;
> +	ufence->cmp_value =3D value;
> +	ufence->cmp_op =3D op;
> +}
> +EXPORT_SYMBOL_GPL(drm_user_fence_set_compare);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827062142.4038=
272-1-srinivasan.shanmugam@amd.com?part=3D4
