Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8874606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWsCHfCN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26AF410ED35;
	Sat, 14 Nov 2026 05:34:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 079A610ED35
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:34:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 01869609EF;
 Sat, 14 Nov 2026 05:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6501F000C4;
 Sat, 14 Nov 2026 05:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794634444;
 bh=5RWjxlez+SdNY68QogumKmYIlvgl9qBwgNpY/i3hIAA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UWsCHfCNkG/wBjWbvdy9DYAaASbMGWYC6l/1q2266SwE6fURD4Qf85t/34SmvaPIF
 XEXY0cRopQKMGxkKOGYEypOodfaMwJO35oE9xntz346C+EYQvn3UBvgJfW5vTzFGdG
 b2Dh4AniH4rq5irarS8zSDB60wf0PwokJsj2GqtQMMYGcAh6m622uuyLNeNrjMSry7
 NO3vVnXAiJPiziIpYrjjhZcstjLmb/c0QEWgNbHFNO4IZ7nVY+t0vGbWU2xgzCM7yV
 ux+3nqlpBnaxnGZXgCjOUnVOk5mPVKieGI6DZXKQnxFey5zO3+resO6Nj+Ao7UzU6R
 Ak5yr7To320NQ==
Message-ID: <sashiko-outbox-214181@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 14/23] drm/bridge: synopsys: dw-dp: Add Runtime PM
 support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261114-synopsys-dw-dp-improvements-v12-14-d42d3dc5bdd4@collabora.com>
References: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
 <20261114-synopsys-dw-dp-improvements-v12-14-d42d3dc5bdd4@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 05:34:04 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/bridge: dw-dp: missing runtime PM acquire in
  dw_dp_bridge_edid_read()
- [High] drm/bridge: dw-dp: spurious HPD_HOT_PLUG IRQ in
  dw_dp_runtime_resume()
- [High] drm/bridge: dw-dp: missing HPD debounce wait in
  dw_dp_bridge_oob_notify()
- [Medium] drm/bridge: dw-dp: unbalanced IRQ enable and clock leak on
  teardown
--

commit 26edd6f6880ea763bab6673f7b28388080118df0
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add Runtime PM support

This commit adds runtime PM support to the Synopsys DesignWare DisplayPort
bridge driver and splits dw_dp_alloc() out of dw_dp_probe() so platform
drivers can wire up runtime PM callbacks before probing completes.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index b4eed4d0a5205..4d61ca8f0174c 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -1755,6 +1775,10 @@ static enum drm_connector_status dw_dp_bridge_dete=
ct(struct drm_bridge *bridge,
>  {
>  	struct dw_dp *dp =3D bridge_to_dp(bridge);
> =20
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dp->dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
> +		return connector_status_disconnected;
> +
>  	if (!dw_dp_hpd_detect(dp))
>  		return connector_status_disconnected;
> =20

[Severity: High]
Does dw_dp_bridge_edid_read() also need PM_RUNTIME_ACQUIRE_AUTOSUSPEND()
before calling phy_power_on(dp->phy)?

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_bridge_edid_read() {
	ret =3D phy_power_on(dp->phy);
	if (ret)
		return NULL;

	edid =3D drm_edid_read_ddc(connector, &dp->aux.ddc);

	phy_power_off(dp->phy);
}

In USB-C mode, if dp->dev is runtime-suspended when userspace reads the EDID
(for example, if autosuspend expires between .detect() and .edid_read(), or
when connector status is forced), phy_power_on(dp->phy) runs while the DP
controller power domain is off.  On Rockchip RK3588/RK3576,
rk_udphy_dp_phy_power_on() -> rk_udphy_dp_lane_select() writes to vo-grf,
which lives in the DP controller's power domain; accessing it while powered
off triggers an ARM64 SError crash, and even without a fault, powering on t=
he
domain later inside dw_dp_aux_transfer() resets vo-grf and loses the lane a=
nd
AUX configuration set by phy_power_on().

[ ... ]

> @@ -1949,12 +1987,20 @@ static void dw_dp_bridge_oob_notify(struct drm_br=
idge *bridge,
>  {
>  	bool hpd_high =3D status !=3D connector_status_disconnected;
>  	struct dw_dp *dp =3D bridge_to_dp(bridge);
> +	int ret;
> +
> +	dp->usbc_hpd =3D hpd_high;
> =20
>  	if (!dp->plat_data.hpd_sw_cfg) {
>  		dev_err_once(dp->dev, "Missing platform handler for OOB HPD handling\n=
");
>  		return;
>  	}
> =20
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dp->dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return;
> +
>  	dev_dbg(dp->dev, "Force HPD connected=3D%s\n", str_yes_no(hpd_high));
>  	dp->plat_data.hpd_sw_cfg(dp->plat_data.data, hpd_high);
>  }

[Severity: High]
When dp->dev is already runtime-active (such as when runtime PM is not
enabled, or before autosuspend expires), PM_RUNTIME_ACQUIRE_AUTOSUSPEND()
does not run dw_dp_runtime_resume(), so dw_dp_bridge_oob_notify() returns
immediately after asserting hpd_sw_cfg() without waiting 100ms for the
controller to debounce HPD.

Its caller drm_bridge_connector_oob_hotplug_event() immediately runs
dw_dp_bridge_detect() -> dw_dp_hpd_detect(), which reads HPD_STATE before t=
he
100ms hardware debounce completes and falsely reports
connector_status_disconnected.  Also, when dp->dev was suspended,
dw_dp_runtime_resume() sleeps 110ms unconditionally even when HPD is low and
calls hpd_sw_cfg() a second time.

[ ... ]

> @@ -2208,39 +2283,67 @@ struct dw_dp *dw_dp_probe(struct platform_device =
*pdev, const struct dw_dp_plat_
>  	dp->rstc =3D devm_reset_control_get(dev, NULL);
>  	if (IS_ERR(dp->rstc)) {
>  		dev_err_probe(dev, PTR_ERR(dp->rstc), "failed to get reset control\n");
> -		return ERR_CAST(dp->rstc);
> +		return PTR_ERR(dp->rstc);
>  	}
> =20
>  	dp->irq =3D platform_get_irq(pdev, 0);
>  	if (dp->irq < 0)
> -		return ERR_PTR(dp->irq);
> +		return dp->irq;
> =20
>  	ret =3D devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
>  					IRQF_ONESHOT | IRQF_NO_AUTOEN, dev_name(dev), dp);
>  	if (ret)
> -		return ERR_PTR(ret);
> +		return ret;
> +
> +	/*
> +	 * Disable IRQ a second time; this ensures the interrupt is only
> +	 * enabled when the bridge is attached AND runtime PM is enabled.
> +	 * Also register a devm action to restore the correct balance during
> +	 * device removal.
> +	 */
> +	disable_irq(dp->irq);
> +
> +	ret =3D devm_add_action_or_reset(dev, dw_dp_enable_irq, dp);
> +	if (ret)
> +		return ret;
> =20
>  	dp->next_bridge =3D of_drm_get_bridge_by_endpoint(dev->of_node, 1, 0);
>  	if (IS_ERR(dp->next_bridge)) {
>  		dev_err_probe(dev, PTR_ERR(dp->next_bridge), "failed to get follow-up =
bridge\n");
> -		return ERR_CAST(dp->next_bridge);
> +		return PTR_ERR(dp->next_bridge);
>  	}
> =20
>  	ret =3D devm_add_action_or_reset(dev, dw_dp_put_next_bridge, dp);
>  	if (ret)
> -		return ERR_PTR(ret);
> +		return ret;
> =20
> -	dw_dp_init_hw(dp);
> +	if (dp->plat_data.autosuspend_delay > 0) {
> +		pm_runtime_use_autosuspend(dev);
> +		pm_runtime_set_autosuspend_delay(dev, dp->plat_data.autosuspend_delay);
> +		ret =3D devm_pm_runtime_enable(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!pm_runtime_enabled(dev)) {
> +		ret =3D dw_dp_runtime_resume(dp);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D devm_add_action_or_reset(dev, dw_dp_manual_suspend, dp);
> +		if (ret)
> +			return ret;
> +	}

[Severity: Medium]
Can device removal with runtime PM enabled skip dw_dp_runtime_suspend(),
leaking clocks and leaving dp->irq enabled during teardown?

When pm_runtime_enabled(dev) is true, devm_pm_runtime_enable() only disables
runtime PM on teardown without calling dw_dp_runtime_suspend() if the device
is still active (for example, when runtime suspend is prevented via sysfs
power/control or an active usage count).  Because dw_dp_manual_suspend() is
only registered when !pm_runtime_enabled(dev), teardown never calls
dw_dp_runtime_suspend(), which leaks the prepared/enabled aux_clk and apb_c=
lk
and leaves dp->irq at disable depth 1 instead of 2 when dw_dp_enable_irq()
runs, unmasking the hardware interrupt line after phy_exit() and
drm_bridge_remove().

>  	ret =3D phy_init(dp->phy);
>  	if (ret) {
>  		dev_err_probe(dev, ret, "phy init failed\n");
> -		return ERR_PTR(ret);
> +		return ret;
>  	}
> =20
>  	ret =3D devm_add_action_or_reset(dev, dw_dp_phy_exit, dp);
>  	if (ret)
> -		return ERR_PTR(ret);
> +		return ret;
> =20
>  	bridge =3D &dp->bridge;
>  	bridge->of_node =3D dev->of_node;
> @@ -2248,13 +2351,53 @@ struct dw_dp *dw_dp_probe(struct platform_device =
*pdev, const struct dw_dp_plat_
>  	bridge->type =3D DRM_MODE_CONNECTOR_DisplayPort;
>  	bridge->ycbcr_420_allowed =3D true;
> =20
> -	ret =3D devm_drm_bridge_add(dev, bridge);
> +	return devm_drm_bridge_add(dev, bridge);
> +}
> +EXPORT_SYMBOL_GPL(dw_dp_probe);
> +
> +int dw_dp_runtime_suspend(struct dw_dp *dp)
> +{
> +	disable_irq(dp->irq);
> +
> +	clk_disable_unprepare(dp->aux_clk);
> +	clk_disable_unprepare(dp->apb_clk);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_dp_runtime_suspend);
> +
> +int dw_dp_runtime_resume(struct dw_dp *dp)
> +{
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(dp->apb_clk);
>  	if (ret)
> -		return ERR_PTR(ret);
> +		return ret;
> =20
> -	return dp;
> +	ret =3D clk_prepare_enable(dp->aux_clk);
> +	if (ret) {
> +		clk_disable_unprepare(dp->apb_clk);
> +		return ret;
> +	}
> +
> +	if (dp->plat_data.hpd_sw_sel)
> +		dp->plat_data.hpd_sw_sel(dp->plat_data.data, dp->usbc_mode);
> +	if (dp->plat_data.hpd_sw_cfg)
> +		dp->plat_data.hpd_sw_cfg(dp->plat_data.data, dp->usbc_hpd);
> +
> +	dw_dp_init_hw(dp);
> +
> +	enable_irq(dp->irq);
> +
> +	/*
> +	 * HPD_HOT_PLUG bit is asserted only after the sink holds HPD
> +	 * high for at least 100ms.
> +	 */
> +	msleep(110);
> +
> +	return 0;
>  }
> -EXPORT_SYMBOL_GPL(dw_dp_probe);
> +EXPORT_SYMBOL_GPL(dw_dp_runtime_resume);

[Severity: High]
Does enabling dp->irq before msleep(110) without clearing HPD_HOT_PLUG fire=
 a
spurious hotplug interrupt on every runtime resume while HPD is high?

Unlike dw_dp_reset(), which keeps dp->irq disabled while waiting for
HPD_HOT_PLUG and clears HPD_HOT_PLUG before calling enable_irq(dp->irq),
dw_dp_runtime_resume() enables HPD interrupts in dw_dp_init_hw(), unmasks
dp->irq, and sleeps 110ms, causing the hardware to assert HPD_HOT_PLUG and
schedule dp->hpd_work on every wakeup while a sink is connected.

When dw_dp_bridge_atomic_enable() resumes dp->dev during a non-blocking
atomic commit, that spurious hpd_work runs concurrently with modeset enable:

CPU0 (commit_work)                CPU1 (hpd_work)
dw_dp_bridge_atomic_enable()
  pm_runtime_get_active()
    dw_dp_runtime_resume()
      ...                         dw_dp_irq() -> schedules hpd_work
  dw_dp_link_enable()
                                  dw_dp_hpd_work()
                                    drm_helper_hpd_irq_event()
                                      dw_dp_bridge_detect()
                                        dw_dp_hpd_detect_link()
                                          dw_dp_link_parse()
                                            dw_dp_link_reset()
                                              link->rate =3D 0
                                              link->lanes =3D 0
                                          phy_power_off(dp->phy)
  dw_dp_video_enable()
    link_bandwidth =3D (rate / 1000) * lanes
    peak_stream_bandwidth * 64 / link_bandwidth  <-- divide by zero

In addition, if dw_dp_hpd_work() itself wakes dp->dev for a short HPD IRQ
(long_hpd =3D=3D false), the spurious HPD_HOT_PLUG during resume overwrites
dp->hotplug.long_hpd =3D true before dw_dp_hpd_work() acquires dp->irq_lock,
dropping the link-retraining request.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-synopsys-d=
w-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com?part=3D14
