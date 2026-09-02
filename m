Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91118C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B3510E02C;
	Wed,  2 Sep 2026 11:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iVUAMbY6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8063510E02C
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 11:12:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E17442A2A;
 Wed,  2 Sep 2026 11:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C551D1F00A3A;
 Wed,  2 Sep 2026 11:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788347554;
 bh=8yDNmMusrw2Wu2FKfz6apWqvF7kaUmBEditGx+Yg+uk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iVUAMbY6OgQII5TYXHsq3Qj3ZzP9NaFVSPm5mtaW4bfFSumXed1/XpVaJQ4wi6etm
 bRHLEbtzs8te4+34FbRcUoZXjPm1LXUapJjMoboRc/Cpgs8udGDAfYY08p4vbNDzoU
 J1ZLPrWd468DsoZiE+zyxmUBY+Kss+lm0UcQtl+tVskhpntevaF2+0rz7pEggTBAHe
 P7q+GMk459cmR1UFuZQatEl4vO4GGsSgzM8N7EYX8WBQ62PzTOSr7cZB3nPz1IGMMl
 QT3mAdS+DfYn+mUxni7HaQH60mAZvfsszomZpKYR1A5K8JvtSbDnuoJHBfarrFmUQd
 uDKeU/Xe4OH6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/sched: cache the timeline name to fix a
 use-after-free
To: =?utf-8?b?Sm9uZ2h5dWsgS2ltKE1hbEh5dWsp?= <malhyuk97@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902105808.1541063-2-malhyuk97@gmail.com>
References: <20260902105808.1541063-1-malhyuk97@gmail.com>
 <20260902105808.1541063-2-malhyuk97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:12:34 +0000
Message-Id: <20260902111234.C551D1F00A3A@smtp.kernel.org>
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

New issues:
- [High] The patch fails to fully fix the Use-After-Free in get_timeline_na=
me() for drivers that dynamically allocate the timeline name (drm/panthor a=
nd drm/xe). Caching the pointer merely shifts the UAF to the string's lifet=
ime.

Pre-existing issues:
- [High] amdgpu_sync_same_dev blindly casts any drm_sched_fence to an amdgp=
u_ring, causing out-of-bounds reads and potential use-after-free for foreig=
n fences.
- [High] pvr_queue_fence_is_native dereferences sched_fence->sched->ops on =
foreign fences, leading to a Use-After-Free if the foreign scheduler was de=
stroyed.
--

commit 5c48f101c7375d5ec48751f42c79a19d2a8e35b2
Author: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>

drm/sched: cache the timeline name to fix a use-after-free

This commit caches the scheduler's timeline name during fence initialization
to prevent a use-after-free when querying the timeline name of a finished
fence whose scheduler was destroyed. It updates get_timeline_name to use
this cached value instead of dereferencing the scheduler.

> This is the same class as CVE-2025-38703 (drm/xe) and CVE-2025-71302
> (drm/panthor), which were fixed per-driver. amdxdna, nouveau and msm
> (VM_BIND) are still affected in mainline, so fix it in the core to cover =
any
> per-context-scheduler driver at once.

[Severity: High]
This isn't a bug introduced by this patch, but amdgpu_sync_same_dev blindly
casts any drm_sched_fence to an amdgpu_ring, which can cause out-of-bounds
reads and potential use-after-free for foreign fences.

If a userspace process creates a job on a different DRM driver that uses
drm/scheduler, exports the resulting dma_fence to a sync_file, and passes it
as a dependency to an amdgpu job, can this cast access out-of-bounds memory?

drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c:amdgpu_sync_same_dev() {
    ...
		struct amdgpu_ring *ring;

		ring =3D container_of(s_fence->sched, struct amdgpu_ring, sched);
		return ring->adev =3D=3D adev;
    ...
}

Since the foreign scheduler is not embedded in an amdgpu_ring, this accesses
memory outside the struct. If the foreign scheduler was per-context and
already destroyed by closing the context, could this also result in a
use-after-free?

[Severity: High]
This is a pre-existing issue, but pvr_queue_fence_is_native dereferences
sched_fence->sched->ops on foreign fences, which can lead to a
use-after-free if the foreign scheduler was destroyed.

If a userspace process creates a job on a DRM driver that allocates
per-context schedulers, exports the dma_fence, closes the context (which
frees the scheduler), and then submits a job to the Imagination PVR driver
passing the exported fence as a dependency:

drivers/gpu/drm/imagination/pvr_queue.c:pvr_queue_fence_is_native() {
    ...
	struct drm_sched_fence *sched_fence =3D f ? to_drm_sched_fence(f) : NULL;

	if (sched_fence &&
	    sched_fence->sched->ops =3D=3D &pvr_queue_sched_ops)
		return true;
    ...
}

Because the foreign per-context scheduler was already freed, will accessing
sched_fence->sched->ops result in a use-after-free?

> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/sc=
heduler/sched_fence.c
> index 096fe28aa9c9e..a944eeeb25bd7 100644
> --- a/drivers/gpu/drm/scheduler/sched_fence.c
> +++ b/drivers/gpu/drm/scheduler/sched_fence.c

[ ... ]

> @@ -228,6 +234,14 @@ void drm_sched_fence_init(struct drm_sched_fence *fe=
nce,
>  	unsigned seq;
> =20
>  	fence->sched =3D entity->rq->sched;
> +	/*
> +	 * Cache the scheduler's timeline name. The finished fence may be
> +	 * exported to userspace and outlive @sched (per-context schedulers are
> +	 * freed on context teardown), so get_timeline_name() must not
> +	 * dereference @sched. The name is required to outlive any exported
> +	 * fence (see @name in struct drm_sched_init_args).
> +	 */
> +	fence->sched_name =3D fence->sched->name;

[Severity: High]
Does caching the name pointer fully fix the use-after-free for drivers like
drm/panthor and drm/xe that dynamically allocate the timeline name?

In drm/panthor, queue->name is dynamically allocated and freed immediately
via kfree upon queue teardown:

drivers/gpu/drm/panthor/panthor_sched.c:group_create_queue() {
    ...
	queue->name =3D kasprintf(GFP_KERNEL, "panthor-queue-%llu-%u-%u", drm_clie=
nt_id, gid, qid);
    ...
}

If an exported dma_fence held in a sync_file outlives the queue, and
userspace later calls SYNC_IOC_FILE_INFO, won't
drm_sched_fence_get_timeline_name return this cached pointer which now
points to freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902105808.1541=
063-1-malhyuk97@gmail.com?part=3D1
