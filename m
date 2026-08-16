Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB61C5DF6D
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 16:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FC0F10E328;
	Sun, 16 Aug 2026 16:27:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XPQwQYlc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 615C210E328
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 16:27:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2455D60120;
 Sun, 16 Aug 2026 16:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38741F000E9;
 Sun, 16 Aug 2026 16:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786897670;
 bh=xbkKugRt7NQ8L0hR57NnZMkOp8GuiwbCAXBies33PgA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XPQwQYlcOewW9sjmGkreUjfFhGhyvkLm5X3lBpUysZ3NvESHqf29WA3DLtYYCkKAG
 nxXx3tImUUKsgBZXqIH0fRd3URQLiiRGtex0Ju75SvwmU725erYdTEUZRrKity/zse
 tvgeM3aG5Dbm7dgi+DZXtuMUQr9ExJvVrKC9lyrFgJBvC/1mO7Rk5AA2fqd3o9HUyP
 SvjbnU5NQ/N0h2vMQNmhp+a5lOeQjQWxiZoZQzKIJQMVnyvKwpAcOEyCWySzW1QpG1
 dUlnkwJpcWsN0BWp8qaBpM2PJ6mhSlcj0AxxV6scaTJd0gYMPYUhmq+Wv9i4D/a5Nq
 OvV/E+NXIg4Ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/amdgpu/userq: hold the doorbell xa lock during
 hang reset
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260817-amdgpu-fixes-v1-2-36d5298da646@outlook.com>
References: <20260817-amdgpu-fixes-v1-0-36d5298da646@outlook.com>
 <20260817-amdgpu-fixes-v1-2-36d5298da646@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 16:27:50 +0000
Message-Id: <20260816162750.B38741F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unprotected xa_for_each iteration allows concurrent Use-After-Free.
- [High] Lockless and unprotected access to userq->last_fence can result in=
 a Use-After-Free.
- [Medium] Unprotected state modification of queue->state causes a data rac=
e.
--

--- Patch [2]: [PATCH 2/2] drm/amdgpu/userq: hold the doorbell xa lock duri=
ng hang reset ---
commit c3c720e398b80f11731a92d4798c53c135bb4886
Author: Junrui Luo <moonafterrain@outlook.com>

drm/amdgpu/userq: hold the doorbell xa lock during hang reset

This commit fixes a use-after-free vulnerability in the AMDGPU driver.
It adds an xa_lock_irqsave() lock around an xa_for_each() loop in
mes_userq_detect_and_reset() to prevent the queue from being freed
while iterating.

> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 4e44a581a78a2..f4d12e4b2d483 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c

[ ... ]

> @@ -230,6 +230,13 @@ static int mes_userq_detect_and_reset(struct amdgpu_=
device *adev,
>  	if (r) {
>  		dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
>  	} else if (hung_db_num) {
> +		/*
> +		 * The doorbell xarray is device wide, so this walks queues
> +		 * owned by other drm_files too. Hold its lock: the free path
> +		 * erases the entry under the same lock strictly before it
> +		 * frees the queue, so an entry found here stays allocated.
> +		 */
> +		xa_lock_irqsave(&adev->userq_doorbell_xa, flags);
>  		xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {

[Severity: High]
This isn't a bug introduced by this patch, but since you are fixing the
xa_for_each() iteration here, I noticed several other functions iterate
adev->userq_doorbell_xa locklessly.

For example, in amdgpu_userq_stop_sched_for_enforce_isolation():

    xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
        uqm =3D queue->userq_mgr;
        cancel_delayed_work_sync(&uqm->resume_work);
        mutex_lock(&uqm->userq_mutex);

Similar loops exist in amdgpu_userq_start_sched_for_enforce_isolation() and
amdgpu_userq_suspend().

The xa_for_each macro only uses rcu_read_lock() internally during the looku=
p.

Could an unprivileged user trigger amdgpu_userq_destroy() concurrently and
free the queue, causing a use-after-free when the loop body dereferences
queue->userq_mgr?

>  			if (queue->queue_type =3D=3D queue_type) {
>  				for (i =3D 0; i < hung_db_num; i++) {
>  					if (queue->doorbell_index =3D=3D db_array[i]) {
>  						queue->state =3D AMDGPU_USERQ_STATE_HUNG;

[Severity: Medium]
This is a pre-existing issue, but does assigning queue->state here without
holding queue->userq_mgr->userq_mutex cause a data race?

Concurrently, actions like amdgpu_userq_start_sched_for_enforce_isolation()=
 or
PM resume can call amdgpu_userq_map_helper() under userq_mutex, which also
evaluates and sets queue->state.

Could this lead to lost updates where the AMDGPU_USERQ_STATE_HUNG state is
overwritten?

>  						found_hung_queue =3D true;
>  						atomic_inc(&adev->gpu_reset_counter);
>  						amdgpu_userq_fence_driver_force_completion(queue);

[Severity: High]
This is a pre-existing issue, but is it safe to call
amdgpu_userq_fence_driver_force_completion() here?

This function reads userq->last_fence without taking
queue->userq_mgr->userq_mutex or holding rcu_read_lock():

amdgpu_userq_fence_driver_force_completion()
    struct dma_fence *f =3D userq->last_fence;
    if (f) {
        struct amdgpu_userq_fence *fence =3D to_amdgpu_userq_fence(f);

Concurrently, amdgpu_userq_fence_init() (called under userq_mutex) updates
userq->last_fence and drops the old fence reference via dma_fence_put().

Since xa_lock_irqsave() maps to a sleeping lock on PREEMPT_RT kernels and
does not disable interrupts, the RCU grace period could end.

Could this allow the fence memory to be freed before to_amdgpu_userq_fence(=
f)
accesses f->ops, resulting in a use-after-free?

> -						drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, N=
ULL);
>  					}
>  				}
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-amdgpu-fix=
es-v1-0-36d5298da646@outlook.com?part=3D2
