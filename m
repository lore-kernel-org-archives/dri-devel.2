Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F7C606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SoOt4w46
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA6310E4A9;
	Sun,  8 Nov 2026 07:26:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF2510E4A9
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 07:26:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9BE7E437A3;
 Sun,  8 Nov 2026 07:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A0A1F0089F;
 Sun,  8 Nov 2026 07:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794122789;
 bh=q+FhEVnh9nJXmILawYsoL2w3vAYxzbDAZ6wcjLb1LnY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SoOt4w46EAMG8pI4YsJTHwfWO6Ky0uVhJ03dcmwikOOaZEfpR+c/p1GKnLWHsd0Gj
 W5vUiJMhdhl63jYqamh3+nZUjxWC33P38VkQQ1ST6Rar2JCpQbNQczqCraMCHPmen5
 APext606goGdHuWFF1rqMQQ0q+AJfpA2lVAyVSouQhdKpLtQx9VGoBaqzbHkvoK2d1
 vRDkT2iI4rllnf98pOoOiArQE56uY+f+WL5IAhDkR5UgM4XpKR/Gh37iuhlAkmgp0E
 WQcw6uYmkud7vTq8oBpyCG92EFmO0WOtn6Flo7aZLZ0bBYUYWkm9qrIYJ1Yhd3Wi53
 Cefnkck1IPvsw==
Message-ID: <sashiko-outbox-203619@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 04/16] accel/rocket: let the core suspend after a reset
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261108065917.135194-5-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
 <20261108065917.135194-5-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 07:26:28 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] accel/rocket: asynchronous autosuspend in rocket_reset() skips
  domain reset
- [Medium] accel/rocket: rocket_core_reset() runs without PM ref if job
  IRQ races
--

commit aed4735942793150a3547c69cb7317b3ba01d633
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: let the core suspend after a reset

This commit replaces pm_runtime_put_noidle() with
pm_runtime_put_autosuspend() in rocket_reset() and moves the release after
rocket_core_reset() so the NPU stays powered during reset and can suspend
afterward.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.c=
om/

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index abef12b86d481..4a577b642849d 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -395,6 +395,8 @@ static void rocket_job_handle_irq(struct rocket_core =
*core)
>  static void
>  rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
>  {
> +	bool put_job_ref;
> +
>  	if (!atomic_read(&core->reset.pending))
>  		return;
> =20
> @@ -413,11 +415,10 @@ rocket_reset(struct rocket_core *core, struct drm_s=
ched_job *bad)
>  	/*
>  	 * Remaining interrupts have been handled, but we might still have
>  	 * stuck jobs. Let's make sure the PM counters stay balanced by
> -	 * manually calling pm_runtime_put_noidle().
> +	 * dropping the job's reference once the core has been reset.
>  	 */
>  	scoped_guard(mutex, &core->job_lock) {
> -		if (core->in_flight_job)
> -			pm_runtime_put_noidle(core->dev);
> +		put_job_ref =3D core->in_flight_job;
> =20
>  		iommu_detach_group(NULL, core->iommu_group);
> =20
> @@ -427,6 +428,9 @@ rocket_reset(struct rocket_core *core, struct drm_sch=
ed_job *bad)
>  	/* Proceed with reset now. */
>  	rocket_core_reset(core);

[Severity: Medium]
As reported by Igor Paunovic on v8 [1], can rocket_core_reset() still run
without a runtime PM reference if the in-flight job completes concurrently
with the timeout?

kworker                           <irq/thread>
rocket_reset()
  drm_sched_stop()
  lock(&core->job_lock)
  pm_runtime_get_if_active()
  ...
  pm_runtime_put_autosuspend()
  unlock(&core->job_lock)
  synchronize_irq(core->irq)
                                  rocket_job_handle_irq()
                                    lock(&core->job_lock)
                                    pm_runtime_put_autosuspend(core->dev)
                                    core->in_flight_job =3D NULL
                                    unlock(&core->job_lock)
  lock(&core->job_lock)
  put_job_ref =3D core->in_flight_job (NULL)
  unlock(&core->job_lock)
  rocket_core_reset(core)  <-- no runtime PM reference held

Because rocket_job_handle_irq() already dropped the job's runtime PM
reference and rocket_reset() dropped its temporary reference before
synchronize_irq(), core->dev has usage_count =3D=3D 0 during
rocket_core_reset().  If the autosuspend timer expires before
rocket_core_reset() finishes, the NPU core is reset while unpowered, which
hangs the board.

> =20
> +	if (put_job_ref)
> +		pm_runtime_put_autosuspend(core->dev);
> +
>  	/* NPU has been reset, we can clear the reset pending bit. */
>  	atomic_set(&core->reset.pending, 0);

[Severity: High]
Does pm_runtime_put_autosuspend() actually power-cycle the domain when
another job is already queued or submitted right after the reset?

rocket_core_init() enables autosuspend with a 50 ms delay:

drivers/accel/rocket/rocket_core.c:rocket_core_init() {
	...
	pm_runtime_use_autosuspend(dev);
	...
	pm_runtime_set_autosuspend_delay(dev, 50);
}

pm_runtime_put_autosuspend() only arms the 50 ms timer and leaves
core->dev in RPM_ACTIVE, after which rocket_reset() immediately calls
drm_sched_start(&core->sched, 0).  Any job already queued in the scheduler
or submitted within the next 50 ms calls pm_runtime_resume_and_get() in
rocket_job_run(), sees the device still active, and cancels the timer
without ever calling rocket_device_runtime_suspend().  On RK3576, the
power domain is never switched off and back on, leaving the NPU bus
interface and IOMMU wedged for subsequent jobs.

[1] https://lore.kernel.org/r/CAEWPSH7tM9WQUJ0H13ghkiHGzDcdycC1syTuO5B8DpC6=
cUSnfg@mail.gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108065917.1351=
94-1-gahing@gahingwoo.com?part=3D4
