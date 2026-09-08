Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00E2C79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E4010EDD4;
	Tue,  8 Sep 2026 22:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QIrg5xQA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC3E10EDD4
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:20:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6CE9B601F9
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055021F00A3A;
 Tue,  8 Sep 2026 22:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788906036;
 bh=8S1L8pviGfhS5rv7agIuedeGFAUMb9nBwS6CgD5TxEI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QIrg5xQAw65kLLq4nVCi2QF7MeLzDFzfPC6xKDrcFayNb8CJt5IuMuAGBv+yWJOhO
 NFW29uewk94wDDLXZ06Xz0NlrZgED9k/ck0Z9u7GliJVsqLxg4C1iP63kd8aLnGFcg
 ulKQ7WedmFj451/O8qwXou4742gHwtiyhiSS/uJ0k/8uW7ponOrqk7rRQLJXFtv1BW
 al/5jdh2n4aPPG0ryrxA8wMkj5jp6OvjhzYpAyZnZw2VT+fSS+eMZi5Lezv4zKEc5b
 /ml6+S0RHbtehD1zsvdsyiORYEsG70HBedcGRAj7oU5NcMjhAS9mlzGyl2L6/c1cEz
 IKX74oe5TICiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/22] accel: ethosu: Quiesce jobs before scheduler
 teardown
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-ethosu-fixes-v3-5-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
 <20260908-ethosu-fixes-v3-5-490fe215286f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:20:35 +0000
Message-Id: <20260908222036.055021F00A3A@smtp.kernel.org>
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
- [Critical] This problem wasn't introduced by this patch, but prematurely =
tearing down the DRM scheduler during device removal causes a Use-After-Fre=
e and unkillable process hang if userspace keeps the DRM file open.
- [Critical] This problem wasn't introduced by this patch, but missing disa=
ble_irq() during driver teardown allows the IRQ handler to re-arm the sched=
uler timeout work after or during scheduler teardown, leading to a Use-Afte=
r-Free.
--

commit 7894a2554c9bc3dc755e00a1fa982b373faef388
Author: Rob Herring (Arm) <robh@kernel.org>
accel: ethosu: Quiesce jobs before scheduler teardown

This commit attempts to safely tear down the scheduler during driver removal
by stopping the submission and timeout workqueues, resetting the NPU device,
and synchronizing the IRQ before freeing the scheduler.

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> index ec65305e0cd7d..a1443cd0c5b05 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
[ ... ]
> @@ -363,6 +375,15 @@ int ethosu_job_init(struct ethosu_device *edev)
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

[Severity: Critical]
This isn't a bug introduced by this patch, but does the missing disable_irq=
()
during driver teardown leave a window for the IRQ handler to re-arm the
scheduler timeout work?

While synchronize_irq() waits for currently running IRQ handlers to finish,=
 it
does not disable the IRQ line itself. Since devm_request_threaded_irq() kee=
ps
the IRQ alive until the devres release phase (which happens after the driver
remove function returns), a late interrupt could still fire.

If an interrupt fires after synchronize_irq() returns, ethosu_job_handle_ir=
q()
could execute and call drm_sched_fault(), which re-arms the delayed timeout
work (work_tdr) on a destroyed scheduler. Could this lead to a
Use-After-Free?

>  	drm_sched_fini(&dev->sched);

[Severity: Critical]
This is a pre-existing issue, but does prematurely tearing down the DRM
scheduler during device removal cause a Use-After-Free and an unkillable
process hang if userspace keeps the DRM file open?

When the device is unbound (e.g., via sysfs or hotplug), ethosu_job_fini()
halts the workqueues and destroys the scheduler. If a userspace process kee=
ps
the DRM file descriptor open and closes it later, ethosu_postclose() will
initiate the teardown of the entity via ethosu_job_close().

Because the scheduler has already been freed, the entity teardown will acce=
ss
freed memory and hang forever waiting for jobs to execute on the stopped
scheduler. Can we ensure the scheduler remains alive until all entities
are destroyed?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-ethosu-fix=
es-v3-0-490fe215286f@kernel.org?part=3D5
