Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC49C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27EBA10E206;
	Mon, 14 Sep 2026 18:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ldla0HdC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829E010E206
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 18:48:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC3C16025F;
 Mon, 14 Sep 2026 18:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADC41F000FF;
 Mon, 14 Sep 2026 18:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789411726;
 bh=2L7trCGdcQK1LEJmd5fWxZy8yWE/ibPz2cP0tQg6sZk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ldla0HdCIrzzpPvGSS46fteXRMLShuc26ZI/Sd09vp5qjAklNg3+gQc9VkWKtFRlD
 4kMmRQA7kHFMpAlxOIJClo59KdePaq5V8Iyu2eaCi66qf21nfJQ1fQbsS0teV1tEgE
 S+C1QmVryfwFyLMadigL6oJKI5Bre19/sw9MNshoG2+URFPFL0IoWSt4kTlf/Wwale
 9xQ1MJlLQEeYCTCSu+DxMRw1zUMKIfjhVoIZQB/xaQpPJzAKdAFaj9xLwCsaJhRi/p
 HutkG1qcep2Azfl+Ht/pMBmjPGVjsmMU1XFxX1t3J+KP3m8M2F234Yes0EAQUGj3yj
 eShyCLyStMpww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/sched: document the RCU dependency
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914182740.1587-2-christian.koenig@amd.com>
References: <20260914182740.1587-1-christian.koenig@amd.com>
 <20260914182740.1587-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 18:48:45 +0000
Message-Id: <20260914184846.4ADC41F000FF@smtp.kernel.org>
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
- [High] The documented RCU grace period requirement for scheduler teardown=
 is insufficient to prevent Use-After-Free, and the underlying UAF remains =
reachable from userspace.
--

commit 5a72d906ede5cec7818892f2331889b7b0dd6420
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>

drm/sched: document the RCU dependency

This commit documents the requirement to wait for an RCU grace period
between signaling the last hardware fence and tearing down the scheduler.

> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1203,6 +1203,11 @@ static void drm_sched_cancel_remaining_jobs(struct=
 drm_gpu_scheduler *sched)
>   * is implemented, all jobs will be canceled through it and afterwards c=
leaned
>   * up through &struct drm_sched_backend_ops.free_job. If cancel_job is n=
ot
>   * implemented, memory could leak.
> + *
> + * The user must wait one RCU grace period between signaling the last ha=
rdware-
> + * fence and calling this function because the timeline name returned by
> + * scheduler fences must stay valid until all readers have exited their =
RCU read
> + * side critical section.
>   */
>  void drm_sched_fini(struct drm_gpu_scheduler *sched)

[Severity: High]
This is a pre-existing issue, but is waiting a single RCU grace period befo=
re
calling drm_sched_fini() actually sufficient to prevent a use-after-free he=
re?

If a user submits a job to obtain a sync_file fd for the scheduler fence, a=
nd
then the GPU queue or context is destroyed while jobs are pending (leaving
fences unsignaled), drivers like xe will tear down the scheduler and often
free the embedding structure without waiting for an RCU grace period:

drivers/gpu/drm/xe/xe_execlist.c:execlist_exec_queue_fini() {
    ...
    drm_sched_fini(&exl->sched);
    ...
    kfree(exl);
}

Since the fence doesn't detach from the scheduler, a subsequent userspace
query via SYNC_IOC_FILE_INFO will enter a new RCU read-side critical section
and access the timeline name on a fence that has outlived its scheduler:

drivers/dma-buf/sync_file.c:sync_fill_fence_info() {
    ...
    rcu_read_lock();
    ...
    timeline =3D dma_fence_timeline_name(fence);
    ...
}

Which then blindly dereferences the freed scheduler pointer:

drivers/gpu/drm/scheduler/sched_fence.c:drm_sched_fence_get_timeline_name()=
 {
    ...
    return (const char *)fence->sched->name;
}

Even if the driver waited for an RCU grace period before calling
drm_sched_fini(), couldn't new RCU readers still start querying the
unsignaled fence through sync_file long after the scheduler is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914182740.1587=
-1-christian.koenig@amd.com?part=3D2
