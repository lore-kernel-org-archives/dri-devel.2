Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C84CD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D8210E643;
	Fri,  5 Jun 2026 16:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rp379ftg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E78EA10E643
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 16:25:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B3E3D4389E;
 Fri,  5 Jun 2026 16:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7879A1F00893;
 Fri,  5 Jun 2026 16:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780676748;
 bh=6dTlGZVql1X743tOXHxzARiDwKG7vlC1fGoU0Nis3sU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rp379ftgegr/tPzXqdu0HsmTuz952YbPSZ1vMIzd8hbDlxgdVSqpMYcP3sYcmbksK
 g2IHClfuccxQwx6YrQjeBpgbsilBHtEoalSZcAzugQ6JMIG4H/mZzq7EvX4UFkmuWn
 Q5voQZiJlYtKzdyH52TrsxvmlTBScPKqH8YGimrW+I54hXhF/RyVyBFT4wHvf75dqy
 5rkfgGpWSY+LEn0954Uz+pnQjkWZtv80Qj1XF3uon2eTtEXmwh+t46LuzCA4vXvmbd
 hBzhhfoFLnOk5y72iOuW7z5gZ4I6HieLI7Cd251UAunREErA2wi/aQ0ovZnIbYX2sd
 iWWqhou88lTPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/rocket: Remove unused reset worker
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605-rocket-per-task-jobs-v1-1-e3319adf3c49@igalia.com>
References: <20260605-rocket-per-task-jobs-v1-1-e3319adf3c49@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 16:25:48 +0000
Message-Id: <20260605162548.7879A1F00893@smtp.kernel.org>
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
- [High] `rocket_iommu_domain_put()` does not check for NULL before derefer=
encing, leading to a crash on the error path.
- [Medium] The ioctl handler silently ignores errors when submitting multip=
le jobs, reporting success to userspace even if submissions fail.
--

commit cc3020dc8d8efb7ac65346d6d8612ab4fbbadb48
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/rocket: Remove unused reset worker

The reset.work work_struct and its rocket_reset_work() handler were
initialized and cancelled, but never actually queued. This patch drops
the dead worker, its initialization, cancellation, and the unused struct
member.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 2f1861f960ccb..8a26139a44f46 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but can this lead to a NULL pointer dereferen=
ce
on the error path?

In rocket_ioctl_submit_job(), if rocket_copy_tasks() fails, it jumps to
out_cleanup_job, which then falls through to out_put_job:

drivers/accel/rocket/rocket_job.c:rocket_ioctl_submit_job() {
	...
	ret =3D rocket_copy_tasks(dev, file, job, rjob);
	if (ret)
		goto out_cleanup_job;
	...
out_cleanup_job:
	if (ret)
		drm_sched_job_cleanup(&rjob->base);
out_put_job:
	rocket_job_put(rjob);

	return ret;
}

This calls rocket_job_cleanup(), which unconditionally passes job->domain to
rocket_iommu_domain_put():

drivers/accel/rocket/rocket_job.c:rocket_job_cleanup() {
	...
	rocket_iommu_domain_put(job->domain);
	...
}

But rocket_iommu_domain_put() does not check if domain is NULL before passi=
ng
it to kref_put():

drivers/accel/rocket/rocket_drv.c:rocket_iommu_domain_put() {
	kref_put(&domain->kref, rocket_iommu_domain_destroy);
}

Since job->domain is assigned after rocket_copy_tasks() succeeds, could this
dereference a NULL pointer if an early failure occurs?


[Severity: Medium]
This is a pre-existing issue, but does this code silently ignore job
submission errors?

In rocket_ioctl_submit(), the loop calls rocket_ioctl_submit_job(), but the
return value is not captured or checked:

drivers/accel/rocket/rocket_job.c:rocket_ioctl_submit() {
	...
	for (i =3D 0; i < args->job_count; i++)
		rocket_ioctl_submit_job(dev, file, &jobs[i]);

exit:
	kvfree(jobs);

	return ret;
}

Since ret remains 0, the ioctl will return success to userspace even if
some or all jobs fail to submit. Will userspace assume the jobs were
successfully queued in this case?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-rocket-per=
-task-jobs-v1-0-e3319adf3c49@igalia.com?part=3D1
