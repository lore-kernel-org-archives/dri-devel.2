Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE8CC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B8010F245;
	Thu, 23 Jul 2026 22:37:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LYMET7ar";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E32C710F245
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:37:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B4FE600AD;
 Thu, 23 Jul 2026 22:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB791F000E9;
 Thu, 23 Jul 2026 22:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784846251;
 bh=BsLEDEmJfjqeZuBtYN0oVWFbwIraCuCAHzxNFjkOtwo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LYMET7arcF8r3HraVpP/pZ6Xs9MPCh+/idDwKE6HLy305WwMXilFJs82iX57eMqMD
 INh/+Ms4/Gg/v5GutLja9d7knAPH1kLJ/c1+xZC58IDxpWLkUD0JHIQLGIbR5NwKPK
 JPXcPPnQAXrCzZXnGiG85wKTpDqfoct2lkns3zkSwR2H05BxkJ63xH0egka2puqD26
 f8XQ4bmA4QmqKz6X71WpbyAVMG9zpmbPLURQhjJPRVx4JwPcGNTBAs7I3qd+OPMvTx
 ++dMlrkBoZW1TENSdIyYLRbfNCV3mmZObf47K9z0W38+mZKhOKIGvQeBp3YrvrYBiO
 7y81KMri1mJ6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/15] drm/bridge: synopsys: dw-dp: Add Runtime PM
 support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v5-10-9445c2e87441@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v5-0-9445c2e87441@collabora.com>
 <20260724-synopsys-dw-dp-improvements-v5-10-9445c2e87441@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:37:30 +0000
Message-Id: <20260723223731.6BB791F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Optional runtime PM support breaks the driver when runtime PM is n=
ot enabled by the vendor glue code.
- [High] Using devm_clk_get_enabled() alongside manual clock disable in run=
time suspend causes a clock enable count imbalance.
- [High] Missing error check for pm_runtime_get_sync() in dw_dp_bridge_atom=
ic_enable() leads to unclocked register access.
- [High] Hardware registers are accessed without acquiring a PM reference i=
n USB-C mode during bind.
- [High] Inverted teardown order in dw_dp_unbind() drops the runtime PM ref=
erence before disabling IRQs and pending work.
- [High] Calling pm_runtime_get_sync() inside dw_dp_bridge_atomic_enable() =
introduces a sleeping function into an atomic context.
- [High] dw_dp_hpd_work accesses hardware registers without a PM reference,=
 risking a crash if the device is suspended.
--

--- Patch [10]: [PATCH v5 10/15] drm/bridge: synopsys: dw-dp: Add Runtime P=
M support ---
commit 68cdca52c26d611b36038053d2dc6f02f519e36d
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add Runtime PM support

This commit adds runtime PM stubs to the Synopsys DesignWare DisplayPort
bridge driver. Support is conditionally enabled based on the vendor specific
glue code hooking it up.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 9975df8ea37e1..bcf7ad84f2178 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
[ ... ]
> @@ -1467,6 +1468,11 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_au=
x *aux,
>  	if (WARN_ON(msg->size > 16))
>  		return -E2BIG;
> =20
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dp->dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +

[Severity: High]
Does this cause the AUX transfer to unconditionally fail on platforms that =
do
not enable runtime PM?

The commit message states that runtime PM "must be hooked up in the vendor
specific glue code". However, PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND
internally uses pm_runtime_resume_and_get(), which returns -EACCES when
runtime PM is disabled. Could this cause dw_dp_aux_transfer() to abort
early on platforms where the vendor glue code does not enable PM?

>  	switch (msg->request & ~DP_AUX_I2C_MOT) {
>  	case DP_AUX_NATIVE_WRITE:
>  	case DP_AUX_I2C_WRITE:
[ ... ]
> @@ -1720,6 +1726,8 @@ static void dw_dp_bridge_atomic_enable(struct drm_b=
ridge *bridge,
>  	struct drm_connector_state *conn_state;
>  	int ret;
> =20
> +	pm_runtime_get_sync(dp->dev);
> +

[Severity: High]
Should the return value of pm_runtime_get_sync() be checked here?

If the device fails to resume, execution proceeds into dw_dp_link_enable()
and dw_dp_video_enable(). Could this lead to asynchronous external aborts
from accessing unclocked hardware registers?

[Severity: High]
Is it safe to call pm_runtime_get_sync() from this atomic context?

DRM guidelines indicate that encoder and bridge atomic enable callbacks run
in atomic context during non-blocking commits where sleeping is forbidden.
Since pm_runtime_get_sync() can sleep, and the newly added
dw_dp_runtime_resume() explicitly calls msleep(), could this cause kernel
warnings or deadlocks during atomic commits?

>  	connector =3D drm_atomic_get_new_connector_for_encoder(state, bridge->e=
ncoder);
>  	if (!connector) {
>  		dev_err(dp->dev, "failed to get connector\n");
[ ... ]
> @@ -1973,10 +1986,17 @@ static irqreturn_t dw_dp_irq(int irq, void *data)
>  {
>  	struct dw_dp *dp =3D data;
>  	u32 value;
> +	int ret;
> +
> +	ret =3D pm_runtime_get_if_active(dp->dev);
> +	if (ret <=3D 0)
> +		return IRQ_NONE;

[Severity: High]
Could this silently drop all valid interrupts when runtime PM is disabled?

When runtime PM is not enabled by the vendor glue code,
pm_runtime_get_if_active() returns -EINVAL (which is <=3D 0). Does this cau=
se
the IRQ handler to always return IRQ_NONE without processing the interrupt?

[Severity: High]
Is a PM reference required for the HPD work scheduled by the IRQ handler?

When the HPD event schedules dw_dp_hpd_work(), the work executes
dw_dp_link_retrain() and accesses hardware registers like DW_DP_CCTL.
Since the work item doesn't acquire a PM reference itself, could it crash by
accessing unclocked registers if the device autosuspends before or during t=
he
work execution?

> =20
>  	regmap_read(dp->regmap, DW_DP_GENERAL_INTERRUPT, &value);
> -	if (!value)
> +	if (!value) {
> +		pm_runtime_put_autosuspend(dp->dev);
>  		return IRQ_NONE;
> +	}
> =20
>  	if (value & HPD_EVENT)
>  		dw_dp_handle_hpd_event(dp);
[ ... ]
> @@ -2073,10 +2094,15 @@ int dw_dp_bind(struct dw_dp *dp, struct drm_encod=
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
Does dw_dp_init_hw() need a PM reference when in USB-C mode?

If usbc_mode is true, pm_runtime_get_sync() is skipped. However,
dw_dp_init_hw() is called immediately after, which writes to hardware
registers. If the device happens to be runtime suspended, could this
unclocked hardware access crash the system?

[ ... ]
> @@ -2106,6 +2136,8 @@ EXPORT_SYMBOL_GPL(dw_dp_bind);
> =20
>  void dw_dp_unbind(struct dw_dp *dp)
>  {
> +	if (!dp->usbc_mode)
> +		pm_runtime_put_sync(dp->dev);
>  	disable_irq(dp->irq);
>  	cancel_work_sync(&dp->hpd_work);
>  	phy_exit(dp->phy);

[Severity: High]
Should the runtime PM reference be held until the teardown is complete?

By calling pm_runtime_put_sync() before disable_irq(), cancel_work_sync(),
and phy_exit(), the device is suspended and its clocks are turned off.
If an HPD interrupt fires before disable_irq(), could it cause an IRQ storm
since the suspended hardware won't allow the interrupt to be cleared?
Additionally, could phy_exit() crash if executed on a suspended device?

[ ... ]
> @@ -2208,6 +2240,41 @@ struct dw_dp *dw_dp_probe(struct platform_device *=
pdev, const struct dw_dp_plat_
>  }
>  EXPORT_SYMBOL_GPL(dw_dp_probe);
> =20
> +int dw_dp_runtime_suspend(struct dw_dp *dp)
> +{
> +	clk_disable_unprepare(dp->aux_clk);
> +	clk_disable_unprepare(dp->apb_clk);
> +

[Severity: High]
Does manually disabling these clocks conflict with devres?

The apb_clk and aux_clk are acquired using devm_clk_get_enabled() during
probe, which registers a cleanup action to automatically disable them on
device removal. If dw_dp_runtime_suspend() manually disables them, could
the devres cleanup attempt to disable them a second time on driver unbind,
causing a clock enable count underflow?

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_dp_runtime_suspend);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-synopsys-d=
w-dp-improvements-v5-0-9445c2e87441@collabora.com?part=3D10
