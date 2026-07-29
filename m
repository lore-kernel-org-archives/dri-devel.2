Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E83BC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 03:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87FF10EA70;
	Wed, 29 Jul 2026 03:19:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nAtSgd34";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2368010EA70
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 03:19:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C82660A5E;
 Wed, 29 Jul 2026 03:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7361F000E9;
 Wed, 29 Jul 2026 03:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785295174;
 bh=WDuZJjLtNuD6YkeFzdMj0HSPepAuGs49QJJeMKOvke0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nAtSgd3410PdalHh+/O1q0LF3hKhW28+LrgFPawV2S0Q2ZwABLHqkIlDqUlN7h0Y1
 ueWQIdwQw0hzYp+F2MYPptaXmKTdROTDRZr5v3DfzmpcNCYev/eoU8NH7bZa70QsqB
 vSU8m4dCY0lBXWVMtyGqNmsJFns2UAe0PEtfUz0qTzJQ632oxqg9tPUoHMuZkNMwsS
 Bl4QTjUbCBta18te0NwtqrfoLOz3eU96a/gd8qo7doSTt5haeAwxr8tVOY4UWGduph
 gzhYaHIjpesYYSA2iqly9vDqLoWSmXDBVE1zDBBGq07gh55z5tsKtjEaEpWbziXht+
 i2NDD3E1NW4bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/13] drm/panfrost: Rewire reset sequence to avoid
 concurrent attempts
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729-claude-fixes-v4-8-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-8-01968f2ec77a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 03:19:33 +0000
Message-Id: <20260729031933.CD7361F000E9@smtp.kernel.org>
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
- [High] Removing the synchronous `atomic_set(&pfdev->reset.pending, 1)` fr=
om `panfrost_job_handle_err` opens a vulnerable window where new jobs are e=
rroneously submitted to faulted hardware.
- [Medium] The introduced `pfdev->reset.wait` wait queue is never waited on=
, rendering it dead code and breaking the intended synchronization.
--

--- Patch [8]: [PATCH v4 08/13] drm/panfrost: Rewire reset sequence to avoi=
d concurrent attempts ---
commit c66abdaa510df5e2a3ec11be0069267b5ffde774
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Rewire reset sequence to avoid concurrent attempts

This rewires the reset sequence to use a single reset thread and a wait que=
ue
for other threads wanting to trigger a reset.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm=
/panfrost/panfrost_device.h
> index eeca57efcbec0..f0acfc634cd47 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
[ ... ]
> @@ -341,8 +342,8 @@ bool panfrost_exception_needs_reset(const struct panf=
rost_device *pfdev,
>  static inline void
>  panfrost_device_schedule_reset(struct panfrost_device *pfdev)
>  {
> -	atomic_set(&pfdev->reset.pending, 1);
> -	queue_work(pfdev->reset.wq, &pfdev->reset.work);
> +	if (!atomic_cmpxchg(&pfdev->reset.pending, 0, 1))
> +		queue_work(pfdev->reset.wq, &pfdev->reset.work);
>  }

[Severity: Medium]
The commit message states that other threads will wait on the ongoing reset
to finish, and a wait queue is added and woken up in panfrost_reset().
However, there do not appear to be any wait_event() calls added for
pfdev->reset.wait in the codebase.

When the atomic_cmpxchg() fails here, the caller returns immediately instead
of blocking on the ongoing reset. Are we missing the wait logic for
concurrent reset requests?

> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index bda1494eb430c..ed8a1fabd47b4 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
[ ... ]
> @@ -499,10 +499,8 @@ static void panfrost_job_handle_err(struct panfrost_=
device *pfdev,
> =20
>  	pm_runtime_put_autosuspend(pfdev->base.dev);
> =20
> -	if (panfrost_exception_needs_reset(pfdev, js_status)) {
> -		atomic_set(&pfdev->reset.pending, 1);
> +	if (panfrost_exception_needs_reset(pfdev, js_status))
>  		drm_sched_fault(&pfdev->js->queue[js].sched);
> -	}
>  }

[Severity: High]
Does removing the synchronous atomic_set() here create a vulnerability wind=
ow?

By delegating this to the async timeout worker via drm_sched_fault(),
reset.pending remains 0 when panfrost_job_handle_err() returns.

If reset.pending is still 0, will panfrost_jm_handle_irq() incorrectly
requeue jobs onto the faulted hardware?

panfrost_jm_handle_irq() {
    ...
    } else if (!atomic_read(&pfdev->reset.pending)) {
        /* Requeue the job we removed if no reset is pending */
        job_write(pfdev, JS_COMMAND_NEXT(j), JS_COMMAND_START);
    }
}

Similarly, concurrent job submissions from the scheduler in
panfrost_job_hw_submit() might also incorrectly proceed because they check
if (!atomic_read(&pfdev->reset.pending)).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-claude-fix=
es-v4-0-01968f2ec77a@collabora.com?part=3D8
