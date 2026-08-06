Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6BEC5AC7C
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F6E10F27A;
	Thu,  6 Aug 2026 17:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q8lxzZ1D";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69B5210F27A
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:45:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D0C7413C8;
 Thu,  6 Aug 2026 17:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E4A1F000E9;
 Thu,  6 Aug 2026 17:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786038333;
 bh=oPUqdRKYVQBfPunEh46K+AnprcrTqVRPiGbD1DUlV7E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q8lxzZ1DsaBnP0Ukvhfg06fyhp5VY2690q6+Ex+vMvHQDoz38kpfh3+PskCnUgmCv
 dW3SW6rvrioszvcF9nY/oRcL84NrqKLyT4zxQXOj0PmLpbHCKwUi5p1sl/rEzCuwUg
 F76XDE59YETg5YGbEUF/6rOE9bXPN+ss1+MhH7qCL1ODtPo54Pl+Zd8lNXqEBx+Dqy
 o7DBYk3CPZO25wbWfffxXbGa2yGluUruKZUml1TZSGoV64MGtn4k2nKaSNqYWvh5nB
 aMFnP1oBNx3h0CobBTOyTRM00SWOrFmqAzVmolO+O7jTqUcLJHCixXcTWQjr3ZlwMh
 gG4Opr7FuUoCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 15/21] drm/rockchip: dw_dp: Add runtime PM support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-15-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v11-15-0d508505f383@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:45:31 +0000
Message-Id: <20260806174532.C4E4A1F000E9@smtp.kernel.org>
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
- [Medium] The driver implements runtime PM support but lacks system sleep =
callbacks, leaving the hardware fully powered on during system suspend.
- [Medium] Using asynchronous autosuspend before devres teardown on driver =
removal causes pending suspends to be cancelled, permanently leaking hardwa=
re clocks.
--

--- Patch [15]: [PATCH v11 15/21] drm/rockchip: dw_dp: Add runtime PM suppo=
rt ---
commit ee7c08af7fc5043079230468fab4131c048586ea
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/rockchip: dw_dp: Add runtime PM support

Add support for runtime PM to the Rockchip RK3576/3588 Synopsys
DesignWare DisplayPort driver.

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index ffcfb887d0d2a..770ab042a1879 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
[ ... ]
> @@ -231,6 +232,7 @@ static int dw_dp_rockchip_probe(struct platform_devic=
e *pdev)
>  	if (IS_ERR(dp->vo_grf))
>  		return PTR_ERR(dp->vo_grf);
> =20
> +	plat_data->autosuspend_delay =3D 500;
>  	plat_data->max_link_rate =3D plat_data_const->max_link_rate;
>  	plat_data->pixel_mode =3D plat_data_const->pixel_mode;
>  	plat_data->hpd_sw_sel =3D dw_dp_rockchip_hpd_sw_sel;
> @@ -253,6 +255,24 @@ static void dw_dp_rockchip_remove(struct platform_de=
vice *pdev)
>  	component_del(&pdev->dev, &dw_dp_rockchip_component_ops);
>  }

[Severity: Medium]
When the driver is removed, component_del() unbinds the DRM pipeline, queui=
ng
an async autosuspend with the 500ms delay set in dw_dp_rockchip_probe().

Because dw_dp_rockchip_remove() returns immediately, devres teardown will c=
all
pm_runtime_disable() which cancels the pending autosuspend.

Does this bypass dw_dp_runtime_suspend() and permanently leak the apb_clk
and aux_clk clocks? Should there be a synchronous suspend here?

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

[Severity: Medium]
The dev_pm_ops structure uses RUNTIME_PM_OPS but entirely omits
SYSTEM_SLEEP_PM_OPS.

During system suspend, pm_runtime_disable() cancels pending autosuspend tim=
ers.

Without system sleep callbacks (like pm_runtime_force_suspend), will the
hardware remain in RPM_ACTIVE with clocks running throughout system sleep?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v11-0-0d508505f383@collabora.com?part=3D15
