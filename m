Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DD1CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 02:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73771125B6;
	Thu,  4 Jun 2026 02:51:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CwiIWlHI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EB3A1125B6
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 02:51:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EAEEB43E98;
 Thu,  4 Jun 2026 02:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39121F00893;
 Thu,  4 Jun 2026 02:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780541517;
 bh=lDxQ2gq6QXDm1uuquuW/cIhYl2oJskECu8moUdzCF8M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CwiIWlHIdwYey4JyTzg3Cbxmzo77ysITe/B1oud70FgkyCTeAkJENBH9x6ZgJ5wKI
 dNaNXos97xwmXnm82o8zOdllp0d65EGCpPKqJx6U7OwK17z+IblnpI6/+E0T1mWwVr
 MejzZJicvLteIB+WvJhnm503qgneyCqOu96VBZt6xRi4Fofmb82LLYhvcdWPVme/00
 RFJ6OCzcWivc1CnJ2jasG/0s0rr4zrJMaowvJguBYLgXSDxJ8cumXlZ6cXsDofoP4U
 h2t8737VIgQ/hLpb3XGa9KV0qnNXjEpbceSnBlkd036I4OhXdvkE/sYFmss21MCkli
 fzE2jHgWuLAww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/14] drm/v3d: Replace spin_lock_irqsave() with
 spin_lock()
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-4-d7114bba55a0@igalia.com>
References: <20260603-v3d-sched-misc-fixes-v3-4-d7114bba55a0@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:51:57 +0000
Message-Id: <20260604025157.B39121F00893@smtp.kernel.org>
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
- [High] Removing `spin_lock_irqsave` exposes a uniprocessor race and obstr=
ucts the correct fix for an existing SMP use-after-free race.
- [Low] Mixing goto-based error handling and scope-based cleanup helpers (`=
scoped_guard()`) in the same function violates subsystem guidelines.
--

commit 7d41ab716d6dcf438f92d8905f5e28343e3ab169
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Replace spin_lock_irqsave() with spin_lock()

This commit replaces spin_lock_irqsave() and spin_unlock_irqrestore() with
the scoped_guard() macro using plain spinlocks in v3d_overflow_mem_work()
and v3d_bin_job_run().

> diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
> index 86efaef2722c3..754a969b862b6 100644
> --- a/drivers/gpu/drm/v3d/v3d_irq.c
> +++ b/drivers/gpu/drm/v3d/v3d_irq.c
[ ... ]
> @@ -64,17 +63,15 @@ v3d_overflow_mem_work(struct work_struct *work)
>  	 * bin job got scheduled, that's fine.  We'll just give them
>  	 * some binner pool anyway.
>  	 */
> -	spin_lock_irqsave(&queue->queue_lock, irqflags);
> -	bin_job =3D (struct v3d_bin_job *)queue->active_job;
> +	scoped_guard(spinlock, &queue->queue_lock) {

[Severity: High]
Does removing the IRQ-disabling protection here cement a broken locking des=
ign?

The commit message notes the hard IRQ handler doesn't take this lock, but
v3d_irq_signal_fence() modifies queue->active_job locklessly. Because of th=
is
missing lock, an SMP use-after-free race already exists where the DRM
scheduler can free the job while v3d_overflow_mem_work() is dereferencing
bin_job->render.

By switching from spin_lock_irqsave() to spin_lock(), this exposes a
uniprocessor race where the IRQ can preempt the workqueue's critical sectio=
n.
Furthermore, if someone fixes the SMP race by adding
spin_lock(&queue->queue_lock) to the IRQ handler, won't the system deadlock
when the IRQ interrupts this workqueue?

> +		bin_job =3D (struct v3d_bin_job *)queue->active_job;
> =20
> -	if (!bin_job) {
> -		spin_unlock_irqrestore(&queue->queue_lock, irqflags);
> -		goto out;
> -	}
> +		if (!bin_job)
> +			goto out;

[Severity: Low]
Is it ok to mix goto-based error handling with scope-based cleanup helpers?

The kernel cleanup guidelines explicitly forbid mixing goto and scope-based
cleanup helpers in the same function because it creates confusing ownership
semantics.

While scoped_guard() is introduced here for lock management, the function
retains explicit goto statements like this one to reach the out label for
drm_gem_object_put().

> =20
> -	drm_gem_object_get(obj);
> -	list_add_tail(&bo->unref_head, &bin_job->render->unref_list);
> -	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
> +		drm_gem_object_get(obj);
> +		list_add_tail(&bo->unref_head, &bin_job->render->unref_list);
> +	}
> =20
>  	v3d_mmu_flush_all(v3d);
> =20
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sc=
hed.c
> index 46f4fc09c59ec..04fd1a365576b 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
[ ... ]
> @@ -240,9 +239,9 @@ static struct dma_fence *v3d_bin_job_run(struct drm_s=
ched_job *sched_job)
>  	return fence;
> =20
>  out_clean_job:
> -	spin_lock_irqsave(&queue->queue_lock, irqflags);
> -	queue->active_job =3D NULL;
> -	spin_unlock_irqrestore(&queue->queue_lock, irqflags);
> +	scoped_guard(spinlock, &queue->queue_lock) {
> +		queue->active_job =3D NULL;
> +	}
>  	return NULL;
>  }

[Severity: Low]
Does this also violate the cleanup guidelines against mixing goto and
scope-based cleanup?

Similar to v3d_overflow_mem_work(), this function introduces scoped_guard()
while still retaining the out_clean_job label that is reached via goto
statements earlier in the function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-v3d-sched-=
misc-fixes-v3-0-d7114bba55a0@igalia.com?part=3D4
