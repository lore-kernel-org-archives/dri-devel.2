Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99577606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 02:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aa+58N5w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054F710E072;
	Thu, 19 Nov 2026 02:48:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB7C10E072
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 02:48:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A8D9647C2;
 Thu, 19 Nov 2026 02:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA021F000C7;
 Thu, 19 Nov 2026 02:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795056520;
 bh=lKMGEsxy0Yqj5gmqYGufSdowtCLZLx/KLE+vZiArdIU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Aa+58N5wItSPghD0qm1bUC8dSU0v0K4GI0E5f/UpjO7O1PFtzMHZQeP/C1NxpCpy0
 a1V5ReuPQLXgmYLc3XiNG7Y5ORE20OlPAO+f+M2U16yoq27BQTK2lmU2UIxKM/hGZ6
 klpFS7DEP+vghRLN2gidReDK7seLNo3lK+Iq/DY3dSCb0OS4acDJHgCYkIucE7W+md
 gNLI7gRHED0h+KSLwgXWqQsxFJzVHN+QDMLHFjbhXYfrb81utUQNpZ5wM7bssnSwzp
 VG9JG1Bw7lA4gzcwYbcqY92QaTgfL6ci0k/UlzucexVxmZelRHFX7amtlS1Nb4SjaG
 Aqw5kR5j7FEuw==
Message-ID: <sashiko-outbox-222346@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] drm/exynos: queue the IPP cleanup work before
 waking the caller
To: "Yaohan Li" <shunsheng1218@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119023550.1495565-1-shunsheng1218@gmail.com>
References: <20261119023550.1495565-1-shunsheng1218@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 02:48:40 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/exynos: early DONE flag in exynos_drm_ipp_task_done() races
  with waiter
- [Low] drm/exynos: inaccurate comment and changelog in
  exynos_drm_ipp_task_done()
- [Low] drm/exynos: missing Fixes trailer for exynos_drm_ipp_task_done()
  UAF fix
--

commit 358647e37f3b75ba1e0c967389989dcad2ba8a0e
Author: Yaohan Li <shunsheng1218@gmail.com>

> drm/exynos: queue the IPP cleanup work before waking the caller
>
> exynos_drm_ipp_task_done() marks the task done, wakes the waiters and only
> then decides whether the task has to be released by the cleanup work.  A
> commit ioctl that waits for the task is woken by that wake_up() and frees
> the task itself as soon as it sees the DONE flag, so the task->flags read
> that follows touches memory that may already be gone.
>
> Read the flag while the task is still guaranteed to be alive, together
> with the other task state under ipp->lock, and queue the cleanup work
> before the wakeup.  A task that is handed to the work is then always
> queued while it still exists.
>
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

[Severity: Low]
Should this bug fix include a Fixes tag?

  Fixes: 9913f74fe157 ("drm/exynos: ipp: Add IPP v2 framework")

> diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_ipp.c
> index 43bc4f63bb845..49ae8ce9b95a6 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
> @@ -764,6 +764,7 @@ void exynos_drm_ipp_task_done(struct exynos_drm_ipp_t=
ask *task, int ret)
>  {
>  	struct exynos_drm_ipp *ipp =3D task->ipp;
>  	unsigned long flags;
> +	bool async;
> =20
>  	DRM_DEV_DEBUG_DRIVER(task->dev, "ipp: %d, task %p done: %d\n",
>  			     ipp->id, task, ret);
> @@ -773,15 +774,22 @@ void exynos_drm_ipp_task_done(struct exynos_drm_ipp=
_task *task, int ret)
>  		ipp->task =3D NULL;
>  	task->flags |=3D DRM_EXYNOS_IPP_TASK_DONE;
>  	task->ret =3D ret;
> +	async =3D task->flags & DRM_EXYNOS_IPP_TASK_ASYNC;
>  	spin_unlock_irqrestore(&ipp->lock, flags);

[Severity: High]
Can a synchronous waiter in exynos_drm_ipp_commit_ioctl() observe
DRM_EXYNOS_IPP_TASK_DONE and free task before exynos_drm_ipp_task_done()
finishes writing task->ret and reading DRM_EXYNOS_IPP_TASK_ASYNC?

Neither wait_event_interruptible() nor exynos_drm_ipp_task_cleanup() takes
ipp->lock:

drivers/gpu/drm/exynos/exynos_drm_ipp.c:exynos_drm_ipp_commit_ioctl() {
    ...
		exynos_drm_ipp_schedule_task(ipp, task);
		ret =3D wait_event_interruptible(ipp->done_wq,
					task->flags & DRM_EXYNOS_IPP_TASK_DONE);
		if (ret)
			exynos_drm_ipp_task_abort(ipp, task);
		else
			ret =3D exynos_drm_ipp_task_cleanup(task);
    ...
}

Because wait_event_interruptible() checks task->flags locklessly before
sleeping (or when woken by an earlier task on the shared ipp->done_wq),
setting DRM_EXYNOS_IPP_TASK_DONE first allows the waiter to run
exynos_drm_ipp_task_cleanup() concurrently:

CPU0                              CPU1
exynos_drm_ipp_task_done()        exynos_drm_ipp_commit_ioctl()
  spin_lock_irqsave(&ipp->lock)
  task->flags |=3D ..._TASK_DONE;
                                    wait_event_interruptible()
                                      sees DRM_EXYNOS_IPP_TASK_DONE
                                    exynos_drm_ipp_task_cleanup(task)
                                      ret =3D task->ret;  <-- stale 0
                                      exynos_drm_ipp_task_free()
                                        kfree(task)
  task->ret =3D ret;
  async =3D task->flags & ...;  <-- use-after-free

Writing task->ret and reading DRM_EXYNOS_IPP_TASK_ASYNC before setting
DRM_EXYNOS_IPP_TASK_DONE (with release/acquire ordering or under
ipp->lock on the reader side) would avoid this race.

>  	exynos_drm_ipp_next_task(ipp);
> -	wake_up(&ipp->done_wq);
> =20
> -	if (task->flags & DRM_EXYNOS_IPP_TASK_ASYNC) {
> +	/*
> +	 * Hand the task over to the cleanup work before a synchronous caller
> +	 * is woken up: once wake_up() returns, that caller may have released
> +	 * the task already.
> +	 */
> +	if (async) {
>  		INIT_WORK(&task->cleanup_work, exynos_drm_ipp_cleanup_work);
>  		schedule_work(&task->cleanup_work);
>  	}
> +
> +	wake_up(&ipp->done_wq);
>  }

[Severity: Low]
Is this comment (and the corresponding explanation in the commit message)
accurate about why async is checked before wake_up()?

DRM_EXYNOS_IPP_TASK_ASYNC is only set for non-blocking commits (which do
not wait on ipp->done_wq) or in exynos_drm_ipp_task_abort() after
wait_event_interruptible() was already interrupted by a signal and handed
ownership of the running task to cleanup_work.  When async is true, no
synchronous caller will free the task upon wake_up(); when a synchronous
caller is waiting to free the task, async is false.  What prevents the
use-after-free is reading DRM_EXYNOS_IPP_TASK_ASYNC before the waiter can
observe task completion, rather than queuing cleanup_work before
wake_up().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119023550.1495=
565-1-shunsheng1218@gmail.com?part=3D1
