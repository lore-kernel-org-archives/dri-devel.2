Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30218CA9ECF
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A17D10E393;
	Sun, 11 Oct 2026 17:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C3zBaAK8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D55210E393
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 17:53:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 46E73600E2;
 Sun, 11 Oct 2026 17:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAB01F0089B;
 Sun, 11 Oct 2026 17:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791741193;
 bh=jWahAPBDB7WfFiHwbbeKNJWjnMkaQ07Cq2A04ChjRoE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C3zBaAK8Wz8y0IqlPiYD5ehXdDDiaXhyyTMgc6vXihIDgRRmesx1uE2G9RcqO0Udo
 0qqO4jM+7kDmajjfvanCqKk0fmpHtQmZvQRKkbt0q6EzUqIUFkEFcLOYyEln0wXaF8
 AFTX07tIfQLyoai9WmSQtvx6RiNRdavij6tPSlRPvVu5+wYZgT6qHx8Bncl4XfjfIY
 hYuYkVii2yfNck3k39iXq3qBInil766Io3czfaoVsga6rcPL5l9q8g+1A4i1Zd+zNY
 C04OKIQjb88mfRTFJx+D9WclMpdI9k9k1tQA/8e5mllE5rUdJtqv7DJZh7DkOvq/fk
 ojqRUyl+4ccgQ==
Message-ID: <sashiko-outbox-167362@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/8] drm/panthor: Add suspend, resume and reset handling
To: "Lukas Zapolskas" <lukas.zapolskas@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261011-panthor-performance-counters-v7-7-12c32495062f@arm.com>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
 <20261011-panthor-performance-counters-v7-7-12c32495062f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 17:53:12 +0000
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
- [High] drm/panthor: perf: pending samples lost during slow reset on resume
- [Medium] drm/panthor: pending perf sample lost due to boot IRQ race durin=
g reset
- [Low] drm/panthor: perf: missing error check for perf_enable() in post_re=
set
--

commit d99b13df2062b5b287000f68e515acd129ee6cf2
Author: Lukas Zapolskas <lukas.zapolskas@arm.com>
Subject: drm/panthor: Add suspend, resume and reset handling

This commit introduces suspend, resume, and reset handling for the
performance counter subsystem in the Panthor driver. It ensures sampling
is disabled and re-enabled around suspends, and reprograms the firmware
interface after a reset to avoid losing pending sample data.

> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -539,8 +542,10 @@ int panthor_device_resume(struct device *dev)
>  			ret =3D panthor_device_resume_hw_components(ptdev);
>  		}
> =20
> -		if (!ret)
> +		if (!ret) {
>  			panthor_sched_resume(ptdev);
> +			panthor_perf_resume(ptdev);
> +		}

[Severity: High]
Does calling panthor_perf_resume() unconditionally here cause pending
samples to be lost if a slow reset was performed during resume?

When the system resumes, panthor_device_resume() can perform a slow reset if
a fast reset fails or a reset was pending prior to suspend. A slow reset
zeroes out the firmware's shared memory, wiping out any pending requests.

Unlike panthor_perf_post_reset(), panthor_perf_resume() only calls
perf_enable() and omits the re-request logic. As a result,
fw_sample_requested remains permanently true in the driver while the
firmware is unaware of it.

This could cause all future performance sample requests for the session to =
be
silently dropped and permanently block session destruction.

> diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/pan=
thor/panthor_perf.c
> --- a/drivers/gpu/drm/panthor/panthor_perf.c
> +++ b/drivers/gpu/drm/panthor/panthor_perf.c
[ ... ]
> +void panthor_perf_post_reset(struct panthor_device *ptdev)
> +{
> +	bool rerequest =3D false;
> +
> +	if (!ptdev->perf)
> +		return;
> +
> +	guard(mutex)(&ptdev->perf->op_lock);
> +
> +	perf_enable(ptdev->perf);

[Severity: Low]
Is it intentional to discard the return value of perf_enable() here?

In panthor_perf_resume(), the return value of perf_enable() is checked and
logged upon failure via drm_warn().=20

If the firmware fails to acknowledge the sampling start request during a
reset recovery here, no warning is emitted and userspace will silently stop
receiving samples without any diagnostic trace in the kernel log.

> +
> +	scoped_guard(spinlock_irqsave, &ptdev->perf->pend_lock) {
> +		rerequest =3D ptdev->perf->fw_sample_requested;

[Severity: Medium]
Can this race with the boot interrupt handler and lose pending samples?

If a slow GPU reset occurs while a performance counter sample is pending,
the MCU is rebooted and fires a boot interrupt before
panthor_perf_post_reset() executes.

The interrupt handler panthor_job_irq_handler() processes this and calls
panthor_perf_report_irq(). Because the shared memory was zeroed by the
reset, req and ack will both be 0. This causes panthor_perf_report_irq() to
evaluate sample_acked as true and erroneously clear the host-side flag:

drivers/gpu/drm/panthor/panthor_perf.c:panthor_perf_report_irq() {
    ...
    const bool sample_acked =3D ((req & GLB_PERFCNT_SAMPLE) =3D=3D
                               (ack & GLB_PERFCNT_SAMPLE));
    ...
    if (sample_acked) {
        guard(spinlock_irqsave)(&perf->pend_lock);
        perf->fw_sample_requested =3D false;
    }
}

When the reset worker later reaches panthor_perf_post_reset(), it would see
rerequest as false and fail to re-request the sample, breaking the exact
feature introduced by this patch.

> +
> +		if (rerequest)
> +			ptdev->perf->fw_sample_requested =3D false;
> +	}
> +
> +	if (rerequest)
> +		perf_fw_request_sample(ptdev->perf);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-panthor-pe=
rformance-counters-v7-0-12c32495062f@arm.com?part=3D7
