Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96678C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD44D10F366;
	Fri, 31 Jul 2026 17:35:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ShrNpN72";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8253B10F366
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 17:35:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B06C16004E;
 Fri, 31 Jul 2026 17:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368EE1F00ADE;
 Fri, 31 Jul 2026 17:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785519325;
 bh=KiIaGOPOF3r2glCxUiNw3aA7EHKRPLfluP6dDKSe0hI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ShrNpN726LbD2xery5N8KGaYFA+K1y3DSKLqin3s6M3cw6xTxle3YfdHAP9UreJMG
 Nzq697Os9TBUmttWEY0mSpTrVI0Hz4CkGNyunYLdd7Q6riCGhD6zB6Hk0ZN4AjRWDc
 BL0rGdzSJYb18foiIXHBwAcevX6tnqVXWD1dP4N6XjkjdaJ1q5owM4kVE54TUnKTzU
 lpc4nFpVcNuugUHyvjXkwAfwlX5evi7S4RxHPh7DAlQDGp+kqGTfq0JTEUFOJukOkX
 sSO51D83tRQaPJ5g3se7mi/B0kr16SQ01jZEBiE0D231MtDgxQzW27R6fTb+NogMTf
 eusQPnDWL4OlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/21] drm/rockchip: dw_dp: Add runtime PM support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260731-synopsys-dw-dp-improvements-v8-15-ac1e6a75782f@collabora.com>
References: <20260731-synopsys-dw-dp-improvements-v8-0-ac1e6a75782f@collabora.com>
 <20260731-synopsys-dw-dp-improvements-v8-15-ac1e6a75782f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 17:35:24 +0000
Message-Id: <20260731173525.368EE1F00ADE@smtp.kernel.org>
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
- [High] Asynchronous runtime PM put operations during device removal and e=
rror paths are cancelled by pm_runtime_disable(), leaving the device perman=
ently powered on.
- [High] The device will remain powered on during system suspend because it=
 uses runtime PM autosuspend without providing system sleep PM operations.
--

--- Patch [15]: [PATCH v8 15/21] drm/rockchip: dw_dp: Add runtime PM suppor=
t ---
commit 7c3ff2ff43dcc0fce64eaf4461fe2a1101bcb4ad
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/rockchip: dw_dp: Add runtime PM support

Add support for runtime PM to the Rockchip RK3576/3588 Synopsys
DesignWare DisplayPort driver.

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index d516b3910b516..dde3881efad84 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
[ ... ]
> @@ -231,16 +232,21 @@ static int dw_dp_rockchip_probe(struct platform_dev=
ice *pdev)
>  	if (IS_ERR(dp->vo_grf))
>  		return PTR_ERR(dp->vo_grf);
> =20
> +	plat_data->autosuspend_delay =3D 500;

[Severity: High]
Does setting autosuspend_delay here expose a resource leak in the core
driver's removal/error paths?

When autosuspend_delay > 0, the core dw-dp driver opts into the shared PM
runtime framework. During device unbind (dw_dp_unbind()) and devm IRQ
cleanup (dw_dp_irq_free()), the core driver releases its PM references
asynchronously using pm_runtime_put_autosuspend().

Immediately afterward, the removal process triggers the devres cleanup for
devm_pm_runtime_enable(), which calls pm_runtime_disable(). As documented
in the PM subsystem guidelines, pm_runtime_disable() invokes
__pm_runtime_barrier(), which flushes and cancels any pending asynchronous
suspend requests. This leaves the DP controller's clocks (apb_clk and
aux_clk) enabled indefinitely.

Should the core driver use synchronous puts (like pm_runtime_put_sync())
before pm_runtime_disable() is called?

>  	plat_data->max_link_rate =3D plat_data_const->max_link_rate;
>  	plat_data->pixel_mode =3D plat_data_const->pixel_mode;
>  	plat_data->hpd_sw_sel =3D dw_dp_rockchip_hpd_sw_sel;
[ ... ]
> @@ -249,6 +255,24 @@ static void dw_dp_rockchip_remove(struct platform_de=
vice *pdev)
>  	component_del(&pdev->dev, &dw_dp_rockchip_component_ops);
>  }
> =20
> +static int dw_dp_rockchip_runtime_suspend(struct device *dev)
> +{
> +	struct rockchip_dw_dp *dp =3D dev_get_drvdata(dev);
> +
> +	return dw_dp_runtime_suspend(dp->base);
> +}
> +
> +static int dw_dp_rockchip_runtime_resume(struct device *dev)
> +{
> +	struct rockchip_dw_dp *dp =3D dev_get_drvdata(dev);
> +
> +	return dw_dp_runtime_resume(dp->base);
> +}
> +
> +static const struct dev_pm_ops dw_dp_pm_ops =3D {
> +	RUNTIME_PM_OPS(dw_dp_rockchip_runtime_suspend, dw_dp_rockchip_runtime_r=
esume, NULL)
> +};

[Severity: High]
Will the device remain powered on during system suspend?

This dev_pm_ops struct defines runtime PM callbacks but omits system sleep
callbacks (like SYSTEM_SLEEP_PM_OPS with pm_runtime_force_suspend).

When the system suspends, the DRM core disables the display, which drops
the runtime PM reference and schedules the 500ms autosuspend timer via
pm_runtime_put_autosuspend().

If the PM core suspends the system before the 500ms timer expires, the
device is left in the RPM_ACTIVE state. Without system sleep callbacks to
force suspension, the DP controller's clocks could remain enabled while
the rest of the system sleeps.

> +
>  static const struct rockchip_dw_dp_plat_data rk3588_dp_plat_data =3D {
>  	.num_ctrls =3D 2,
>  	.ctrl_ids =3D {0xfde50000, 0xfde60000},

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-synopsys-d=
w-dp-improvements-v8-0-ac1e6a75782f@collabora.com?part=3D15
