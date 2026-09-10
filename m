Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FDAC79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 12:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A6710E5E7;
	Thu, 10 Sep 2026 12:37:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WvINKHtD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BC610E5E7
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 12:37:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B5230407F6;
 Thu, 10 Sep 2026 12:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB8D1F000FF;
 Thu, 10 Sep 2026 12:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789043856;
 bh=pC8IF9aABK0otWx63uNuwLpCR7coyyuXrPlm/q156vo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WvINKHtDu8xtAbxK9AB6PB9IhAPE1vmmQ9xUFlNpRB7Exfcxex3yFEIU1Hxow467j
 PumslZWUzfGJ5IrYxvQDx27WkdIEpqub0GuRT0PeUpT0HYclwOeStNQF+Ip/SLvEn3
 QikGCirI3YAgbgLiNKWc/mYIuEeuRlT8FpniRdF99rQUnFUfgXF/t7/xkMdWVoF+UW
 8fhcRBrUQPgKAXBUyYBx+vl3XyCyoFpWKvZzN/ndYKqXPJmr/5wSLYRZm3hZv5bxF4
 R6dGHqpWBTOTcEzZvbssxNR/GTm+GRixoZbIqPFGekKteEuAH+3DLS5yFH3LzGyjpK
 TzFcDunbOBygQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sched: Free the run queues at the end of
 drm_sched_fini()
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910121601.805032-1-donggeunyoo.kernel@gmail.com>
References: <20260910121601.805032-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 12:37:35 +0000
Message-Id: <20260910123736.6EB8D1F000FF@smtp.kernel.org>
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
- [Critical] Potential Use-After-Free of `sched` and `sched->sched_rq` if `=
drm_sched_fini()` is called with pending jobs and `own_submit_wq` is false.
--

commit f30738456b70961d8d90c374f4f4803079a2fecd
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

drm/sched: Free the run queues at the end of drm_sched_fini()

This commit moves the freeing of the scheduler run queues from the top of
drm_sched_fini() to the bottom. This prevents a use-after-free where the
timeout handler might still be walking the run queues before
cancel_delayed_work_sync() completes.

Link: https://lore.kernel.org/dri-devel/20260910054605.634135-1-donggeunyoo=
.kernel@gmail.com/

> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 6cb6f95464938..fec04c944c5e7 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
[ ... ]
> @@ -1226,6 +1223,9 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
>  	if (sched->own_submit_wq)
>  		destroy_workqueue(sched->submit_wq);

[Severity: Critical]
This is a pre-existing issue, but does skipping the workqueue drain when
own_submit_wq is false leave us exposed to a use-after-free here?

If a job timeout occurs concurrently with context teardown, drm_sched_fini()
calls cancel_delayed_work_sync(&sched->work_tdr), which waits for the timeo=
ut
handler to complete.

Drivers like Panthor and PVR implement the timeout handler by resetting the
hardware and calling drm_sched_start(), which calls drm_sched_wqueue_start(=
).
This unconditionally queues the work item back onto the shared workqueue:

drivers/gpu/drm/scheduler/sched_main.c:drm_sched_wqueue_start() {
    ...
    queue_work(sched->submit_wq, &sched->work_run_job);
    ...
}

After the timeout handler returns, cancel_delayed_work_sync() finishes.
Because these drivers use a shared workqueue, own_submit_wq is false, so
the workqueue is neither drained nor destroyed.

When drm_sched_fini() then frees sched->sched_rq and returns, the driver can
subsequently free the memory containing the scheduler. Can the shared
submit_wq then execute the re-queued work_run_job, accessing the freed
sched and sched->sched_rq?

>  	sched->ready =3D false;
> +
> +	for (i =3D DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++)
> +		kfree(sched->sched_rq[i]);
>  	kfree(sched->sched_rq);
>  	sched->sched_rq =3D NULL;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910121601.8050=
32-1-donggeunyoo.kernel@gmail.com?part=3D1
