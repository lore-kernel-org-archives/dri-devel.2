Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B89C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F418210E8F6;
	Tue,  4 Aug 2026 08:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X2Tw0AXa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E07A10E8F6
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:37:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56A08600AA;
 Tue,  4 Aug 2026 08:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8451F00A3D;
 Tue,  4 Aug 2026 08:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785832628;
 bh=oTW1PYZcVUnrbob+AkDygsawNkQa69UCku9iYiabzbk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X2Tw0AXarieigFrhpal5wrqzANsHqDjsiJ44JAyv7MnYR5Bfja9ISCgrCoXiTx7Ds
 Xc+l8yDjFtxORYCvDuN3S6WgjMYqecMfH5D5qnTHX/O7KKI7557NzbaS047FP+Bw9F
 eQfZ7EPgr7eHK4R9umpoNirOnFFLad94WqhOJcW4fGeksaymJTeY7uYJk2NWDHiZQU
 GhZvwoeO2l+O8lMUHAycTJLa+tgjchyC4YsNcqJAwc0spqhtG+AyAzPHEy6IY1HIjP
 ugVafYq5+oEdwHmbP70btlef6jqazFy6lriphtlWh8RN7R1mQuBT8/v/mtLRJqCenb
 fHOlMh9ZxljWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/10] drm/bridge: analogix_dp: Manage pm runtime and
 IRQ for native HPD pin detection
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260804081717.741404-2-damon.ding@rock-chips.com>
References: <20260804081717.741404-1-damon.ding@rock-chips.com>
 <20260804081717.741404-2-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 08:37:07 +0000
Message-Id: <20260804083707.CB8451F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The DP controller IRQ for native HPD mode is left enabled during s=
ystem suspend, risking a kernel crash on hotplug events.
- [High] Component bind failure leaves HPD IRQ enabled and PM reference lea=
ked, causing a Use-After-Free.

Pre-existing issues:
- [High] The return value of `pm_runtime_get_sync()` is ignored in `analogi=
x_dp_set_bridge()`, potentially leading to hardware access on a suspended d=
evice.
- [High] Sleeping in atomic context via `usleep_range()` in bridge atomic e=
nable callback.
- [High] Memory leak and list corruption due to `devm_drm_bridge_add` in co=
mponent bind.
--

--- Patch [1]: [PATCH v2 01/10] drm/bridge: analogix_dp: Manage pm runtime =
and IRQ for native HPD pin detection ---
commit c884a0bafddd9bc289fdebe294b1a5fb1f401308
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Manage pm runtime and IRQ for native HPD pin detec=
tion

This commit modifies the Analogix DP driver to keep the native HPD pin
IRQ active while the display is disabled on Rockchip platforms. It splits
the IRQ management paths so that native HPD pin mode holds a runtime PM
power reference and enables the IRQ during bind/unbind, rather than during
bridge enable/disable.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 30c0c0b41d5aa..9f8544d3c8870 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c

[ ... ]

> @@ -1018,7 +1024,8 @@ static int analogix_dp_set_bridge(struct analogix_d=
p_device *dp)
>  		goto out_dp_init;
>  	}
> =20
> -	enable_irq(dp->irq);
> +	if (!analogix_dp_require_pm_for_hpd_irq(dp))
> +		enable_irq(dp->irq);

[Severity: High]
This is a pre-existing issue, but does this code ignore the return value of
pm_runtime_get_sync()?

If pm_runtime_get_sync(dp->dev) fails earlier in analogix_dp_set_bridge()
and returns a negative error code, the device remains suspended. The driver
subsequently calls analogix_dp_init_analog_func(), which accesses hardware
registers on the unpowered device.

>  	return 0;
> =20
>  out_dp_init:

[ ... ]

> @@ -1160,7 +1167,8 @@ static void analogix_dp_bridge_disable(struct drm_b=
ridge *bridge)
>  	if (dp->dpms_mode !=3D DRM_MODE_DPMS_ON)
>  		return;
> =20
> -	disable_irq(dp->irq);
> +	if (!analogix_dp_require_pm_for_hpd_irq(dp))
> +		disable_irq(dp->irq);

[Severity: High]
Does skipping disable_irq() here leave the DP controller IRQ enabled during
system suspend?

During dpm_suspend, pm_runtime_force_suspend() runs and calls
analogix_dp_suspend(), which disables the DP clock. Device IRQs are not
disabled by the IRQ core until dpm_suspend_noirq().

If a hotplug event occurs in this window, the active IRQ triggers the handl=
er:

analogix_dp_hardirq() {
    irq_type =3D analogix_dp_get_irq_type(dp);
    ...
}

This reads MMIO registers while the DP clock is disabled, which can crash
the system.

> =20
>  	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);

[ ... ]

> @@ -1508,6 +1516,14 @@ int analogix_dp_bind(struct analogix_dp_device *dp=
, struct drm_device *drm_dev)
>  		goto err_unregister_aux;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but does using devm_drm_bridge_add() earlier
in this component bind callback cause a memory leak and list corruption
on failure?

If the component bind fails and is retried, the devm resources are tied to
the physical platform device and are not freed between attempts. The retry
will call devm_drm_bridge_add() on the same dp->bridge object again,
causing list_add() on a node that is already part of the global bridge list.

> +	if (analogix_dp_require_pm_for_hpd_irq(dp)) {
> +		ret =3D pm_runtime_resume_and_get(dp->dev);
> +		if (ret)
> +			goto err_unregister_aux;
> +
> +		enable_irq(dp->irq);

[Severity: High]
Does this code leak the PM reference and leave the IRQ enabled if a subsequ=
ent
setup step fails?

If the platform caller rockchip_dp_bind() fails at
drm_bridge_connector_init() after analogix_dp_bind() succeeds, its error
path is:

rockchip_dp_bind() {
    ...
err_cleanup_encoder:
    dp->encoder.encoder.funcs->destroy(&dp->encoder.encoder);
    return ret;
}

Because analogix_dp_unbind() is not called in this error path, the PM
reference is permanently leaked and the IRQ remains enabled. When the IRQ
fires later, analogix_dp_irq_thread() dereferences the stale dp->drm_dev
pointer.

> +	}
> +
>  	return 0;
> =20
>  err_unregister_aux:

[ ... ]

[Severity: High]
This is a pre-existing issue, but does analogix_dp_bridge_atomic_enable()
sleep in atomic context?

analogix_dp_bridge_atomic_enable() is called during the atomic commit seque=
nce
from drm_atomic_helper_commit_tail(). The driver explicitly calls
usleep_range(10, 11) in a loop:

analogix_dp_bridge_atomic_enable() {
    ...
    while (timeout_loop < MAX_PLL_LOCK_LOOP) {
        if (analogix_dp_set_bridge(dp) =3D=3D 0) {
            ...
        }
        ...
        usleep_range(10, 11);
    }
}

Calling sleeping functions in this atomic context violates DRM subsystem ru=
les.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804081717.7414=
04-1-damon.ding@rock-chips.com?part=3D1
