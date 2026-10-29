Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216FF606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EztMzR70
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B6B01120EA;
	Thu, 29 Oct 2026 08:58:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF2B910E7B0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:58:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 135E3600DA;
 Thu, 29 Oct 2026 08:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33331F01828;
 Thu, 29 Oct 2026 08:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793264309;
 bh=1EZf7s88YbrKMsz46vuw8qqZDkM0uBKTXdzRZajLE2c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EztMzR701Ag0CssIIrgoZT722KVylmE+zb5Hnr4NilE95aPlMQCUJpHk++GGP4jmO
 +GApY7LwhD6GPbMVr2h+sXn4bTkXPACzuJ06BTmGSKijRjuKYQH/eyBVb0H3f7pbqM
 vksurTQmtwIzJKw+qR4dqu7BcVynyU4V61Vz/pRCRn9KZ1lTObkq6u75yXfphKov15
 i3/WqHCWQjMZ8FZwmQcUl5NewUBicsa6h/j4sJu7wqGYG0UoMll+Q2LkG0j7kjtsex
 NNtSXnZ+qtSMmyGQWM6JQl4Giwlo6h3OdhMjDZZfLwxousBNGeQ7tJO0IXE2UjmWtX
 HZYdEo+UsE0fQ==
Message-ID: <sashiko-outbox-188997@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imagination: retry runtime idle when firmware is
 not yet idle
To: "Baihui Liang" <liangbaihui@linux.spacemit.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-img-pm-autosuspend-v1-1-26851840a34e@linux.spacemit.com>
References: <20261029-img-pm-autosuspend-v1-1-26851840a34e@linux.spacemit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:58:29 +0000
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
- [High] drm/imagination: pvr_power_device_idle() bypasses idle check on au=
tosuspend
--

commit 21bc022f1187eccd547ba4f832837505cc945974
Author: Baihui Liang <liangbaihui@linux.spacemit.com>

drm/imagination: retry runtime idle when firmware is not yet idle

This patch modifies pvr_power_device_idle() to call pm_runtime_autosuspend()
before returning -EBUSY when pvr_power_is_idle() returns false, aiming to
retry the idle check once the firmware reaches ROGUE_FWIF_POW_IDLE.

> diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/im=
agination/pvr_power.c
> index eb4b6ecdf4f4d..6f38249ffcb72 100644
> --- a/drivers/gpu/drm/imagination/pvr_power.c
> +++ b/drivers/gpu/drm/imagination/pvr_power.c
> @@ -434,7 +434,16 @@ pvr_power_device_idle(struct device *dev)
>  	struct drm_device *drm_dev =3D platform_get_drvdata(plat_dev);
>  	struct pvr_device *pvr_dev =3D to_pvr_device(drm_dev);
> =20
> -	return pvr_power_is_idle(pvr_dev) ? 0 : -EBUSY;
> +	if (pvr_power_is_idle(pvr_dev))
> +		return 0;
> +
> +	/*
> +	 * Firmware not yet idle; reject but schedule autosuspend so
> +	 * runtime_idle() can be retried.
> +	 */
> +	pm_runtime_autosuspend(dev);
> +
> +	return -EBUSY;
>  }

[Severity: High]
Does calling pm_runtime_autosuspend() from pvr_power_device_idle() actually
retry the ->runtime_idle() callback, or does it bypass the idle check and r=
un
pvr_power_device_suspend() directly?

Looking at pm_runtime_autosuspend() in include/linux/pm_runtime.h:

static inline int pm_runtime_autosuspend(struct device *dev)
{
	pm_runtime_mark_last_busy(dev);
	return __pm_runtime_suspend(dev, RPM_AUTO);
}

When pvr_power_device_idle() calls pm_runtime_autosuspend() because
pvr_power_is_idle() returned false (for example, when pvr_kccb_send_cmd()
in drivers/gpu/drm/imagination/pvr_ccb.c drops its runtime PM reference via
pvr_power_put() while a caller is still waiting in
pvr_kccb_wait_for_completion(), or while firmware has not yet transitioned
to ROGUE_FWIF_POW_IDLE), __pm_runtime_suspend(dev, RPM_AUTO) invokes
rpm_suspend(dev, RPM_AUTO).

When the autosuspend delay is non-zero, rpm_suspend() arms
dev->power.suspend_timer with dev->power.timer_autosuspends =3D 1, and
returning -EBUSY from pvr_power_device_idle() to rpm_idle() does not cancel
that timer. When the timer fires, pm_suspend_timer_fn() in
drivers/base/power/runtime.c runs:

	if (expires > 0 && expires <=3D ktime_get_mono_fast_ns()) {
		dev->power.timer_expires =3D 0;
		rpm_suspend(dev, dev->power.timer_autosuspends ?
		    (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
	}

This queues RPM_REQ_AUTOSUSPEND on pm_wq, which calls rpm_suspend() ->
pvr_power_device_suspend() directly without calling rpm_idle() or
pvr_power_device_idle().

Because pvr_power_device_suspend() in drivers/gpu/drm/imagination/pvr_power=
.c
does not check pvr_power_is_idle():

int
pvr_power_device_suspend(struct device *dev)
{
	...
	if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
		err =3D pvr_power_fw_disable(pvr_dev, false, true);

won't the driver unconditionally disable firmware when the autosuspend timer
expires, even if the firmware or KCCB is still busy?

Furthermore, if pm_runtime_autosuspend_expiration() returns 0 when
pm_runtime_autosuspend() is called (for example, if autosuspend_delay_ms is
set to 0 via sysfs), __pm_runtime_suspend(dev, RPM_AUTO) is synchronous and
will execute pvr_power_device_suspend() immediately from inside
pvr_power_device_idle() right after pvr_power_is_idle() returned false.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-img-pm-aut=
osuspend-v1-1-26851840a34e@linux.spacemit.com?part=3D1
