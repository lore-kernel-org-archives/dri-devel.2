Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D41606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7EulE3P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BC4E10EB52;
	Sat, 14 Nov 2026 03:24:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5EB110EB52
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:24:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69907414BA;
 Sat, 14 Nov 2026 03:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110D31F000C4;
 Sat, 14 Nov 2026 03:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794626668;
 bh=R4z16kEfzHpn60KauXW19XfpX7fZvymv1L1wPk/86Nk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h7EulE3PKk1HYiqpkEo/dZqM3ByBmmHh4i2URrrYwyR8j1awsELRlkZpupJfRKqp6
 WuaSEZhyPk3476BddgKtZRLrqOhD06h8vLjHsfEzmOqIvwPvaOSupkZei3MB6GTBqm
 VznUV7Met1IpFbwHsOJgGcIyV9tcAxHXy7j1vPJyzsD1zsjGL6H1EixrroXsHCQ8+A
 6SCxLTrXyhhHdB1CF1eXnFYdYzmGMuV/7HisLWKZtb+porS3S+L5Vmt4rI9itAA5cp
 ENe04krNoeO227L9UZybPW0aJs1AHfa3nfc/j/ysptQ2/LUxs46/KbBLcIXcU1x2G1
 Vqj7EubsVW3Kg==
Message-ID: <sashiko-outbox-214103@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 04/12] accel/rocket: let the core suspend after a reset
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <2afd051e37b8dd4f10e347a3537b0086973d554c.1794615323.git.gahing@gahingwoo.com>
References: <cover.1794615324.git.gahing@gahingwoo.com>
 <2afd051e37b8dd4f10e347a3537b0086973d554c.1794615323.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 03:24:27 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
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

commit 8873affc45494653d715f08563b9727e826503f5
Author: Jiaxing Hu <gahing@gahingwoo.com>

accel/rocket: let the core suspend after a reset

This commit replaces pm_runtime_put_noidle() with
pm_runtime_put_autosuspend() in rocket_reset() and moves the call after
rocket_core_reset() so the NPU core stays powered during the reset and can
suspend afterward.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.c=
om/

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 8b4ad028bc9b2..41c723238b2b7 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -397,6 +397,8 @@ static void rocket_job_handle_irq(struct rocket_core =
*core)
>  static void
>  rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
>  {
> +	bool put_job_ref;
> +
>  	if (!atomic_read(&core->reset.pending))
>  		return;
> =20
> @@ -415,11 +417,10 @@ rocket_reset(struct rocket_core *core, struct drm_s=
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
> @@ -429,6 +430,9 @@ rocket_reset(struct rocket_core *core, struct drm_sch=
ed_job *bad)
>  	/* Proceed with reset now. */
>  	rocket_core_reset(core);

[Severity: Medium]
As reported by Igor Paunovic on v8 [1], can rocket_core_reset() still run
without holding a runtime PM reference if the in-flight job completes
concurrently with the timeout?

CPU0 (reset work)                 CPU1 (threaded IRQ)
rocket_reset()
  drm_sched_stop()
  pm_runtime_get_if_active()
  ...
  pm_runtime_put_autosuspend()
                                  rocket_job_handle_irq()
                                    pm_runtime_put_autosuspend(core->dev)
                                    core->in_flight_job =3D NULL
  synchronize_irq(core->irq)
  put_job_ref =3D core->in_flight_job (NULL)
  rocket_core_reset(core)         <-- no runtime PM ref held

rocket_reset() relies on the in-flight job's runtime PM reference to keep
core->dev powered across rocket_core_reset(), because the temporary
reference from pm_runtime_get_if_active() is dropped before
synchronize_irq().  If rocket_job_handle_irq() finishes the last task and
clears core->in_flight_job before synchronize_irq() returns,
rocket_core_reset() executes with zero runtime PM references held, which
allows core->dev to suspend before or during the reset and hang the board.

> =20
> +	if (put_job_ref)
> +		pm_runtime_put_autosuspend(core->dev);

[Severity: High]
Does pm_runtime_put_autosuspend() guarantee that the power domain is
switched off and on again before the next job runs?

rocket_core_init() configures a 50 ms autosuspend delay on core->dev:

drivers/accel/rocket/rocket_core.c:rocket_core_init() {
	...
	pm_runtime_use_autosuspend(dev);
	...
	pm_runtime_set_autosuspend_delay(dev, 50);
}

In rocket_reset(), pm_runtime_put_autosuspend(core->dev) only arms the
50 ms timer and leaves core->dev active, and drm_sched_start(&core->sched,
0) is called immediately afterward.  When another job is already queued in
the scheduler (or submitted within 50 ms), rocket_job_run() calls
pm_runtime_resume_and_get(core->dev) while core->dev is still active,
canceling the autosuspend timer without ever suspending the device or
cycling the power domain.  On RK3576, the NPU bus interface is then not
reset and the job after the timeout still fails.

[1] https://lore.kernel.org/r/CAEWPSH7tM9WQUJ0H13ghkiHGzDcdycC1syTuO5B8DpC6=
cUSnfg@mail.gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794615324.gi=
t.gahing@gahingwoo.com?part=3D4
