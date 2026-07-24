Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2E4C531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D47D10F263;
	Fri, 24 Jul 2026 00:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z9RLo3fc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D06A010F263
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:09:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1FDA660A5A;
 Fri, 24 Jul 2026 00:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3071F000E9;
 Fri, 24 Jul 2026 00:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784851740;
 bh=RC1JbDWQawxyG8QpiMPT5usF/TTosPNJTkHElK8uwqo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z9RLo3fcRCg6dpzcoceJ3qp6qR9o5hMo+6EmqiLfkxokctvDJ+y8nptSdmWW8oONe
 ZRS+C0ZA9jXRsUgkToSpFgR/m4E2XYYq94X8HGC8ojIKT0deXVbOLiyu0qMTCVKbMS
 yBnH0428VONtM5HSKu6Y+p4pwMJSHwNgSAEi/T7fsvqOE9OEWGn3b77V2IE0N/OsZS
 ZEGaGc6hM6hSOsiB0TqMRqhNW+bzeASln4n1hAEu8yJAhPpDdHuic3L8lcKT/cjtE2
 icd3P3mYAt6517vXy+9UGUwNOXMUYmaLWPntkttc6HQ6fam4jVHkpSUE7E/TBwo1W8
 u8QyEskGtQ0qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/13] drm/panfrost: Rewire reset sequence to avoid
 concurrent attempts
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-claude-fixes-v3-8-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
 <20260724-claude-fixes-v3-8-542af61abd0f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 00:09:00 +0000
Message-Id: <20260724000900.AD3071F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Workqueue deadlock in `panfrost_job_timedout()` due to waiting on =
an ordered workqueue from a task executing on the same workqueue.
- [High] The timed-out job is permanently leaked and bypasses karma account=
ing because the asynchronous reset work executes with a NULL 'bad' job refe=
rence.
- [Medium] Unrealistically short wait timeout (60 milliseconds) for the GPU=
 reset sequence.
- [Medium] Premature clearing of the `reset.pending` flag creates a data ra=
ce with the TDR worker.
--

--- Patch [8]: [PATCH v3 08/13] drm/panfrost: Rewire reset sequence to avoi=
d concurrent attempts ---
commit 2c4929474201c3a58918917376876f5a96009f31
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
Subject: drm/panfrost: Rewire reset sequence to avoid concurrent attempts

This commit introduces a dedicated reset worker to serialize GPU resets.
It uses an ordered workqueue and wait_event_timeout to block concurrent
reset attempts while the ongoing reset thread completes.

Link: None provided

> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -797,10 +798,12 @@ static enum drm_gpu_sched_stat panfrost_job_timedou=
t(struct drm_sched_job
> =20
>  	panfrost_core_dump(job);
> =20
> -	atomic_set(&pfdev->reset.pending, 1);
> -	panfrost_reset(pfdev, sched_job);
> +	panfrost_device_schedule_reset(pfdev);

[Severity: High]
By removing the synchronous panfrost_reset() call and relying on
panfrost_reset_work(), we seem to lose the reference to the timed-out job.

Looking at the new worker function:

static void panfrost_reset_work(struct work_struct *work)
{
	struct panfrost_device *pfdev;

	pfdev =3D container_of(work, struct panfrost_device, reset.work);
	panfrost_reset(pfdev, NULL);
}

Since the guilty job is passed as NULL, it bypasses karma accounting and
drm_sched_stop() will fail to reinsert it into the pending list. Will this
cause the bad job to permanently leak and hang userspace?

> +	ret =3D wait_event_timeout(pfdev->reset.wait,
> +				 !atomic_read(&pfdev->reset.pending),
> +				 msecs_to_jiffies(60));

[Severity: High]
Could this wait trigger a workqueue deadlock?

In panfrost_jm_init(), args.timeout_wq is assigned to pfdev->reset.wq.
This means the timeout handler runs on the ordered reset workqueue.

By queuing pfdev->reset.work onto this exact same workqueue and synchronous=
ly
waiting for it to complete here, it seems the reset work can never execute
because the single-threaded queue is blocked waiting for it.

[Severity: Medium]
Is this timeout duration sufficient?

A 60 millisecond wait seems extremely short for a full GPU reset, which
involves soft-stopping jobs and polling the hardware. If it expires
prematurely, it will return ENODEV and abandon recovery. Could this have
been intended to be 60 seconds (60000 msecs)?

[Severity: Medium]
Is it safe to rely on the pending flag to synchronize scheduler restart?

In panfrost_reset(), atomic_set(&pfdev->reset.pending, 0) is called
immediately after the hardware reset, but before drm_sched_resubmit_jobs()
and drm_sched_start() have finished.

If this wait_event_timeout() wakes up early or spuriously, it will unblock
the DRM scheduler while the reset worker is still actively modifying
scheduler lists. Should the flag be cleared only after the full reset
sequence completes?

> -	return DRM_GPU_SCHED_STAT_RESET;
> +	return (ret) ? DRM_GPU_SCHED_STAT_RESET : DRM_GPU_SCHED_STAT_ENODEV;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-claude-fix=
es-v3-0-542af61abd0f@collabora.com?part=3D8
