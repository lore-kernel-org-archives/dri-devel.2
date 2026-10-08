Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A21CA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 11:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D43810E7EC;
	Thu,  8 Oct 2026 11:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="FlaYMhMs";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B38C310E7EC
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 11:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=SWa3YlZkDzYb1zZq6EwD/X7SF1I+Gt0BS0xUQawhlj4=; b=FlaYMhMsdCJwQwmDWzPLkqXb8K
 mhuSHkulG37nMsmJpYuNjF3Hubov78jwiO1JvkAgLYa0GDwk7ilMzeOPJq+RnWVxoJgxGfoizpV7b
 NvogCprVvqYK1v6bRHAuZuUcgOJFtkXCd0XXoHDkeBfUcJEr4L9tLV4Z5LazHmEGtx9oQd33zb6MZ
 t+pVjl5qHQhzbUIf6pSpfjqwwbGfsSr7syS0cqQ3KneAjNuRcb4Y8DZOWEwQOxFLQr7cimRkiAE+h
 RKLL7XgNnf8qtDkxrarTg78hKyIW2yKBQfEdOQe1DBNj9N4+O+uUiKDBvjFpK/OWRr15fX9Sp8k/S
 fK1rn5ZQ==;
Received: from [148.56.135.230] (helo=[192.168.0.17])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xEmiY-00ESGp-R5; Thu, 08 Oct 2026 13:55:22 +0200
Message-ID: <54fa8011835a2ca41da5e12c4bca6cd36d4aa28b.camel@igalia.com>
Subject: Re: [PATCH] drm/vc4: Fix binner slot allocation failing on an idle GPU
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Jose Maria Casanova
 Crespo <jmcasanova@igalia.com>, Maxime Ripard <mripard@kernel.org>, Dave
 Stevenson <dave.stevenson@raspberrypi.com>, Raspberry Pi Kernel Maintenance
 <kernel-list@raspberrypi.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Date: Thu, 08 Oct 2026 13:55:12 +0200
In-Reply-To: <20260930182204.1877361-1-mcanal@igalia.com>
References: <20260930182204.1877361-1-mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Nice catch! I think this looks good:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El mi=C3=A9, 30-09-2026 a las 15:20 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> A job's binner slots are returned to bin_alloc_used by
> vc4_complete_exec(),
> which runs from the job_done workqueue, but the seqno
> vc4_v3d_get_bin_slot() waits on is incremented earlier, in the
> function
> vc4_irq_finish_render_job(). Therefore, a waiter can wake, retry, and
> still
> find the pool full because the worker has not run. By then, the job
> might
> have left the render_job_list, so no seqno remains to wait on and the
> allocation fails returning -ENOMEM.
>=20
> This scenario can be reproduced on a Raspberry Pi 3 by using a burst
> of
> small jobs (e.g. Piglit's `quick_gl` suite), with userspace seeing a
> rejected submit for a pool about to become free.
>=20
> Note that the slots are held from validation until the render
> completes,
> so the pool can also be exhausted by jobs still queued on
> bin_job_list,
> leaving render_job_list empty and nothing to wait on.
>=20
> Release the slots from the FRDONE handler and wait on the pool
> instead of
> on one job's seqno. This bounds the wait to the actual resource.
> Also, by
> claiming the slot inside the wait condition, another submit is unable
> to
> take the slot between the wakeup and the retry. vc4_complete_exec()
> keeps
> clearing the slots for jobs that never completed, and now wakes the
> waiters too.
>=20
> Note that the wait takes a deadline, since the two callers need
> different
> ones. The submit path is a user task and can be interrupted, so it
> waits
> without one. On the other hand, vc4_overflow_mem_work() runs on a
> worker
> and never sees a signal, so it needs a deadline. During a reset,
> vc4_irq_disable() masks V3D_DRIVER_IRQS before draining the worker,
> and
> with those masked nothing can release a slot. This deadlocks: the
> worker
> would wait for slots that only the reset can free, while the reset
> waits
> in cancel_work_sync() for the worker.
>=20
> Fixes: 553c942f8b2c ("drm/vc4: Allow using more than 256MB of CMA
> memory.")
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/gpu/drm/vc4/vc4_drv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 2 +-
> =C2=A0drivers/gpu/drm/vc4/vc4_gem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 8 +++++-
> =C2=A0drivers/gpu/drm/vc4/vc4_irq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 6 +++-
> =C2=A0drivers/gpu/drm/vc4/vc4_v3d.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 44 ++=
++++++++++++--------------
> --
> =C2=A0drivers/gpu/drm/vc4/vc4_validate.c |=C2=A0 2 +-
> =C2=A05 files changed, 34 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h
> b/drivers/gpu/drm/vc4/vc4_drv.h
> index 695bc6a29d30..09134809bf15 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -1053,7 +1053,7 @@ void vc4_plane_async_set_fb(struct drm_plane
> *plane,
> =C2=A0/* vc4_v3d.c */
> =C2=A0extern struct platform_driver vc4_v3d_driver;
> =C2=A0extern const struct of_device_id vc4_v3d_dt_match[];
> -int vc4_v3d_get_bin_slot(struct vc4_dev *vc4);
> +int vc4_v3d_get_bin_slot(struct vc4_dev *vc4, long timeout);
> =C2=A0int vc4_v3d_bin_bo_get(struct vc4_dev *vc4, bool *used);
> =C2=A0void vc4_v3d_bin_bo_put(struct vc4_dev *vc4);
> =C2=A0int vc4_v3d_pm_get(struct vc4_dev *vc4);
> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c
> b/drivers/gpu/drm/vc4/vc4_gem.c
> index 3212b9167620..356d7bb7f46a 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -889,11 +889,17 @@ vc4_complete_exec(struct drm_device *dev,
> struct vc4_exec_info *exec)
> =C2=A0		drm_gem_object_put(&bo->base.base);
> =C2=A0	}
> =C2=A0
> -	/* Free up the allocation of any bin slots we used. */
> +	/* Free up the allocation of any bin slots we used. Jobs
> that ran to
> +	 * completion had their slots released in
> vc4_irq_finish_render_job().
> +	 * Only jobs that never completed still have slots to be
> released here.
> +	 */
> =C2=A0	spin_lock_irqsave(&vc4->job_lock, irqflags);
> =C2=A0	vc4->bin_alloc_used &=3D ~exec->bin_slots;
> =C2=A0	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
> =C2=A0
> +	/* Let anyone waiting on the binner pool retry. */
> +	wake_up_all(&vc4->job_wait_queue);
> +
> =C2=A0	/* Release the reference on the binner BO if needed. */
> =C2=A0	if (exec->bin_bo_used)
> =C2=A0		vc4_v3d_bin_bo_put(vc4);
> diff --git a/drivers/gpu/drm/vc4/vc4_irq.c
> b/drivers/gpu/drm/vc4/vc4_irq.c
> index 3a3ea1e62dcb..e44ff996eaac 100644
> --- a/drivers/gpu/drm/vc4/vc4_irq.c
> +++ b/drivers/gpu/drm/vc4/vc4_irq.c
> @@ -74,7 +74,7 @@ vc4_overflow_mem_work(struct work_struct *work)
> =C2=A0
> =C2=A0	bo =3D vc4->bin_bo;
> =C2=A0
> -	bin_bo_slot =3D vc4_v3d_get_bin_slot(vc4);
> +	bin_bo_slot =3D vc4_v3d_get_bin_slot(vc4,
> msecs_to_jiffies(500));
> =C2=A0	if (bin_bo_slot < 0) {
> =C2=A0		drm_err(&vc4->base, "Couldn't allocate binner
> overflow mem\n");
> =C2=A0		goto complete;
> @@ -165,6 +165,10 @@ vc4_irq_finish_render_job(struct drm_device
> *dev)
> =C2=A0	trace_vc4_rcl_end_irq(dev, exec->seqno);
> =C2=A0
> =C2=A0	vc4->finished_seqno++;
> +
> +	vc4->bin_alloc_used &=3D ~exec->bin_slots;
> +	exec->bin_slots =3D 0;
> +
> =C2=A0	list_move_tail(&exec->head, &vc4->job_done_list);
> =C2=A0
> =C2=A0	nextbin =3D vc4_first_bin_job(vc4);
> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c
> b/drivers/gpu/drm/vc4/vc4_v3d.c
> index b40d98c9d1d2..3b0b01820c97 100644
> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
> @@ -152,46 +152,42 @@ void vc4_v3d_init_hw(struct drm_device *dev)
> =C2=A0	V3D_WRITE(V3D_VPMBASE, 0);
> =C2=A0}
> =C2=A0
> -int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
> +static int bin_slot_try_alloc(struct vc4_dev *vc4)
> =C2=A0{
> -	struct drm_device *dev =3D &vc4->base;
> -	unsigned long irqflags;
> =C2=A0	int slot;
> -	uint64_t seqno =3D 0;
> -	struct vc4_exec_info *exec;
> =C2=A0
> -	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
> -		return -ENODEV;
> +	guard(spinlock_irqsave)(&vc4->job_lock);
> =C2=A0
> -try_again:
> -	spin_lock_irqsave(&vc4->job_lock, irqflags);
> =C2=A0	slot =3D ffs(~vc4->bin_alloc_used);
> =C2=A0	if (slot !=3D 0) {
> =C2=A0		/* Switch from ffs() bit index to a 0-based index.
> */
> =C2=A0		slot--;
> =C2=A0		vc4->bin_alloc_used |=3D BIT(slot);
> -		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
> -		return slot;
> +	} else {
> +		slot =3D -ENOMEM;
> =C2=A0	}
> =C2=A0
> -	/* Couldn't find an open slot.=C2=A0 Wait for render to complete
> -	 * and try again.
> -	 */
> -	exec =3D vc4_last_render_job(vc4);
> -	if (exec)
> -		seqno =3D exec->seqno;
> -	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
> +	return slot;
> +}
> =C2=A0
> -	if (seqno) {
> -		int ret =3D vc4_wait_for_seqno(dev, seqno, ~0ull,
> true);
> +int vc4_v3d_get_bin_slot(struct vc4_dev *vc4, long timeout)
> +{
> +	int slot;
> +	long ret;
> =C2=A0
> -		if (ret =3D=3D 0)
> -			goto try_again;
> +	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
> +		return -ENODEV;
> =C2=A0
> +	/* If the pool is full, wait for a job to release its slots.
> */
> +	ret =3D wait_event_interruptible_timeout(vc4->job_wait_queue,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (slot =3D
> bin_slot_try_alloc(vc4)) >=3D 0,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timeout);
> +	if (ret < 0)
> =C2=A0		return ret;
> -	}
> +	if (ret =3D=3D 0)
> +		return -ENOMEM;
> =C2=A0
> -	return -ENOMEM;
> +	return slot;
> =C2=A0}
> =C2=A0
> =C2=A0/*
> diff --git a/drivers/gpu/drm/vc4/vc4_validate.c
> b/drivers/gpu/drm/vc4/vc4_validate.c
> index d2a65c968b1f..565227657b43 100644
> --- a/drivers/gpu/drm/vc4/vc4_validate.c
> +++ b/drivers/gpu/drm/vc4/vc4_validate.c
> @@ -402,7 +402,7 @@ validate_tile_binning_config(VALIDATE_ARGS)
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0
> -	bin_slot =3D vc4_v3d_get_bin_slot(vc4);
> +	bin_slot =3D vc4_v3d_get_bin_slot(vc4, MAX_SCHEDULE_TIMEOUT);
> =C2=A0	if (bin_slot < 0) {
> =C2=A0		if (bin_slot !=3D -EINTR && bin_slot !=3D -ERESTARTSYS)
> {
> =C2=A0			drm_err(dev, "Failed to allocate binner
> memory: %d\n",

