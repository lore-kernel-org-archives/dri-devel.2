Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6524BC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F67B10E535;
	Tue,  8 Sep 2026 22:18:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DW37KdBQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27A210E535
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:18:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6342541ABE
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330411F00A3A;
 Tue,  8 Sep 2026 22:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905887;
 bh=9w0015xONyuByLpla6eMHdkmUgqXoDh6AimJs6ehcvw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DW37KdBQpw0+vMZ4cYj41h2dR1ChmMvTfGbMB5I3uSk4LOgg+a6IwtmppMmwi22dW
 G0ovYmB4EDfXe7bIsypPj4jKlxNYIWNTyiGJSxSnpPnQK7dxEbDc8CqxMaIvBgsQg+
 7r89Z/p1y9GFH5d/JF8Jj16IGOoGEh0a0SY7Z0mg0GX8cUPsq5bGXXlLc/6jCiM+eT
 UQrO36QZNR5Z7how5bbidp1TtlrfnuW9XqlcrdWosxZ+72hsw5Uiw12E8/JG4LGUGd
 Oacb5YSHWLNmbWPynrbyx8O3cCXVVLOZm4dcRTyBEPSSr809eB9j4MYiqdXcrXF104
 /j3kRsgl538Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/22] accel: ethosu: Suspend after initialization
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-ethosu-fixes-v3-1-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
 <20260908-ethosu-fixes-v3-1-490fe215286f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:18:06 +0000
Message-Id: <20260908221807.330411F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware Access in IRQ Handler
- [High] TOCTOU race on `dev->in_flight_job` between the IRQ handler and th=
e timeout worker causes job tracking corruption
- [Medium] Missing pm_runtime_mark_last_busy() defeats autosuspend function=
ality
--

commit 70e7c7d4b9e3f59284be594e6021ace41a2927aa
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Suspend after initialization

The initial runtime-PM reference is held only while initializing the
NPU. Release it synchronously from ethosu_init() after the final
hardware access, before registering the DRM device.

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index 8108622de258f..df76253d01a64 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -338,6 +338,8 @@ static int ethosu_init(struct ethosu_device *ethosude=
v)
>  		 ethosudev->npu_info.sram_size / 1024,
>  		 ethosudev->npu_info.pmu_counters);
> =20
> +	pm_runtime_put_sync_suspend(ethosudev->base.dev);
> +
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does explicitly disabling the
NPU clocks here expose a risk of crashing in the IRQ handler?

If a spurious interrupt occurs while the device is suspended, the IRQ handl=
er
will unconditionally read from the unclocked NPU registers:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_irq_handler() {
	struct ethosu_device *dev =3D data;
	u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);

	if (!(status & STATUS_IRQ_RAISED))
		return IRQ_NONE;
	...
}

Subsystem guidelines mandate that IRQ handlers use pm_runtime_get_if_active=
()
to verify the device is powered on before accessing any registers. Accessing
memory-mapped registers of an unclocked device typically triggers a
synchronous bus fault or asynchronous external abort, resulting in a system
crash.

[ ... ]

[Severity: High]
This is a pre-existing issue, but can the timeout worker and IRQ handler ra=
ce
and corrupt the job tracking?

ethosu_job_handle_irq() reads dev->in_flight_job without locking:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_handle_irq() {
	...
	job =3D READ_ONCE(dev->in_flight_job);
	if (job) {
		WRITE_ONCE(dev->in_flight_job, NULL);
		dma_fence_signal(job->done_fence);
	}
}

Concurrently, ethosu_job_timedout() can run in a workqueue, stop the schedu=
ler,
and modify the state without locking:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_timedout() {
	...
	drm_sched_stop(&dev->sched, bad);

	WRITE_ONCE(dev->in_flight_job, NULL);

	/* Proceed with reset now. */
	pm_runtime_force_suspend(dev->base.dev);
	pm_runtime_force_resume(dev->base.dev);

	/* Restart the scheduler */
	drm_sched_start(&dev->sched, 0);
	...
}

If the scheduler immediately pushes a new job, updating dev->in_flight_job,
could the preempted IRQ thread resume and blindly execute
WRITE_ONCE(dev->in_flight_job, NULL), overwriting the new job's tracking?

When the new job completes, the IRQ handler would read NULL and fail to sig=
nal
its fence, causing a perfectly valid job to falsely time out and trigger an
unnecessary hardware reset loop.

[Severity: Medium]
This is a pre-existing issue, but does this autosuspend implementation actu=
ally
delay powering down the NPU?

In ethosu_job_cleanup(), the driver drops the runtime PM reference:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_cleanup() {
	struct ethosu_job *job =3D container_of(ref, struct ethosu_job,
						refcount);

	pm_runtime_put_autosuspend(job->dev->base.dev);
	...
}

Since pm_runtime_mark_last_busy() is never called, the autosuspend timer
evaluates from the beginning of the active PM transition rather than its
completion.

Will the old last_busy timestamp cause the autosuspend delay to evaluate as
already expired, defeating the autosuspend mechanism and leading to excessi=
ve
hardware power cycling?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-ethosu-fix=
es-v3-0-490fe215286f@kernel.org?part=3D1
