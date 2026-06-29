Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E25CC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F94D10E05B;
	Mon, 29 Jun 2026 07:21:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAAB910E05B
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:21:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 33FCA411FA;
 Mon, 29 Jun 2026 07:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0091F000E9;
 Mon, 29 Jun 2026 07:21:50 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7.1.y] drm/amd/display: Fix ISM dc_lock deadlock during
 suspend
To: "Peter Jung" <admin@ptr1337.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260628140148.59923-1-admin@ptr1337.dev>
References: <20260628140148.59923-1-admin@ptr1337.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 07:21:39 +0000
Message-Id: <20260629072150.EB0091F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] The `idle_workqueue` is freed without correctly cancelling pen=
ding work, leading to a Use-After-Free and workqueue corruption.
- [High] Missing mutex_unlock(&dm->dc_lock) on error paths in the GPU reset=
 path of dm_suspend, leading to a permanent deadlock.
--

commit 147ffd2a09d9a0380b42af11648a4a34c2fd7170
Author: Ray Wu <ray.wu@amd.com>
drm/amd/display: Fix ISM dc_lock deadlock during suspend

This patch fixes an ABBA deadlock during suspend and resume by splitting
the ISM disable path. Workers are first quiesced without dc_lock, and then
the FSM is driven back to FULL_POWER_RUNNING under dc_lock.

Link: https://github.com/CachyOS/linux-cachyos/issues/900

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f8c13bad4ac23..560ab32989114 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2260,9 +2260,16 @@ static void amdgpu_dm_fini(struct amdgpu_device *a=
dev)
>  		adev->dm.idle_workqueue =3D NULL;
>  	}
> =20

[Severity: Critical]
This is a pre-existing issue, but is it possible for the idle_workqueue
to be freed while work is still pending?

In amdgpu_dm_fini(), flush_work() is only called if idle_workqueue->running=
=20
is true:

if (adev->dm.idle_workqueue->running) {
	adev->dm.idle_workqueue->enable =3D false;
	flush_work(&adev->dm.idle_workqueue->work);
}
kfree(adev->dm.idle_workqueue);

If schedule_work() was called but the worker hasn't started executing yet,
running remains false.

This means the cleanup logic will skip flush_work() and immediately kfree()
the structure. When the workqueue later processes the queued item, it will
access freed memory, causing a use-after-free.

[ ... ]

> @@ -3290,9 +3297,14 @@ static int dm_suspend(struct amdgpu_ip_block *ip_b=
lock)
>  	if (amdgpu_in_reset(adev)) {
>  		enum dc_status res;
> =20
> +		/* Quiesce ISM workers before taking dc_lock (workers take
> +		 * dc_lock themselves; syncing under it would deadlock).
> +		 */
> +		amdgpu_dm_ism_disable(dm);
> +
>  		mutex_lock(&dm->dc_lock);
> =20
> -		amdgpu_dm_ism_disable(dm);
> +		amdgpu_dm_ism_force_full_power(dm);
>  		dc_allow_idle_optimizations(adev->dm.dc, false);
> =20
>  		dm->cached_dc_state =3D dc_state_create_copy(dm->dc->current_state);

[Severity: High]
This isn't a bug introduced by this patch, but does the error path for=20
amdgpu_dm_commit_zero_streams() leave dm->dc_lock permanently locked?

Just below this hunk in dm_suspend(), the function handles a failure
by returning immediately:

res =3D amdgpu_dm_commit_zero_streams(dm->dc);
if (res !=3D DC_OK) {
	drm_err(adev_to_drm(adev), "Failed to commit zero streams: %d\n", res);
	return -EINVAL;
}

Since mutex_lock(&dm->dc_lock) was acquired right before this, the early=20
return skips unlocking the mutex.

This leaves the dc_lock permanently acquired, leading to a system deadlock
on subsequent accesses to the display manager.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628140148.5992=
3-1-admin@ptr1337.dev?part=3D1
