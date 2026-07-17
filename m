Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A646AC44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D1C810F4CA;
	Fri, 17 Jul 2026 09:24:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dB3ZSV0K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42A2F10F4CA
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:24:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 012FA43D79;
 Fri, 17 Jul 2026 09:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4CB1F000E9;
 Fri, 17 Jul 2026 09:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784280287;
 bh=kzIIV4L31STGqpKkxP1+H+GvH92cB1vO3AfQXraYMcU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dB3ZSV0KQpwViW1iOCOpH7pSkBQmqQkyd9ewoiJnDyLUjRAN5WCcJ3Z59HicwTGGY
 2+E7YOIs8kqZrX+8Bs17vDmzWZ8If7PumeI7+MjOEAtbZnu3I3Ncu9ipvp5kB6a3Y1
 NtKa/8F1CLr26hd6nxKQyH/coFtBjauax5vSXOxY/NklcN73QMXQGABurV09FEzcip
 DmHLu318gtob/9mR1lRa1LV9dlD5zv/PjDTOgMnN9kKzAYeEgrk1F/E1q6uZ8RjLyI
 5DxHbsFu7aZ2Wjh4Gtuo09V72PBPT2TO0vAW2/0N8uWO35zGdsf2TixYBVP5sZ+Hk4
 CufVz6AXPYcFA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v3 2/2] drm/panthor: Create per queue priority workqueues
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717090209.26931-3-tvrtko.ursulin@igalia.com>
References: <20260717090209.26931-1-tvrtko.ursulin@igalia.com>
 <20260717090209.26931-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 09:24:47 +0000
Message-Id: <20260717092447.AE4CB1F000E9@smtp.kernel.org>
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
- [High] Asynchronous teardown of `panthor_group` via `panthor_cleanup_wq` =
can race with device unplug and `drm_dev_release`, causing a Use-After-Free=
 of the DRM device and workqueues.
--

--- Patch [2]: [RFC v3 2/2] drm/panthor: Create per queue priority workqueu=
es ---
commit 55f41e3219b2c06b949efdf0212b58b264d95a7b
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/panthor: Create per queue priority workqueues

This commit splits the single workqueue used by the DRM scheduler into
multiple priority-based workqueues (low, medium, high, rt) to better serve
different GPU priority levels.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 5832dccfc0932..70e84ebb6c663 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c

[ ... ]

> @@ -4084,6 +4096,15 @@ static void panthor_sched_fini(struct drm_device *=
ddev, void *res)
>  	if (!sched || !sched->csg_slot_count)
>  		return;
> =20
> +	if (sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM])
> +		destroy_workqueue(sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM]);
> +
> +	if (sched->submit_wq[PANTHOR_CSG_PRIORITY_HIGH])
> +		destroy_workqueue(sched->submit_wq[PANTHOR_CSG_PRIORITY_HIGH]);
> +
> +	if (sched->submit_wq[PANTHOR_CSG_PRIORITY_RT])
> +		destroy_workqueue(sched->submit_wq[PANTHOR_CSG_PRIORITY_RT]);
> +

[Severity: High]
This is a pre-existing issue, but can this synchronous destruction race
with the asynchronous teardown of the queue?

When a user closes the device, the driver can schedule group_release on
the global panthor_cleanup_wq without holding a reference to the DRM
device:

group_release()
    ...
    queue_work(panthor_cleanup_wq, &group->release_work);

If this was the last reference, drm_dev_release can run immediately and
call panthor_sched_fini, which destroys these new submit_wq workqueues
and frees the ptdev allocation.=20

Meanwhile, the asynchronous release work executing group_free_queue can
attempt to access the destroyed queue->scheduler.submit_wq, or access
the already-freed ptdev memory:

panthor_kernel_bo_destroy()
    ...
    ptdev =3D container_of(bo->obj->dev, struct panthor_device, base);

Could this lead to a use-after-free since the release work isn't flushed
before the device teardown?

>  	if (sched->wq)
>  		destroy_workqueue(sched->wq);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717090209.2693=
1-1-tvrtko.ursulin@igalia.com?part=3D2
