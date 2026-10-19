Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82285CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD2B10E8ED;
	Mon, 19 Oct 2026 09:17:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1ACC10E8ED
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:17:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AEE3740238;
 Mon, 19 Oct 2026 09:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C751F000C4;
 Mon, 19 Oct 2026 09:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792401435;
 bh=OzfJDn2KaKyQ8l3vyKJL5ST5w+5qwv/LA2+A8h6Ytsk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RvK3VnrbF2vJuS+aDZTZMxrlR4NucdRq7iZxwBUJVxn8ImII6Oxy8RGIL88ChYLOn
 7lDf90WuHXl27uCxqCa1uaHI7hCB4/jfz5fUK6QmC9Xh0QNnvlZU36pwhQzLEKQnjM
 3oawHuLw4v2wYbZvHpeUs0HUWC8dcWtjgnDRY3BAEtrpaZmrXn1+4nwhptrcK7lNGM
 NAsWmp9REIF+eZHz4YSx/RyyVykZOl696/NFCrAKNP6Rz/UrWAKkvxLXa4Wxi1ubwp
 hxV8tjitxHAmt8stUyQkDnViaBGNw3aazBi4fGEi5m2J1AkgPow3U6p8DP8YoOe+k+
 +pu4e+4Wd/Ptw==
Message-ID: <sashiko-outbox-176888@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/14] drm/bridge: analogix_dp: Move IRQ
 enable/disable to bind/unbind
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019085836.3065008-10-damon.ding@rock-chips.com>
References: <20261019085836.3065008-1-damon.ding@rock-chips.com>
 <20261019085836.3065008-10-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:17:15 +0000
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
- [High] drm/bridge: analogix_dp: unclocked IRQ MMIO after moving enable_ir=
q() to bind
- [High] drm/bridge: analogix_dp: IRQ left enabled with dangling drm_dev on=
 bind failure
--

commit f05b45f646c93eccaff985e6b484d109024db4f2
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Move IRQ enable/disable to bind/unbind

This commit moves enable_irq() and disable_irq() from the bridge enable
and disable handlers into analogix_dp_bind() and analogix_dp_unbind() so
that the IRQ remains active across the bound lifetime of the bridge.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index b92d285461926..addd319719de4 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1018,7 +1018,6 @@ static int analogix_dp_set_bridge(struct analogix_d=
p_device *dp)
>  		goto out_dp_init;
>  	}
> =20
> -	enable_irq(dp->irq);
>  	return 0;
> =20
>  out_dp_init:
> @@ -1160,8 +1159,6 @@ static void analogix_dp_bridge_disable(struct drm_b=
ridge *bridge)
>  	if (dp->dpms_mode !=3D DRM_MODE_DPMS_ON)
>  		return;
> =20
> -	disable_irq(dp->irq);
> -
>  	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
> =20
>  	pm_runtime_put_sync(dp->dev);

[Severity: High]
Can removing disable_irq(dp->irq) before pm_runtime_put_sync(dp->dev) allow
analogix_dp_hardirq() or analogix_dp_irq_thread() to perform MMIO accesses =
on
dp->reg_base after analogix_dp_suspend() has gated the clocks?

Previously, disable_irq(dp->irq) synchronized any in-flight hardirq or
scheduled threaded handler before pm_runtime_put_sync(dp->dev) ran
analogix_dp_suspend():

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_suspend() {
	phy_power_off(dp->phy);

	if (dp->plat_data->power_off)
		dp->plat_data->power_off(dp->plat_data);

	clk_disable_unprepare(dp->clock);

	return 0;
}

In native HPD configurations (!dp->hpd_gpiod), analogix_dp_resume() ->
analogix_dp_init_dp() -> analogix_dp_config_interrupt() unmasks HPD
interrupts in the controller registers. If an HPD interrupt fires shortly
before runtime suspend (for example, right before analogix_dp_bridge_disabl=
e(),
before the out_dp_init error path in analogix_dp_set_bridge(), or when the
autosuspend timer expires after analogix_dpaux_transfer()),
analogix_dp_hardirq() returns IRQ_WAKE_THREAD without holding a runtime PM
reference.

If analogix_dp_suspend() then gates dp->pclk and dp->clock before
analogix_dp_irq_thread() runs, analogix_dp_irq_thread() will access
ANALOGIX_DP_COMMON_INT_STA_4 and ANALOGIX_DP_INT_STA while the controller is
unclocked:

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_irq_thread()=
 {
	...
	irq_type =3D analogix_dp_get_irq_type(dp);
	if (!dp->hpd_gpiod && irq_type)
		analogix_dp_clear_hotplug_interrupts(dp, irq_type);
	...
}

Even with the later patches in this series ("drm/bridge: analogix_dp: Manage
pm runtime and IRQ for native HPD pin detection" and "drm/bridge: analogix_=
dp:
Handle HPD notification from downstream bridge"),
analogix_dp_require_pm_for_hpd_irq() only keeps runtime PM active during bi=
nd
for Rockchip when !dp->hpd_gpiod && !dp->force_hpd && !dp->hpd_notify_mode.
Exynos native-HPD boards (EXYNOS_DP with !dp->hpd_gpiod) and Rockchip
force-hpd boards (!dp->hpd_gpiod && dp->force_hpd, where
analogix_dp_config_interrupt() still unmutes DP_IRQ_TYPE_HP_CHANGE and
analogix_dp_force_hpd() toggles HPD_STATUS) can still runtime-suspend with
dp->irq enabled and unsynchronized.

> @@ -1574,6 +1571,8 @@ int analogix_dp_bind(struct analogix_dp_device *dp,=
 struct drm_device *drm_dev)
>  		goto err_unregister_aux;
>  	}
> =20
> +	enable_irq(dp->irq);
> +
>  	return 0;

[Severity: High]
What happens if a caller of analogix_dp_bind() fails after analogix_dp_bind=
()
returns 0?

Both rockchip_dp_bind() and exynos_dp_bind() call drm_bridge_connector_init=
()
immediately after analogix_dp_bind(), and neither calls analogix_dp_unbind()
if drm_bridge_connector_init() fails:

drivers/gpu/drm/rockchip/analogix_dp-rockchip.c:rockchip_dp_bind() {
	...
	ret =3D analogix_dp_bind(dp->adp, drm_dev);
	if (ret)
		goto err_cleanup_encoder;

	connector =3D drm_bridge_connector_init(dp->drm_dev, dp->plat_data.encoder=
);
	if (IS_ERR(connector)) {
		ret =3D PTR_ERR(connector);
		dev_err(dp->dev, "Failed to initialize bridge_connector\n");
		goto err_cleanup_encoder;
	}

	return 0;
err_cleanup_encoder:
	dp->encoder.encoder.funcs->destroy(&dp->encoder.encoder);
	return ret;
}

drivers/gpu/drm/exynos/exynos_dp.c:exynos_dp_bind() {
	...
	ret =3D analogix_dp_bind(dp->adp, dp->drm_dev);
	if (ret) {
		dp->encoder.funcs->destroy(&dp->encoder);
		return ret;
	}

	connector =3D drm_bridge_connector_init(dp->drm_dev, dp->plat_data.encoder=
);
	if (IS_ERR(connector)) {
		ret =3D PTR_ERR(connector);
		dev_err(dp->dev, "Failed to initialize bridge_connector\n");
		return ret;
	}
	...
}

Because component_bind_all() only unbinds previously bound components when a
component's bind callback fails, the master bind path frees drm_dev via
drm_dev_put() while dp->irq remains enabled and dp->drm_dev still points to
the freed drm_device (and in the follow-up commit "drm/bridge: analogix_dp:
Manage pm runtime and IRQ for native HPD pin detection", runtime PM also
remains active).

If an HPD interrupt fires afterwards, wouldn't analogix_dp_irq_thread() pass
the freed dp->drm_dev pointer to drm_helper_hpd_irq_event()?

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_irq_thread()=
 {
	...
	if (hpd_detected) {
		dev_dbg(dp->dev, "Detected cable status changed!\n");
		if (dp->drm_dev)
			drm_helper_hpd_irq_event(dp->drm_dev);
	}
	...
}

[ ... ]

>
>=20
>=20
>

=E5=AE=8C=E7=BE=8E=E3=80=82

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019085836.3065=
008-1-damon.ding@rock-chips.com?part=3D9
