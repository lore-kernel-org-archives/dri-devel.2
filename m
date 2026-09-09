Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A9EC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 880DE10F0FA;
	Wed,  9 Sep 2026 13:29:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QbVB8/bR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B7510F0FA
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:29:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 945D360211;
 Wed,  9 Sep 2026 13:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200651F00A3A;
 Wed,  9 Sep 2026 13:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788960551;
 bh=sxChDdi4kdlCLp2bmoQm5hLDR+r0tNxE/rxgK8mKejM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QbVB8/bRO6N5HBgaLb2MFRuuy+2RgDMLlopQzsEtdMJchUHOMkm4+AaE5LRSJx3/R
 UqCSyJ/7IrlwyGiPU+SDfygvCil6sSkSYjxon8yQHKNXlLoFbLdXp8nmao7JBKmOgN
 RWmEwsC9Yk9zVKGuFJCoL/FB+VfGT4bgatmbRrzToFgKBg1RDzMdrcYXYT1/7JfBbW
 IyarKKsyym8P98jhoguDrYwmDBVxNhOt7nWFdphY5DDf/JD98YuAwEDQHZP7aahIMB
 9B0ZQYpqVUtIN9AQ/+OuScR4eI99ucKiuDefnOMloFbJHAl6AkZ7D5xpt8uKEnJwM+
 nU5YZ2iYk2haQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/sched: document the RCU dependency
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909131808.2201-3-christian.koenig@amd.com>
References: <20260909131808.2201-1-christian.koenig@amd.com>
 <20260909131808.2201-3-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:29:10 +0000
Message-Id: <20260909132911.200651F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing RCU grace period before freeing the drm_gpu_scheduler lead=
s to Use-After-Free.
--

commit 11a9a68f368e39faaeb53298fa915ab4e38a08eb
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>

drm/sched: document the RCU dependency

This commit adds documentation to drm_sched_fini() noting that an RCU grace
period is necessary between signaling the last scheduler fence and tearing
down the scheduler. It clarifies the consequences of adding RCU protection
to the returned strings from dma_fence backends.

> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 6cb6f95464938..22103cb077824 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1203,6 +1203,10 @@ static void drm_sched_cancel_remaining_jobs(struct=
 drm_gpu_scheduler *sched)
>   * is implemented, all jobs will be canceled through it and afterwards c=
leaned
>   * up through &struct drm_sched_backend_ops.free_job. If cancel_job is n=
ot
>   * implemented, memory could leak.
> + *
> + * The scheduler fences timeline name is returned protected by the signa=
led
> + * status and RCU, so an RCU grace period is necessary between signaling=
 the
> + * last scheduler fence and tearing down the scheduler who originated it.
>   */
>  void drm_sched_fini(struct drm_gpu_scheduler *sched)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but since we are documenting the
RCU grace period requirement here, does drm_sched_fini() or its callers
actually enforce this grace period?

Looking at several drivers, the scheduler memory is freed synchronously
immediately after calling drm_sched_fini() without an intervening
synchronize_rcu(). For example, in panthor_vm_destroy()
(drivers/gpu/drm/panthor/panthor_mmu.c):

    drm_sched_entity_destroy(&vm->entity);
    drm_sched_fini(&vm->sched);
    /* ... */
    kfree(vm);

Similarly, in aie2_hwctx_fini() (drivers/accel/amdxdna/aie2_ctx.c) and
msm_gem_vm_close() (drivers/gpu/drm/msm/msm_gem_vma.c), the scheduler
memory is freed synchronously after calling drm_sched_fini().

Since unprivileged userspace can control the creation and destruction of
VMs and contexts via standard driver ioctls, could this lead to a
use-after-free? Concurrently, the RCU read-side critical section in
dma_fence_get_timeline_name() can access the freed scheduler pointer
(fence->sched->name). Should synchronize_rcu() be added, or the free
deferred using kfree_rcu(), to prevent this UAF?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909131808.2201=
-1-christian.koenig@amd.com?part=3D2
