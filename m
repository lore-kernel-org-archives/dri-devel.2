Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E849FC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 578E810E3B3;
	Tue, 21 Jul 2026 18:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F7WisUlj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B6B710E3B3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:16:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E7B5A435BD;
 Tue, 21 Jul 2026 18:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C871F00A3D;
 Tue, 21 Jul 2026 18:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784657806;
 bh=1TO52dJI0tUVixJ8kT1TbaztNmWdQqJaXVom3MIpsDg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F7WisUljD6EQj0A+WS/IvrK4sCpQGEuPpdyCZXNy9npIUG727reKDBbnNCyIMhxMJ
 5SRuZpIvFUu7CMy0bszU6Vj5cagZjFxeFDW/WBG/yJJtjIVazzF7yPRdW8ukTVS7ka
 55h/CBfd/b/CWoVzHsepTQYUwuKA1mBnSu9+zslzTW37A7TGqYOz3yZLu9l8S49Zct
 MDCSGb/528lBsGuWNJL8wluP3BDajoifQuttsyrJ1z4b0lZoA+ZTlz4x6FUxhbljNE
 DAYJgUWD+k9YPXFM4SgIyz2LWFV92C9nwO0LOJ+gatT6EiplRGcD3HJGJFnWwInOdE
 F2UbAzzo+qtRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/10] drm/bridge: synopsys: dw-dp: Add Runtime PM
 support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260721-synopsys-dw-dp-improvements-v4-7-f0f4a4ede712@collabora.com>
References: <20260721-synopsys-dw-dp-improvements-v4-0-f0f4a4ede712@collabora.com>
 <20260721-synopsys-dw-dp-improvements-v4-7-f0f4a4ede712@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 18:16:46 +0000
Message-Id: <20260721181646.86C871F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:

New issues:
- [High] Inverted boolean condition in `dw_dp_unbind()` causes runtime PM u=
sage count leak and unbalanced puts.
- [High] Missing API return value check for `pm_runtime_get_sync()` causes =
unsafe hardware access on failure.
- [High] Sleeping function `pm_runtime_get_sync()` called from atomic conte=
xt.
- [High] Missing runtime PM reference release on error path in `dw_dp_bind(=
)`.
- [High] Asynchronous `pm_runtime_put_autosuspend()` is incorrectly used in=
 the teardown path.
- [High] Clock disable imbalance between `devm_clk_get_enabled()` and expli=
cit `clk_disable_unprepare()` in runtime suspend.
- [Medium] Unconditional sleep in `dw_dp_bridge_detect()` causes severe per=
formance degradation during display polling.

Pre-existing issues:
- [Critical] Use-After-Free due to missing cancellation of `hpd_work` in te=
ardown.
- [High] Preexisting atomic context violation in `dw_dp_bridge_atomic_disab=
le()`.
--

--- Patch [7]: [PATCH v4 07/10] drm/bridge: synopsys: dw-dp: Add Runtime PM=
 support ---
commit e300d93b1e1336324cbbd71c5f0b1b81334c7912
Author: Sebastian Reichel <sebastian.reichel@collabora.com>
Date:   Tue Jul 21 17:52:37 2026 +0000

    drm/bridge: synopsys: dw-dp: Add Runtime PM support
   =20
    Add runtime PM stubs to the Synopsys DesignWare DisplayPort bridge
    driver. Support is not enabled automatically and must be hooked up
    in the vendor specific glue code.
   =20
    Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 8eb2699dc7ab0..636b9e1052978 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -1467,6 +1468,8 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux=
 *aux,
>  	if (WARN_ON(msg->size > 16))
>  		return -E2BIG;
> =20
> +	ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
> +

[Severity: High]
Does the ACQUIRE macro wrapper silently ignore the return value of the
underlying get_sync operation?

If the device fails to power on or clock enablement fails, the driver might
proceed to access hardware registers anyway. Could we handle the error here=
=20
and abort the transfer instead of proceeding?

>  	switch (msg->request & ~DP_AUX_I2C_MOT) {
>  	case DP_AUX_NATIVE_WRITE:
>  	case DP_AUX_I2C_WRITE:

[ ... ]

> @@ -1657,6 +1660,8 @@ static void dw_dp_bridge_atomic_enable(struct drm_b=
ridge *bridge,
>  	struct drm_connector_state *conn_state;
>  	int ret;
> =20
> +	pm_runtime_get_sync(dp->dev);
> +

[Severity: High]
Are we allowed to call a sleeping function from atomic context here?

The dw_dp_bridge_atomic_enable() callback executes in atomic context where
sleeping is forbidden. However, pm_runtime_get_sync() triggers
dw_dp_runtime_resume(), which calls clk_prepare_enable() and sleeps.

Also, similar to the ACQUIRE wrapper above, the return value of
pm_runtime_get_sync() is ignored here. If it fails, will the driver proceed
to access hardware registers while the device is unclocked?

>  	connector =3D drm_atomic_get_new_connector_for_encoder(state, bridge->e=
ncoder);
>  	if (!connector) {
>  		dev_err(dp->dev, "failed to get connector\n");

[ ... ]

> @@ -1711,6 +1716,7 @@ static void dw_dp_bridge_atomic_disable(struct drm_=
bridge *bridge,
>  	dw_dp_link_disable(dp);
>  	bitmap_zero(dp->sdp_reg_bank, SDP_REG_BANK_SIZE);
>  	dw_dp_reset(dp);
> +	pm_runtime_put_autosuspend(dp->dev);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does dw_dp_reset() sleep ins=
ide
an atomic context?

The dw_dp_bridge_atomic_disable() callback runs in atomic context, but
dw_dp_reset() unconditionally calls usleep_range() and
regmap_read_poll_timeout(). Should this hardware reset sequence be moved out
of the atomic path or use non-sleeping delays?

>  static bool dw_dp_hpd_detect_link(struct dw_dp *dp, struct drm_connector=
 *connector)
> @@ -1731,6 +1737,14 @@ static enum drm_connector_status dw_dp_bridge_dete=
ct(struct drm_bridge *bridge,
>  {
>  	struct dw_dp *dp =3D bridge_to_dp(bridge);
> =20
> +	ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
> +
> +	/*
> +	 * HPD_HOT_PLUG bit is asserted only after the sink holds HPD high for
> +	 * at least 100ms. Thus we need to wait 100ms after runtime PM resume.
> +	 */
> +	msleep(110);
> +

[Severity: Medium]
Will this sleep degrade display polling performance?

By using the ACQUIRE wrapper, the return value of pm_runtime_get_sync() is
discarded, making it impossible to differentiate a fresh resume (returning =
0)
from an already-active device (returning 1).

As a result, this 110ms sleep executes unconditionally on every detect call,
even when the device is already active (such as in native DP mode where it =
is
kept active permanently).

>  	if (!dw_dp_hpd_detect(dp))
>  		return connector_status_disconnected;
> =20

[ ... ]

> @@ -2032,10 +2046,15 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encod=
er *encoder)
>  	}
> =20
>  	if (dw_dp_is_routed_to_usb_c(encoder)) {
> +		dp->usbc_mode =3D true;
>  		dev_dbg(dev, "USB-C mode\n");
> =20
>  		if (dp->plat_data.hpd_sw_sel)
>  			dp->plat_data.hpd_sw_sel(dp->plat_data.data, 1);
> +	} else {
> +		dp->usbc_mode =3D false;
> +		/* Keep runtime PM enabled to have working native HPD IRQ */
> +		pm_runtime_get_sync(dp->dev);
>  	}
> =20
>  	dw_dp_init_hw(dp);

[Severity: High]
Does the error path for hardware initialization following this block leak t=
he
runtime PM reference?

If dp->usbc_mode is false, pm_runtime_get_sync() increments the usage count.
If phy_init() fails shortly after dw_dp_init_hw(), the function jumps to the
err_put_next_bridge label and returns without balancing this get_sync
operation, causing the PM reference to permanently leak.

> @@ -2065,6 +2084,8 @@ EXPORT_SYMBOL_GPL(dw_dp_bind);
> =20
>  void dw_dp_unbind(struct dw_dp *dp)
>  {
> +	if (dp->usbc_mode)
> +		pm_runtime_put_autosuspend(dp->dev);

[Severity: High]
Is this boolean condition inverted?

In dw_dp_bind(), pm_runtime_get_sync() is called when usbc_mode is false.
By checking for true here, we call put on a reference we never acquired
(causing an underflow/warning for USB-C) and leak the reference when native=
 DP
mode is used.

[Severity: High]
Is it safe to use the asynchronous pm_runtime_put_autosuspend() variant in a
teardown path?

When device removal or pm_runtime_disable() follows immediately, the pending
async idle/suspend work can be cancelled by the PM core. This could leave t=
he
hardware active indefinitely. Should a synchronous pm_runtime_put_sync() be
used here instead?

>  	disable_irq(dp->irq);

[Severity: Critical]
This is a pre-existing issue, but is there a use-after-free risk because
hpd_work is not canceled?

The hpd_work struct is allocated via devm_kzalloc. In this teardown path, t=
he
IRQ is disabled, but cancel_work_sync(&dp->hpd_work) is never called. If the
work was scheduled by an interrupt just before disable_irq(), the work queue
thread could execute after the devm subsystem frees the memory.

>  	phy_exit(dp->phy);
>  	drm_bridge_put(dp->next_bridge);

[ ... ]

> @@ -2163,6 +2184,35 @@ struct dw_dp *dw_dp_probe(struct platform_device *=
pdev, const struct dw_dp_plat_
>  }
>  EXPORT_SYMBOL_GPL(dw_dp_probe);
> =20
> +int dw_dp_runtime_suspend(struct dw_dp *dp)
> +{
> +	clk_disable_unprepare(dp->aux_clk);
> +	clk_disable_unprepare(dp->apb_clk);
> +
> +	return 0;
> +}

[Severity: High]
Will manually disabling these clocks here cause an imbalance on device tear=
down?

If the apb_clk and aux_clk clocks are acquired using devm_clk_get_enabled(),
a cleanup action is registered to call clk_disable_unprepare() upon device
unbind. If the device is runtime suspended when it is unbound, the devm
teardown mechanism will invoke clk_disable_unprepare() again on these
already-disabled clocks, dropping the enable counters below zero.

> +EXPORT_SYMBOL_GPL(dw_dp_runtime_suspend);
> +
> +int dw_dp_runtime_resume(struct dw_dp *dp)
> +{
> +	int ret;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-synopsys-d=
w-dp-improvements-v4-0-f0f4a4ede712@collabora.com?part=3D7
