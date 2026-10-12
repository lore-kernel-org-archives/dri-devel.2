Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2107CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F2510E597;
	Mon, 12 Oct 2026 13:17:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6411610E597
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:17:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C8A44145E;
 Mon, 12 Oct 2026 13:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F631F0089B;
 Mon, 12 Oct 2026 13:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791811048;
 bh=admzYluwLoAcDw+LJnt4uw+luJIti62+oYJEARTsWWk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ciS3OX9xEfDlnL3wZdWUKklUsv3viNU/hlaG05HcslATw7VVmr3v8Jjx31AoRentp
 fz7PQ2rFmz86eqMzd9rOeTXLTVjQnJeqDbtoflKmMbURdzm6iUyjIP+rpMB0gVjadL
 lbU5QsoFCXtz1xLJTw3WcI+zWO1w3zQcyGX8p12U56RxBvCR+8PPEdZzV05ne92Wdz
 HwkH9sTBBadJdLx9ukOKArJgkRXVqCB3uae9NzpzfGO/Ci32JLxHrBUFuOgb0r+2+z
 CV5rpqK5olnHtfikvRbEmpbVMQk8eBuNgGETCoME1usH+vYCjA5ADsUMvlqRXRta98
 4rvKkegg90mKw==
Message-ID: <sashiko-outbox-168159@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/12] drm/panthor: Add support for entering and
 exiting protected mode
To: "Ketil Johnsen" <ketil.johnsen@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012125940.3291951-6-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
 <20261012125940.3291951-6-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:17:27 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] sched: data race and UAF on sched->protm.active_group during reset
- [Medium] mmu: delayed_update_mask is never cleared, causing permanent cac=
he flushes
- [Medium] drm/panthor: UAPI loses -ERESTARTSYS on signal interruption duri=
ng protm exit
- [Low] cleanup: mixing goto-based error handling with scoped_cond_guard()
--

commit d3563f471c349ec35f609214f5443133a617a0b3
Author: Florent Tomasin <florent.tomasin@arm.com>

drm/panthor: Add support for entering and exiting protected mode

This patch modifies the Panthor driver code to allow handling of the GPU HW
protected mode enter and exit. It introduces the mechanisms needed for
entering and exiting protected mode, handling of protected mode IRQs,
scheduler changes, and GPU fault handling.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2626,6 +2690,7 @@ static int remap_evicted_vma(struct drm_gpuvm_bo *v=
m_bo,
>  		break;
>  	}
> =20
> -	if (found) {
> +	if (!found)
> +		goto out_unlock;
> +
> +	scoped_cond_guard(protm_block_timeout, ret =3D -ETIMEDOUT, vm) {

[Severity: Low]
Does this mix goto-based error handling with scoped guards?

The function uses both goto labels like out_unlock and scoped_cond_guard. T=
he
kernel guidelines advise against mixing goto-based cleanup and scope-based
cleanup helpers in the same function.

[Severity: Medium]
Does this lose the -ERESTARTSYS return value?

The wait function panthor_fw_protm_exit_wait() correctly returns -ERESTARTS=
YS
if interrupted by a signal, but panthor_sched_protm_block_timeout() converts
this error to a boolean. The guard macro here then hardcodes ret =3D -ETIME=
DOUT.
If the userspace thread is interrupted, it incorrectly receives a timeout e=
rror
instead of standard signal interruption semantics.

>  		vm->op_ctx =3D op_ctx;
> +
>  		ret =3D panthor_vm_lock_region(vm, evicted_vma->base.va.addr,
[ ... ]
> @@ -2726,39 +2781,42 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct =
panthor_vm_op_ctx *op,
>  	mutex_lock(&vm->op_lock);
>  	vm->op_ctx =3D op;
> =20
> -	ret =3D panthor_vm_lock_region(vm, op->va.addr, op->va.range);
> -	if (ret)
> -		goto out;
> -
> -	switch (op_type) {
[ ... ]
> +	scoped_cond_guard(protm_block_timeout, ret =3D -ETIMEDOUT, vm) {
> +		ret =3D panthor_vm_lock_region(vm, op->va.addr, op->va.range);
> +		if (ret)
> +			goto out;

[Severity: Low]
Is it safe to use a goto inside a scoped guard block when the function reli=
es
on a mix of scope-based and goto-based cleanup?

[Severity: Medium]
Will signal interruptions incorrectly return -ETIMEDOUT here?

The boolean guard panthor_sched_protm_block_timeout discards the specific
-ERESTARTSYS error from panthor_fw_protm_exit_wait(), and this macro hardco=
des
a timeout error on failure.

[ ... ]
> @@ -3517,3 +3575,54 @@ void panthor_mmu_pt_cache_fini(void)
[ ... ]
> +void panthor_mmu_protm_exit_event(struct panthor_device *ptdev)
> +{
[ ... ]
> +	guard(mutex)(&ptdev->mmu->as.slots_lock);
> +
> +	ptdev->mmu->as.delay_update_mask =3D 0;
> +
> +	if (!ptdev->mmu->as.delayed_update_mask)
> +		return;
> +
> +	ret =3D panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,

[Severity: Medium]
Is it possible that delayed_update_mask is never cleared back to 0?

The code checks delayed_update_mask to decide whether to flush the cache,
but it only clears delay_update_mask. Leaving delayed_update_mask non-zero
could trigger a full GPU cache flush on every exit from protected mode.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -2484,6 +2484,79 @@ static void group_term_work(struct work_struct *wo=
rk)
[ ... ]
> +bool panthor_sched_protm_block_timeout(struct panthor_device *ptdev,
> +				      struct panthor_vm *vm)
> +{
[ ... ]
> +	/* We do not want this function to fail, because that can lead to
> +	 * innocent processes failing. That is why we wait up to 2x the job
> +	 * timeout for GPU to exit protm here. This shall cover the worst case
> +	 * where protm work hangs and we must rely on job timeout to recover.
> +	 */
> +	ret =3D panthor_fw_protm_exit(ptdev, JOB_TIMEOUT_MS << 1);
> +	if (ret)
> +		up_read(&sched->protm.lock);
> +
> +	return ret ? false : true;
> +}

[Severity: Medium]
Does returning a boolean here discard the specific error code from
panthor_fw_protm_exit?

If panthor_fw_protm_exit_wait() returns -ERESTARTSYS, the boolean return ty=
pe
prevents propagating it to userspace, which breaks standard syscall restart
semantics.

[ ... ]
> @@ -3094,6 +3507,11 @@ void panthor_sched_post_reset(struct panthor_devic=
e *ptdev, bool reset_failed)
> =20
>  	mutex_lock(&sched->reset.lock);
> =20
> +	if (sched->protm.active_group) {
> +		group_put(sched->protm.active_group);
> +		sched->protm.active_group =3D NULL;
> +	}
> +

[Severity: High]
Does this modification of active_group without holding the proper
rw_semaphore introduce a data race?

The reader side panthor_sched_protm_block_timeout() checks and dereferences
sched->protm.active_group->vm while holding down_read(&sched->protm.lock).

Because panthor_sched_post_reset() sets active_group to NULL and drops its
reference without acquiring down_write(&sched->protm.lock), the group could
be freed out from under the ioctl thread causing a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012125940.3291=
951-1-ketil.johnsen@arm.com?part=3D5
