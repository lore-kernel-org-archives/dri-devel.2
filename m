Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EF7C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4854110E5E2;
	Fri, 11 Sep 2026 23:47:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SrDQdGQY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC21810E5E2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:47:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC82A40550;
 Fri, 11 Sep 2026 23:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FF11F00898;
 Fri, 11 Sep 2026 23:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789170429;
 bh=DifPt3te7RAE8CVqlbwO1y0t7m/r4VSdCXeMUHA1rn4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SrDQdGQYjhazzn6eu7PLFpMblqedNup/EdwqdKO1jghYD9/Ib8/hTPaBZx90r9QPX
 bv3dGktjAnxWPVViSairCxFpa46d+O9N/ML2tUwDXvt+VVgMI1KGxzDzFD4BL+/1O+
 dRTGGEPXtrnJQhnc97SgFwdgsz08sP2yNFMtKag6aDCLWHHyTmWlbNQyio30Evcfjx
 de51QuM2mhinhQHAtlQT3H/4vY1ycpPyPtT4QyhEigoYTbbcn2kGtMk4RQ5STnDoSg
 w1lXvxR8uVrc/ILSpJ5kPkpThvUP7wpusTw0uDHSY5DwLjjJFZ1cJLj9D+WOXY7b0s
 7gEeG4Y/wMaAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 14/16] drm/panfrost: Introduce a reset lock
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912-claude-fixes-v9-14-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-14-e588feaa61ef@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:47:09 +0000
Message-Id: <20260911234709.65FF11F00898@smtp.kernel.org>
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
- [High] Unprotected hardware register access in panfrost_gpu_get_latest_fl=
ush_id() risks data corruption and bus errors during concurrent GPU resets.
- [High] Power leak in panfrost_ioctl_query_timestamp() due to incorrect PM=
 runtime put API.
--

commit 8d0ec71108e67c1469d4f0da23df91f3320d12ae
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Introduce a reset lock

So as to avoid accessing HW register while a reset is ongoing, a read/write
semaphore that envelopes the reset sequence will help driver entry points
avoid racing with it. For now, the only such racy entry point is the ioctl
that returns the current GPU timestmap.

> For now, the only such racy entry point is the ioctl
> that returns the current GPU timestmap.

[Severity: High]
This is a pre-existing issue, but does panfrost_ioctl_submit() in
drivers/gpu/drm/panfrost/panfrost_drv.c also need to hold pfdev->reset.lock?

It calls panfrost_gpu_get_latest_flush_id() in
drivers/gpu/drm/panfrost/panfrost_gpu.c, which reads the
GPU_LATEST_FLUSH_ID hardware register directly:

panfrost_ioctl_submit()
  job->flush_id =3D panfrost_gpu_get_latest_flush_id(pfdev);
    flush_id =3D gpu_read(pfdev, GPU_LATEST_FLUSH_ID);

If a user calls panfrost_ioctl_submit() concurrently with a job timeout
triggering panfrost_reset(), reading the hardware register during a GPU soft
reset could return garbage data or trigger a bus error. A corrupted flush ID
could cause the GPU to skip necessary cache flushes.

[ ... ]

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index f77780c72a1ae..571a26b841269 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -41,9 +41,12 @@ static int panfrost_ioctl_query_timestamp(struct panfr=
ost_device *pfdev,
>  	if (ret)
>  		return ret;
> =20
> -	panfrost_cycle_counter_get(pfdev);
> -	*arg =3D panfrost_timestamp_read(pfdev);
> -	panfrost_cycle_counter_put(pfdev);
> +	/* We should not read timestamp register while the GPU  is being reset =
*/
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		panfrost_cycle_counter_get(pfdev);
> +		*arg =3D panfrost_timestamp_read(pfdev);
> +		panfrost_cycle_counter_put(pfdev);
> +	}
> =20
>  	pm_runtime_put(pfdev->base.dev);

[Severity: High]
This isn't a bug introduced by this patch, but does calling pm_runtime_put()
in panfrost_ioctl_query_timestamp() cause the GPU power to remain on
indefinitely?

Since the driver uses autosuspend (dev->power.use_autosuspend is true), the=
 PM
core's rpm_idle returns -EAGAIN and fails to schedule the suspend timer when
pm_runtime_put() is called instead of pm_runtime_put_autosuspend(). Any
unprivileged user calling the query IOCTL could trigger this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-claude-fix=
es-v9-0-e588feaa61ef@collabora.com?part=3D14
