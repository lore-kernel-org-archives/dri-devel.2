Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1568CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E285C10EA50;
	Wed, 17 Jun 2026 14:43:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j0JUZbr+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9680810EA50
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 14:43:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BFDF660052;
 Wed, 17 Jun 2026 14:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603DE1F000E9;
 Wed, 17 Jun 2026 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781707395;
 bh=14VhWIUkf45rxsa79bBF6+syNwy+BLi4V+fL3VghuS4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j0JUZbr+q8LG1SCbl4X0tg4LjMRQ1Lgye3OFFHagKwAxBf58EWyAHR1cAKZDAw91V
 bkhLTaP9XYPANxEXXeU2hdi7xB2ydoe0Ie/b8dtEfsthOpoykLBKMoBWOi5HOgXY3n
 v+dkULWvSLsk/x5rVxBe/TilwAl1KiQac2KMo1fE4xYs/rhNKW3VmpV1GHdaDjySwE
 0r9ReLsGbwZthjNb6P0/J6uFiVze0uXTdNLPUeTKV7CfYvW4XI/QOIJq3mGJKYu1kT
 TQJqnjfMrNiFk+jNAxoLrPytvTT276/JwUsyA+DQnA2tvhb06bmzUe3BIiCn+dyc+B
 Ok2I8SfDJs41A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panfrost: Enable cycle counting when perfcnt is
 enabled
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617-panfrost-perfcnt-timestamp-fix-v1-1-f215f44b55c0@collabora.com>
References: <20260617-panfrost-perfcnt-timestamp-fix-v1-1-f215f44b55c0@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 14:43:14 +0000
Message-Id: <20260617144315.603DE1F000E9@smtp.kernel.org>
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
- [High] Enabling perfcnt introduces a long-lived cycle counter reference t=
hat is forcefully and incorrectly cleared by a GPU soft reset, permanently =
breaking cycle counting.

Pre-existing issues:
- [High] Concurrently submitting a job during a GPU reset causes an unbalan=
ced `panfrost_cycle_counter_put()`, permanently corrupting the cycle counte=
r reference count.
--

commit c238efd4d96ef26a59cfb145cb471bac9ab43fe6
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panfrost: Enable cycle counting when perfcnt is enabled
   =20
If we don't do that, we end up with invalid timestamps in the
block headers.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index 7020c0192e189..63861b4c7d953 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c

[ ... ]

> @@ -166,6 +167,7 @@ static int panfrost_perfcnt_enable_locked(struct panf=
rost_device *pfdev,
>  	/* The BO ref is retained by the mapping. */
>  	drm_gem_object_put(&bo->base);
> =20
> +	panfrost_cycle_counter_get(pfdev);

[Severity: High]
Does this long-lived cycle counter reference interact correctly with GPU so=
ft
resets?

Looking at panfrost_gpu_soft_reset(), it seems to assume only in-flight
jobs hold the cycle counter reference, and forcefully zeroes it if it's
non-zero:

drivers/gpu/drm/panfrost/panfrost_gpu.c:panfrost_gpu_soft_reset() {
	...
	if (drm_WARN_ON(&pfdev->base, atomic_read(&pfdev->cycle_counter.use_count)=
 !=3D 0))
		atomic_set(&pfdev->cycle_counter.use_count, 0);
	...
}

If a reset occurs while perfcnt is active, the use_count is zeroed. Later,
when panfrost_perfcnt_disable_locked() is called, it will call
panfrost_cycle_counter_put(). Because the count is already 0, the internal
atomic_add_unless() will decrement it to -1:

drivers/gpu/drm/panfrost/panfrost_gpu.c:panfrost_cycle_counter_put() {
	...
	if (atomic_add_unless(&pfdev->cycle_counter.use_count, -1, 1))
		return;
	...
}

Once it reaches -1, future calls to panfrost_cycle_counter_get() will use
atomic_inc_not_zero() to increment it from -1 to 0, returning early without
starting the hardware cycle counter.

Can this cause cycle counting to permanently stop working?

>  	perfcnt->user =3D user;
> =20
>  	return 0;

[ ... ]

> @@ -207,6 +209,7 @@ static int panfrost_perfcnt_disable_locked(struct pan=
frost_device *pfdev,
>  	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
>  	panfrost_gem_mapping_put(perfcnt->mapping);
>  	perfcnt->mapping =3D NULL;
> +	panfrost_cycle_counter_put(pfdev);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the cycle
counter refcounting, another issue was found in panfrost_job.c where the
reference count can also underflow.

If a job is submitted during a GPU reset, panfrost_job_hw_submit() enqueues
the job but skips calling panfrost_cycle_counter_get() because the reset is
pending:

drivers/gpu/drm/panfrost/panfrost_job.c:panfrost_job_hw_submit() {
	subslot =3D panfrost_enqueue_job(pfdev, js, job);
	/* Don't queue the job if a reset is in progress */
	if (!atomic_read(&pfdev->reset.pending)) {
		job->is_profiled =3D pfdev->profile_mode;

		if (job->requirements & PANFROST_JD_REQ_CYCLE_COUNT ||
		    job->is_profiled)
			panfrost_cycle_counter_get(pfdev);
		...
}

Shortly after, panfrost_reset() iterates over the scheduled jobs and
unconditionally calls panfrost_cycle_counter_put() if the job requires it:

drivers/gpu/drm/panfrost/panfrost_job.c:panfrost_reset() {
	...
	for (j =3D 0; j < ARRAY_SIZE(pfdev->jobs[0]) && pfdev->jobs[i][j]; j++) {
		if (pfdev->jobs[i][j]->requirements & PANFROST_JD_REQ_CYCLE_COUNT ||
		    pfdev->jobs[i][j]->is_profiled)
			panfrost_cycle_counter_put(pfdev->jobs[i][j]->pfdev);
	...
}

Could this create a scenario where a put is called without a prior get,
underflowing use_count to -1 in the same manner and permanently breaking the
cycle counter?

>  	pm_runtime_put_autosuspend(pfdev->base.dev);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-panfrost-p=
erfcnt-timestamp-fix-v1-1-f215f44b55c0@collabora.com?part=3D1
