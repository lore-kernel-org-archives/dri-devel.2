Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15EC606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=es3jmm3y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5AE11231F;
	Thu, 29 Oct 2026 14:07:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC2B11231F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:07:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EA8A741829
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25AC1F01828;
 Thu, 29 Oct 2026 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793282838;
 bh=QvD7ngkujWRyKrZ5PZEz0HgN8VscJ7YILyZvwNx5MEI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=es3jmm3y/Eto0gV2jHc4+7mxCEF1oOSICWNp0wy+IZeALp2y/RatlXAv/Jh0xti3P
 A0jBQWxrxpd+6bdkbgg7Sg4F49XfaUjDnJ6JDnoLpa1sA1X3ICPPCkJL0MXIWCmqvw
 zvv8zARzmBbPZmWe26Ej14aOeMF8u139B5ycLrDPLsHYh0UMpsyrvw7SAubTnD//JB
 QZ1QFStaweTvkuMsV2kOXfoZqUvfWH5+IczP279eDf37T4NHcYWSQ9ZFjDd1KNl3+2
 ZEsZQtX16Y6/kwJuBPYtSOVsGFxc/3CprCjXJS9D8MNkStueBpfnGUZVEmnVZIRCmJ
 kIlO0sjJSvl6g==
Message-ID: <sashiko-outbox-189474@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/31] accel: ethosu: Quiesce jobs before scheduler
 teardown
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-ethosu-fixes-v4-5-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-5-4aa25e22578e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:07:18 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] accel: ethosu: wrong TDR and IRQ teardown order in ethosu_job_fini=
()
--

commit 0cd4405bf9fa95eb128e9e0dbd76f0af4d652c5c
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Quiesce jobs before scheduler teardown

This commit stops the scheduler workqueue and timeout work, resets the NPU =
if
a job is in flight, and synchronizes the IRQ before calling drm_sched_fini(=
).
It also adds a cancel_job callback so queued jobs are signaled with
-ECANCELED during scheduler teardown.

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> index b7faa715b47e4..d418ae7961cff 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c

[ ... ]

> @@ -361,6 +373,15 @@ int ethosu_job_init(struct ethosu_device *edev)
> =20
>  void ethosu_job_fini(struct ethosu_device *dev)
>  {
> +	drm_sched_wqueue_stop(&dev->sched);
> +	cancel_delayed_work_sync(&dev->sched.work_tdr);
> +
> +	if (READ_ONCE(dev->in_flight_job)) {
> +		WRITE_ONCE(dev->in_flight_job, NULL);
> +		ethosu_device_reset(dev);
> +	}
> +
> +	synchronize_irq(dev->irq);
>  	drm_sched_fini(&dev->sched);
>  }

[Severity: High]
Could the ordering of drm_sched_wqueue_stop(), cancel_delayed_work_sync(), =
and
IRQ synchronization here allow work_run_job or work_tdr to be re-queued dur=
ing
teardown?

First, drm_sched_wqueue_stop() is called before canceling dev->sched.work_t=
dr.
If dev->sched.work_tdr is already executing ethosu_job_timedout() when
ethosu_job_fini() starts, cancel_delayed_work_sync() waits for it to finish:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_timedout() {
	...
	drm_sched_stop(&dev->sched, bad);

	WRITE_ONCE(dev->in_flight_job, NULL);

	/* Proceed with reset now. */
	pm_runtime_force_suspend(dev->base.dev);
	pm_runtime_force_resume(dev->base.dev);

	/* Restart the scheduler */
	drm_sched_start(&dev->sched, 0);

	return DRM_GPU_SCHED_STAT_RESET;
}

At the end of ethosu_job_timedout(), drm_sched_start() calls
drm_sched_wqueue_start(), which clears sched->pause_submit and queues
work_run_job and work_free_job on sched->submit_wq. Once
cancel_delayed_work_sync() returns, work_run_job can pop a queued job and c=
all
ethosu_job_run() -> ethosu_job_hw_submit(), setting dev->in_flight_job,
submitting a new job to the NPU, and re-arming work_tdr via
drm_sched_job_begin() concurrently with ethosu_device_reset() and
synchronize_irq().

Second, cancel_delayed_work_sync(&dev->sched.work_tdr) runs before
ethosu_device_reset() and synchronize_irq(dev->irq). Before the NPU is reset
and the IRQ is synchronized, ethosu_job_irq_handler_thread() ->
ethosu_job_handle_irq() can still run and handle an error interrupt without
checking dev->in_flight_job:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_handle_irq() {
	...
	if (status & (STATUS_BUS_STATUS | STATUS_CMD_PARSE_ERR)) {
		dev_err(dev->base.dev, "Error IRQ - %x\n", status);
		drm_sched_fault(&dev->sched);
		return;
	}
	...
}

Calling drm_sched_fault() schedules dev->sched.work_tdr again after
cancel_delayed_work_sync() has already returned. That allows
ethosu_job_timedout() to run concurrently with ethosu_device_reset() (where
pm_runtime_force_suspend() disables the NPU clocks while ethosu_device_rese=
t()
polls MMIO registers and clears SRAM with memset_io()) as well as concurren=
tly
with drm_sched_fini().

Note that while a later commit in the series ("accel: ethosu: Keep scheduler
after unplug") replaces this with ethosu_job_stop() and calls
disable_irq(dev->irq) before cancel_delayed_work_sync(&dev->sched.work_tdr),
it still calls drm_sched_wqueue_stop(&dev->sched) before
cancel_delayed_work_sync(&dev->sched.work_tdr), which leaves the race where=
 an
in-progress ethosu_job_timedout() calls drm_sched_start() and restarts
work_run_job and work_free_job.

Should the IRQ be disabled or synchronized before canceling work_tdr, and
should drm_sched_wqueue_stop() be called after cancel_delayed_work_sync() (=
or
after preventing ethosu_job_timedout() from calling drm_sched_start() during
teardown)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-ethosu-fix=
es-v4-0-4aa25e22578e@kernel.org?part=3D5
