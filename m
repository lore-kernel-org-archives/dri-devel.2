Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D7CC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 01:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 652F110F075;
	Thu,  6 Aug 2026 01:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ThnQRTNU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D54F10F075
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 01:06:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EAAEC418DD;
 Thu,  6 Aug 2026 01:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485FD1F000E9;
 Thu,  6 Aug 2026 01:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785978397;
 bh=5c/cN7ZtOWSlGDW9V5l7RLTjGbWSKIPZFS/+ErdV6vQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ThnQRTNUiTApyoBM9eOk3wnWVn5bmzTYEAf5esm7HIF5P9FAV4EFK1re97svi9V9O
 odE0ZY4J/I9EscO6cRiEDIIiici/4k9Wd2wS/t84vlrYk6m+YYYhKn7vhiu0w8x7eq
 pOlwm+U24/uSfRTF19dH9BoEg9/1u8B0fj1VgHg8xaMhfv3+PET1vhXNm7Fc2pBbhm
 /aBR04UOE8mWzgPt5J6Lt6VnYHYo7y8mcb0XXHQ408B2fn/qYLMu1ndxVS+m6C4UVX
 8ZMSZrh8o2T3H/3ZvLDINWCn70Zb/Tohi26mISwzbzPXHNj/MoDs6ryi5MSFyTSwkV
 lqDwYqy0r0C9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 15/21] drm/rockchip: dw_dp: Add runtime PM support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v10-15-d84a26c303d6@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v10-0-d84a26c303d6@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v10-15-d84a26c303d6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 01:06:36 +0000
Message-Id: <20260806010637.485FD1F000E9@smtp.kernel.org>
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

New issues:
- [High] Omission of system sleep PM callbacks breaks hardware reinitializa=
tion after system suspend (S3).
- [High] Activating runtime PM skips the manual initialization of controlle=
r clocks, causing `phy_init()` to be called with disabled clocks.

Pre-existing issues:
- [High] Asynchronous runtime PM put on driver unbind leads to resource lea=
ks because the suspend is cancelled by pm_runtime_disable().
--

--- Patch [15]: [PATCH v10 15/21] drm/rockchip: dw_dp: Add runtime PM suppo=
rt ---
commit a8b68fca7b517a740f570a28e454719c2577d17d
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/rockchip: dw_dp: Add runtime PM support

This patch adds runtime PM support to the Rockchip RK3576/3588 Synopsys
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

[Severity: High]
This is a pre-existing issue, but activating runtime PM for this driver by
setting this autosuspend delay exposes a potential resource leak during
driver unbind.

During component unbind, devm_drm_bridge_add() cleanup invokes
dw_dp_bridge_detach():

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_bridge_detach() {
    ...
    if (!dp->usbc_mode)
        pm_runtime_put_autosuspend(dp->dev);
    ...
}

Shortly after, the devm_pm_runtime_enable() cleanup invokes
pm_runtime_disable(), which cancels any pending asynchronous suspend reques=
ts.

Since this is an async put, will the hardware clocks (apb_clk, aux_clk)
remain enabled indefinitely after driver unbind?

[Severity: High]
Does activating runtime PM here skip the clock enablement needed for PHY
initialization?

In dw_dp_probe(), the fallback manual resume is skipped when runtime PM is
enabled:

drivers/gpu/drm/bridge/synopsys/dw-dp.c:dw_dp_probe() {
    ...
    if (!pm_runtime_enabled(dev)) {
        dw_dp_runtime_resume(dp);
        ...
    }
   =20
    ret =3D phy_init(dp->phy);
    ...
}

Since we set autosuspend_delay here, pm_runtime_enabled() evaluates to true
and we skip dw_dp_runtime_resume(). However, there is no corresponding
pm_runtime_get_sync() before phy_init() is called.

Will this cause phy_init() to execute with the controller's APB clock turned
off, potentially resulting in a bus hang?

>  	plat_data->max_link_rate =3D plat_data_const->max_link_rate;
>  	plat_data->pixel_mode =3D plat_data_const->pixel_mode;
[ ... ]
> @@ -253,6 +255,24 @@ static void dw_dp_rockchip_remove(struct platform_de=
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
Does this struct need to map system sleep callbacks as well?

Because we only define RUNTIME_PM_OPS here, the PM core takes no action for
this device when the system enters S3 suspend. The device remains tracked as
active in software.

Upon system wake, since there is no system resume callback, the software
state remains active.

When a subsequent pm_runtime_get() is called during display enable, will it
skip executing dw_dp_rockchip_runtime_resume() because the software status =
is
already active? If so, this could leave the hardware uninitialized after a
system suspend.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-synopsys-d=
w-dp-improvements-v10-0-d84a26c303d6@collabora.com?part=3D15
