Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB93AC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEACF10F1BF;
	Thu, 27 Aug 2026 20:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J2KUKI3b";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38BCD10F1BF
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:47:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BEAE600D4
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E445A1F000E9;
 Thu, 27 Aug 2026 20:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787863678;
 bh=WEyJ6ZFcaf8oHr1hKyJywt7EofH6eg67rUoSPRe2les=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J2KUKI3bi4gDyubDvuLRIEyM6MFDyu18gVBZagbKh7eCpA3Rd0GIbxfew+WTSqyRS
 52Exue00JW4voU0SbtEm7irjhngFTQ2WQGAm1Q63toTFXybQbOXYPd6iDcs97/quHW
 gJNj6TQ+pO9FlwEPyX3UzjP3TFE01n6zAGDkioY1ldFu5hPpXEiiamCk78nNhuHeOy
 3+u17lziLY8noIc5NqUTX0rh3bV0W3HYOolBzA5kEfN0HR8gVI/foB0Dd+R94bU4OJ
 PXGIODLllB5VFoL4sZHH1S9vuwGhfisHbZNQVv5FZxvFWi9c6ZWt2mamR671J9WS7Q
 EJwNCqIGVcOvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] accel: ethosu: Ensure SRAM region size matches job
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827-ethosu-fixes-v1-5-346f9ea8791c@kernel.org>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-5-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:47:57 +0000
Message-Id: <20260827204757.E445A1F000E9@smtp.kernel.org>
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
- [Critical] Kernel panic due to NULL pointer dereference in `drm_sched_job=
_cleanup` on uninitialized job.
- [High] Memory leak of `done_fence` on error paths controllable by userspa=
ce.
- [High] Lockless TOCTOU race in IRQ handler causing premature signaling of=
 unrelated jobs.
--

commit ac51039957292dc327d760628e45a0de5289b27b
Author: Rob Herring (Arm) <robh@kernel.org>

    accel: ethosu: Ensure SRAM region size matches job
   =20
    It is possible for userspace to set the job SRAM size to 0, but then st=
ill
    have SRAM accesses in the command stream. When the job SRAM size is 0,
    setting the region base register is skipped and a stale base address fr=
om
    a prior job is used.
   =20
    Check the region size against the job's SRAM size instead of just the s=
ize
    of the SRAM. The job's SRAM size was already checked against the total =
SRAM
    size.

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> index c33f2877b3850..0982722a9195a 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -441,13 +441,13 @@ static int ethosu_ioctl_submit_job(struct drm_devic=
e *dev, struct drm_file *file
>  			if (!cmd_info->region_size[i])
>  				continue;
>  			if (i =3D=3D ETHOSU_SRAM_REGION) {
> -				if (cmd_info->region_size[i] <=3D edev->npu_info.sram_size)
> +				if (cmd_info->region_size[i] <=3D ejob->sram_size)
>  					continue;
> =20
>  				dev_err(dev->dev,
> -					"cmd stream region %d size greater than SRAM size (%llu > %u)\n",
> +					"cmd stream region %d size greater than job SRAM size (%llu > %u)\n=
",
>  					i, cmd_info->region_size[i],
> -					edev->npu_info.sram_size);
> +					ejob->sram_size);
>  				ret =3D -EINVAL;
>  				goto out_cleanup_job;

[Severity: High]
This isn't a bug introduced by this patch, but this newly modified error pa=
th
can trigger a memory leak. If the region size validation fails here, we jump
to out_cleanup_job. Does this leak the dynamically allocated
ejob->done_fence?

In ethosu_job_err_cleanup(), the job is freed:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_err_cleanup() {
    ...
	drm_gem_object_put(job->cmd_bo);

	kfree(job);
}

But it doesn't appear to free job->done_fence, allowing unprivileged
userspace to trigger a memory leak by intentionally submitting jobs with
mismatched SRAM region sizes.

>  			}

[Severity: Critical]
This is a pre-existing issue, but there is a potential NULL pointer
dereference in the error handling path for this function.

If kzalloc_obj for ejob->done_fence fails earlier in
ethosu_ioctl_submit_job(), the code jumps to out_cleanup_job without
initializing the scheduler job:

drivers/accel/ethosu/ethosu_job.c:ethosu_ioctl_submit_job() {
    ...
	ejob->done_fence =3D kzalloc_obj(*ejob->done_fence);
	if (!ejob->done_fence) {
		ret =3D -ENOMEM;
		goto out_cleanup_job;
	}
    ...
out_cleanup_job:
	if (ret)
		drm_sched_job_cleanup(&ejob->base);
}

Because drm_sched_job_init() was never called, ejob->base.s_fence is NULL.
Will this cause a NULL pointer dereference when drm_sched_job_cleanup()
attempts to read the refcount?

drivers/gpu/drm/scheduler/sched_main.c:drm_sched_job_cleanup() {
    ...
	if (kref_read(&job->s_fence->finished.refcount)) {
    ...
}


[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a lockle=
ss
TOCTOU race in the IRQ handler that could cause premature signaling of
unrelated jobs.

In ethosu_job_handle_irq(), the in_flight_job is read and signaled lockless=
ly:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_handle_irq() {
    ...
	job =3D READ_ONCE(dev->in_flight_job);
	if (job) {
		WRITE_ONCE(dev->in_flight_job, NULL);
		dma_fence_signal(job->done_fence);
	}
    ...
}

If the threaded IRQ handler is delayed and a hardware timeout occurs
concurrently, ethosu_job_timedout() clears in_flight_job and the scheduler
starts the next job.

When the delayed IRQ thread resumes, could it read the new in_flight_job,
clear it, and erroneously signal the new job's fence before it has finished
executing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-ethosu-fix=
es-v1-0-346f9ea8791c@kernel.org?part=3D5
