Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14850C88E40
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66FBD10E0A6;
	Sun, 13 Sep 2026 09:07:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FIkWsPKy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B2A010E0A6
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 09:07:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D1BBC43F74;
 Sun, 13 Sep 2026 09:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB9B1F00893;
 Sun, 13 Sep 2026 09:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789290428;
 bh=kIcWr3W3VKqxr7hXYp754UHDKXby3m6H+vrCVCVeYQc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FIkWsPKykE60p8b8YC9CLrcqx7KAz45bwvK6OWlJB2X3lFTv71uWTxP3f0Pv1d+DR
 0QyAy5XI4HNYIhv5VXiiPxIWolnij73rddCQcTxTdzZRwJmSnaXGEXbPdQ0Xm+uUOZ
 7HwtuxEanta5HCZcHrrSa0f/5Un8lPBgiQjeA7AgW5EtnXrvHLxd9YtLu+ePQjV06w
 uFCC8ysQmyD/ocbT87MVWvoW7p0Ge2CcaaOJERlV48MIl7dGwSQLW76CCuqw0pGb7k
 7LxOoi1mVbxigyD43O9YvSB4xcNQZ/OnMs2C6qkdMJ6PuTJOBp0T3UjUa4m+JjWrpZ
 yJn9izrV/Copg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/hdmi_phy: fix runtime PM cleanup on probe failure
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913085814.1509352-1-lgs201920130244@gmail.com>
References: <20260913085814.1509352-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 09:07:08 +0000
Message-Id: <20260913090708.8AB9B1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] msm_hdmi_phy_resource_enable() fails to clean up resources on erro=
r paths, leading to leaked PM runtime references and unbalanced clocks/regu=
lators.
- [High] msm_hdmi_bridge_atomic_pre_enable() ignores the return value of ms=
m_hdmi_phy_resource_enable().
--

commit 7bd11a53a59269371e001514370dec3c09b44b21
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/msm/hdmi_phy: fix runtime PM cleanup on probe failure

This commit ensures that if PHY resource enabling or PLL initialization
fails during probe, the driver routes through a common error path to
disable runtime PM before returning.

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hd=
mi/hdmi_phy.c
> index eb1088755cb3a..77dce35cd45e0 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> @@ -168,13 +168,13 @@ static int msm_hdmi_phy_probe(struct platform_devic=
e *pdev)
> =20
>  	ret =3D msm_hdmi_phy_resource_enable(phy);
>  	if (ret)
> -		return ret;
> +		goto err_pm_disable;

[Severity: High]
This isn't a bug introduced by this patch, but looking at the call to
msm_hdmi_phy_resource_enable() here, does it leak PM runtime references=20
and fail to clean up regulators on error?

Inside msm_hdmi_phy_resource_enable() in drivers/gpu/drm/msm/hdmi/hdmi_phy.=
c,
if regulator_bulk_enable() fails, it returns early without calling
pm_runtime_put_sync(), which permanently leaks the PM runtime usage counter:

drivers/gpu/drm/msm/hdmi/hdmi_phy.c:msm_hdmi_phy_resource_enable() {
    ...
    ret =3D regulator_bulk_enable(cfg->num_regs, phy->regs);
    if (ret) {
        DRM_DEV_ERROR(dev, "failed to enable regulators: (%d)\n", ret);
        return ret;
    }
    ...
}

Additionally, in the same function, if a clock fails to enable during the
loop, does it overwrite the error and falsely return success if a
subsequent clock succeeds?

drivers/gpu/drm/msm/hdmi/hdmi_phy.c:msm_hdmi_phy_resource_enable() {
    ...
    for (i =3D 0; i < cfg->num_clks; i++) {
        ret =3D clk_prepare_enable(phy->clks[i]);
        if (ret)
            DRM_DEV_ERROR(dev, "failed to enable clock: %s (%d)\n",
                cfg->clk_names[i], ret);
    }

    return ret;
}

Because the loop does not break on error, a subsequent successful clock
enable will set ret back to 0, falsely returning success and leaving the
hardware partially unclocked.

[Severity: High]
This is a pre-existing issue, but since we are handling failures from
msm_hdmi_phy_resource_enable() in this path, is it safe that
msm_hdmi_bridge_atomic_pre_enable() ignores this function's return value?

drivers/gpu/drm/msm/hdmi/hdmi_bridge.c:msm_hdmi_bridge_atomic_pre_enable() {
    ...
    if (!hdmi->power_on) {
        msm_hdmi_phy_resource_enable(phy);
        msm_hdmi_power_on(bridge);
        hdmi->power_on =3D true;
    }
    ...
}

If msm_hdmi_phy_resource_enable() fails during an atomic commit, the hardwa=
re
remains unclocked and unpowered. Calling msm_hdmi_power_on() immediately
after will access dead hardware registers, which can lead to a synchronous
external abort or kernel panic on MSM platforms.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913085814.1509=
352-1-lgs201920130244@gmail.com?part=3D1
