Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584D2C54F52
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FA7E10E618;
	Wed, 29 Jul 2026 02:25:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IDs9rHcX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB5E010E618
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:25:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A1BB60A5E;
 Wed, 29 Jul 2026 02:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952BF1F000E9;
 Wed, 29 Jul 2026 02:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785291931;
 bh=5Rrfz3SGLL7zST/1WMuap9Ub/7b6BU0FiCspDMMNIdI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IDs9rHcXTm8r2XSnDRLqY3GA1mM5SkCVGrOj0eLwdq1JsoHqKu3Ih64qjYkU328q0
 HimFxVieztItQXwGMyH2Q5juCaWJkbijHx82IV8DCU+CvoPL85nS0+cb2OS41Tk+q4
 3tlO8vlP5+xOpeIkewxfb6xIUBxg0+56CHmrPBs3QntiaU0h+0cUqjW5mwKt/JMOYV
 38zmAHxZfz2c7aRB2OW7rs58ZdGzbkhbjLcXlpW+/xZBY1GDRVBXfspU1TZjT4VE9s
 9d/keXSYbT9b09EZJK5XZeIKypRHWQRzT/kFwxVyTGRsa7qgxgyyQyQrKBZklkAB0P
 0IZqXEx7SXk0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/v3d: Serialize the scheduler timeout handlers
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-v3d-order-global-reset-v1-1-e47be838158d@igalia.com>
References: <20260728-v3d-order-global-reset-v1-0-e47be838158d@igalia.com>
 <20260728-v3d-order-global-reset-v1-1-e47be838158d@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 02:25:30 +0000
Message-Id: <20260729022531.952BF1F000E9@smtp.kernel.org>
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
- [Critical] Schedulers for V3D_CACHE_CLEAN and V3D_CPU are configured with=
 a 500ms timeout but do not provide a `.timedout_job` callback, leading to =
a NULL pointer dereference crash if a job times out.
- [High] GPU reset upon timeout causes a NULL pointer dereference on device=
s without CSD support (e.g., V3D 3.x), due to accessing uninitialized DRM s=
chedulers.
--

--- Patch [1]: [PATCH 1/2] drm/v3d: Serialize the scheduler timeout handler=
s ---
commit 4242eaaa6f3d95b4fe7ea352d6d1d5bebceb401d
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Serialize the scheduler timeout handlers

This patch introduces an ordered workqueue to serialize the scheduler timeo=
ut
handlers for all V3D hardware queues. By sharing a single workqueue, it
prevents concurrent execution of timeout handlers and avoids a race conditi=
on
that corrupts scheduler credits during a global GPU reset.

Cc: stable@vger.kernel.org # 6.15

> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index 423bcfe331a01..8779a42c65081 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h

[ ... ]

> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sc=
hed.c
> index c35f9f70cf8d6..63dd95b828c85 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -837,6 +837,7 @@ v3d_queue_sched_init(struct v3d_dev *v3d, const struc=
t drm_sched_backend_ops *op
>  	struct drm_sched_init_args args =3D {
>  		.credit_limit =3D 1,
>  		.timeout =3D msecs_to_jiffies(500),
> +		.timeout_wq =3D v3d->reset_wq,
>  		.dev =3D v3d->drm.dev,
>  	};

[Severity: Critical]
This is a pre-existing issue, but since we are modifying the timeout=20
configuration for all queues, what happens if a V3D_CPU or V3D_CACHE_CLEAN
job times out?

Both of these queues are configured with a 500ms timeout by the arguments
above, but their backend operations lack a .timedout_job callback:

static const struct drm_sched_backend_ops v3d_cpu_sched_ops =3D {
	.run_job =3D v3d_cpu_job_run,
	.free_job =3D v3d_sched_job_free
};

If a user-space program submits a CPU job (e.g.=20
V3D_CPU_JOB_TYPE_COPY_TIMESTAMP_QUERY) with a very large count parameter=20
that takes longer than 500ms, or if the OS preempts the thread under heavy
load, drm_sched_job_timedout() will execute.

Since job->sched->ops->timedout_job is NULL for these schedulers, won't thi=
s=20
result in a NULL pointer dereference?

[ ... ]

> @@ -896,4 +901,6 @@ v3d_sched_fini(struct v3d_dev *v3d)
>  		if (v3d->queue[q].sched.ready)
>  			drm_sched_fini(&v3d->queue[q].sched);
>  	}
> +
> +	destroy_workqueue(v3d->reset_wq);
>  }

[Severity: High]
This is a pre-existing issue, but noticing the queue iteration here in=20
v3d_sched_fini() where we safely check v3d->queue[q].sched.ready, does=20
v3d_gpu_reset_for_timeout() have a similar safeguard?

Looking at v3d_gpu_reset_for_timeout(), it iterates over all queues=20
indiscriminately:

	for (i =3D 0; i < V3D_MAX_QUEUES; i++)
		drm_sched_stop(&v3d->queue[i].sched, sched_job);

On devices without CSD support (like V3D 3.x), v3d_has_csd() returns false,
meaning the schedulers for V3D_CSD and V3D_CACHE_CLEAN are skipped during
initialization and remain zero-initialized.

When a timeout occurs on these older variants and v3d_gpu_reset_for_timeout=
()
is triggered, wouldn't calling drm_sched_stop() on these zero-initialized
schedulers cause a NULL pointer dereference when it attempts to iterate ove=
r=20
sched->pending_list?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-v3d-order-=
global-reset-v1-0-e47be838158d@igalia.com?part=3D1
