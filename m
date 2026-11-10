Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89B7606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nN/hDOzA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B9510E921;
	Tue, 10 Nov 2026 07:33:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E4D10E921
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:33:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 948BE439B5;
 Tue, 10 Nov 2026 07:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C691F0089F;
 Tue, 10 Nov 2026 07:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794295982;
 bh=A24MAzSBFFeu0eMnzyc5HF0ADj2zpXsK8d+7f++FL44=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nN/hDOzAyfjD2R0Sfo8zJXvdVA8GjDUC+LB+ZXkcwrYAT0ez0sfspSkOCWK3EWVTD
 nu2vaNbqxdbEWexQAq6Amo9XThpJQoQJPpZiJT30dpIJkuAgJUmj3xxbjl8yUWBTgT
 PC9rF3hItZWk8VYcOvBqzXFL7M5awfcdPwgkQi55WB2q/XZOzctjGwze7sigv3qL5w
 KsSEThbsioSe372D9ArIWj/UqGAiCVne5Wngc4h+w3oBFB0N0fXXPlZehBi6cN/bLl
 OIQQ+N+sGoTUiuPLgPHfqKFZdN8cWPgu7osBm55+NO29lN3zOyDRDMbNZAr20iqcCh
 UBa2Q5yl0ngVg==
Message-ID: <sashiko-outbox-206498@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panthor: Do not change the GPU clock rate while
 suspended
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-panthor-suspend-clk-v1-1-53457050e51e@gmail.com>
References: <20261110-panthor-suspend-clk-v1-1-53457050e51e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:33:01 +0000
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
- [High] drm/panthor: skipped rates in panthor_devfreq_target() lost
  across resume
- [Medium] drm/panthor: lockless pm.state check in
  panthor_devfreq_can_set_rate() races
- [Low] drm/panthor: missing Fixes trailer on panthor_devfreq_target()
  bug fix
--

commit b3aaf374222f607db90947d06a6fffd9f1ae68b2
Author: Arun Iyengar <aiyengar1990@gmail.com>

> drm/panthor: Do not change the GPU clock rate while suspended
>
> From the start of panthor_device_suspend() until panthor_device_resume()
> has enabled the clocks again, the GPU clocks are off or about to be, and
> the GPU power domain may be down. devfreq can still call ->target() in
> that window: a write to min_freq or max_freq in sysfs, a thermal cooling
> state change or a PM QoS request all end up in update_devfreq() whatever
> the device state.
>
> With the RK3588 GPU core clock switched to the firmware-managed
> SCMI_CLK_GPU (needed to reach the PVTPLL rates of the upper OPPs), such
> a call is fatal. To set a PVTPLL rate TF-A programs registers in the GPU
> GRF, which sit in the GPU power domain, and with the domain off that
> access ends in an asynchronous SError and a kernel panic, for example
> after
>
>   echo 1000000000 > /sys/class/devfreq/fb000000.gpu/min_freq
>
> while the GPU is runtime suspended.
>
> Only apply a rate to the hardware while the device is resuming or
> active, plus the suspend frequency that devfreq_suspend_device() applies
> from the suspend path while the GPU is still powered. Other requests are
> still accepted and recorded by devfreq, which applies them on resume or
> at the next governor update.
>
> The RFC this is based on (Jonas Karlman's panthor SCMI clock change,
> carried in Armbian's linux-rockchip pull request 380) checked the
> runtime PM status instead. That
> status is still RPM_SUSPENDING after panthor_devfreq_suspend() has run,
> which leaves a window where the rate can be raised again right before
> the power domain goes down. The devfreq suspend count cannot be used
> either: panthor's first runtime resume calls devfreq_resume_device()
> without a matching suspend, so the count is -1 while the GPU is active
> and 0 while it is suspended.
>
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

[Severity: Low]
This fixes a crash when panthor_devfreq_target() is called while the device
is suspended.  Should it include:

  Fixes: fac9b22df4b1 ("drm/panthor: Add the devfreq logical block")

> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/=
panthor/panthor_devfreq.c
> index 2249b41ca4afe..cab86e9c9d46a 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -60,20 +60,56 @@ static void panthor_devfreq_update_utilization(struct=
 panthor_devfreq *pdevfreq)
>  	pdevfreq->time_last_update =3D now;
>  }
> =20
> +/*
> + * Whether a new rate can be applied to the hardware now.
> + *
> + * From the start of panthor_device_suspend() until panthor_device_resum=
e()
> + * has enabled the clocks again, the GPU clocks are about to be disabled
> + * or are off, and the GPU power domain may be down. devfreq can still
> + * call ->target() in that window: sysfs
> + * min_freq/max_freq writes, thermal cooling and PM QoS requests all end
> + * up in update_devfreq() whatever the device state.
> + *
> + * Changing the rate then is pointless, and harmful where the core clock
> + * is managed by firmware: on RK3588, setting SCMI_CLK_GPU to a PVTPLL
> + * rate with the GPU power domain off makes TF-A access the powered-down
> + * GPU GRF, which ends in an asynchronous SError. So while the device is
> + * suspending only the suspend frequency, applied by
> + * devfreq_suspend_device(), reaches the hardware, and nothing does
> + * while it is suspended. devfreq records the other requests: they are
> + * applied on resume or at the next governor update.
> + */
> +static bool panthor_devfreq_can_set_rate(struct panthor_device *ptdev,
> +					 unsigned long freq)
> +{
> +	struct devfreq *devfreq =3D ptdev->devfreq ? ptdev->devfreq->devfreq : =
NULL;
> +
> +	switch (atomic_read(&ptdev->pm.state)) {
> +	case PANTHOR_DEVICE_PM_STATE_SUSPENDED:
> +		return false;
> +	case PANTHOR_DEVICE_PM_STATE_SUSPENDING:
> +		return devfreq && devfreq->suspend_freq &&
> +		       freq =3D=3D devfreq->suspend_freq;
> +	default:
> +		return true;
> +	}
> +}

[Severity: Medium]
Can panthor_devfreq_can_set_rate() still allow dev_pm_opp_set_rate() to run
while the GPU clocks are disabled or being turned off?

Neither panthor_device_suspend() nor panthor_device_resume() synchronizes
ptdev->pm.state transitions and clock enable/disable with devfreq->lock:

CPU0                                  CPU1
panthor_device_suspend()
  panthor_devfreq_suspend(ptdev)
                                      update_devfreq()
                                        panthor_devfreq_target()
                                          panthor_devfreq_can_set_rate()
                                            /* state is SUSPENDING and
                                             * freq =3D=3D suspend_freq -> =
true
                                             */
  clk_disable_unprepare(clks.coregroup)
  clk_disable_unprepare(clks.stacks)
  clk_disable_unprepare(clks.core)
  atomic_set(..., SUSPENDED)
  /* genpd powers down GPU */
                                          dev_pm_opp_set_rate()
                                            <-- accesses powered-down GPU G=
RF

The same race exists when panthor_devfreq_can_set_rate() sees
PANTHOR_DEVICE_PM_STATE_ACTIVE right before panthor_device_suspend() disabl=
es
the clocks (when suspend_freq is 0 and polling is stopped,
devfreq_suspend_device() does not take devfreq->lock).  Likewise,
panthor_device_resume() sets PANTHOR_DEVICE_PM_STATE_RESUMING before
enabling clks.core, clks.stacks and clks.coregroup, and leaves it set across
clk_disable_unprepare() on the err_suspend_devfreq error path, where the
default branch in panthor_devfreq_can_set_rate() returns true while the
clocks are off.

> +
>  static int panthor_devfreq_target(struct device *dev, unsigned long *fre=
q,
>  				  u32 flags)
>  {
> +	struct panthor_device *ptdev =3D dev_get_drvdata(dev);
>  	struct dev_pm_opp *opp;
> -	int err;
> =20
>  	opp =3D devfreq_recommended_opp(dev, freq, flags);
>  	if (IS_ERR(opp))
>  		return PTR_ERR(opp);
>  	dev_pm_opp_put(opp);
> =20
> -	err =3D dev_pm_opp_set_rate(dev, *freq);
> +	if (!panthor_devfreq_can_set_rate(ptdev, *freq))
> +		return 0;
> =20
> -	return err;
> +	return dev_pm_opp_set_rate(dev, *freq);
>  }

[Severity: High]
Does returning 0 from panthor_devfreq_target() without saving *freq cause
frequency updates made while suspended to be lost across resume?

In devfreq_set_target(), devfreq updates devfreq->previous_freq =3D new_fre=
q,
but only records devfreq->resume_freq when devfreq->suspend_freq is non-zer=
o:

drivers/devfreq/devfreq.c:devfreq_set_target() {
    ...
	devfreq->previous_freq =3D new_freq;

	if (devfreq->suspend_freq)
		devfreq->resume_freq =3D new_freq;
    ...
}

When opp-suspend is not defined in DT (devfreq->suspend_freq =3D=3D 0),
devfreq->resume_freq stays 0 and devfreq_resume_device() does not call
devfreq_set_target() on resume.  With non-polling governors (performance,
powersave, userspace), DEVFREQ_GOV_RESUME is a no-op, so any min_freq,
max_freq, set_freq or governor change made while runtime-suspended updates
devfreq->previous_freq without ever programming the hardware clock on resum=
e.
With simple_ondemand, devfreq_monitor_resume() overwrites
devfreq->previous_freq with clk_get_rate() (the stale pre-suspend clock rat=
e)
and only queues polling work for polling_ms (50 ms) later, so resumed jobs
run at the stale rate for the first 50 ms or across short job bursts.

Even when devfreq->suspend_freq is non-zero, panthor_device_suspend() sets
PANTHOR_DEVICE_PM_STATE_SUSPENDING before panthor_sched_suspend(),
panthor_fw_suspend(), panthor_mmu_suspend(), panthor_gpu_suspend() and
panthor_pwr_suspend().  Any rate change skipped during that window has its
devfreq->resume_freq overwritten when panthor_devfreq_suspend() ->
devfreq_suspend_device() calls devfreq_set_target(devfreq,
devfreq->suspend_freq, 0), so devfreq_resume_device() restores suspend_freq
instead of the requested rate.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-panthor-su=
spend-clk-v1-1-53457050e51e@gmail.com?part=3D1
