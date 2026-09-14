Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546D8C88E67
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACFAD10E085;
	Mon, 14 Sep 2026 05:08:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c9WwvuQw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DA8D10E085
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 05:08:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CBE761394;
 Mon, 14 Sep 2026 05:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFF91F000FF;
 Mon, 14 Sep 2026 05:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789362500;
 bh=50oI7sxIajIy5kpZQKb7uNhghQZ0TLUZa9bOmGps64s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c9WwvuQw67KhyqtmO8tjCAryuByl0YkBPrd1OzaSFQDb9I64FrbZdzhXpFhW2TEXl
 MwFm8h5q+PedIXUxAXBIyN658IweAkpbh24/1AgodVHsxzpJqpctVYXhaL5mwashJh
 0UWv9kwQ6IZ3+GcCQoNR0qFqvH2UYMzzPa6O2CwS3uCyYCRh7gh46XRicHFc9MhYTL
 2SpnddM/I4/EdeaFzZx9sHOLZU+EcnhjAcveOKkTBD73bez4ya3Ysn3gyaP9D5CBBn
 PrEZKmA7PNXzfZJEphYqg3mI2kicqw4w0m9k2O5sLEM9Mi7tYSsCyQBbdRhydsCOI+
 0KSKzRxY2lePA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] accel/rocket: Check allocations before use
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914045605.381933-2-triet.hoang.dev@gmail.com>
References: <20260914045605.381933-1-triet.hoang.dev@gmail.com>
 <20260914045605.381933-2-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 05:08:19 +0000
Message-Id: <20260914050819.BFFF91F000FF@smtp.kernel.org>
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
- [High] Silent failure when submitting multiple jobs due to ignored return=
 value.
- [High] Violation of DRM scheduler contract by calling drm_sched_job_clean=
up() on an armed job.
--

commit e8a7bda4ea0e8bc90689dd01aad3165b7c5004b2
Author: Triet Hoang <triet.hoang.dev@gmail.com>

accel/rocket: Check allocations before use

Check the result of kmalloc_objs() in rocket_job_open() before using the
allocated buffers. It also updates the error handling when
drm_sched_entity_init() fails by replacing WARN_ON(ret) with a plain if.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index f404355058185..ffa0f8db5da65 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -516,6 +516,9 @@ int rocket_job_open(struct rocket_file_priv *rocket_p=
riv)
>  	unsigned int core;
>  	int ret;
> =20
> +	if (!scheds)
> +		return -ENOMEM;
> +

[ ... ]

While reviewing this code, I noticed a couple of pre-existing issues in this
file.

[Severity: High]
This is a pre-existing issue, but does calling drm_sched_job_arm() before
rocket_acquire_object_fences() violate the DRM scheduler contract if
resource acquisition fails?

In rocket_job_push():

	scoped_guard(mutex, &rdev->sched_lock) {
		drm_sched_job_arm(&job->base);

		job->inference_done_fence =3D
			dma_fence_get(&job->base.s_fence->finished);

		ret =3D rocket_acquire_object_fences(job->in_bos,
						   job->in_bo_count,
						   &job->base, false);
		if (ret)
			goto err_unlock;

If rocket_acquire_object_fences() returns an error (e.g., due to -ENOMEM in
dma_resv_reserve_fences), the error path aborts the armed job by calling
drm_sched_job_cleanup() back in rocket_ioctl_submit_job().

Since drm_sched_job_arm() initializes fences and assigns a sequence number,
aborting it afterward leaks the assigned sequence number and can corrupt the
scheduler's fence ordering, leading to hangs or crashes in the DRM scheduler
core.


[Severity: High]
This is a pre-existing issue, but is it intentional that the return value of
rocket_ioctl_submit_job() is ignored?

In rocket_ioctl_submit():

	for (i =3D 0; i < args->job_count; i++)
		rocket_ioctl_submit_job(dev, file, &jobs[i]);

exit:
	kvfree(jobs);

	return ret;

If rocket_ioctl_submit_job() fails (e.g., due to an invalid BO handle or
-ENOMEM), the failure is silently swallowed and not propagated.

The ioctl will return success even when jobs were not queued, which can cau=
se
userspace clients waiting on implicit fences for these jobs to hang
indefinitely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914045605.3819=
33-1-triet.hoang.dev@gmail.com?part=3D1
