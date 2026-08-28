Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E862C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A9B810F31B;
	Fri, 28 Aug 2026 09:26:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IJ3AP64Z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE8C10E495
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:26:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8A3E405EE;
 Fri, 28 Aug 2026 09:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9054B1F000E9;
 Fri, 28 Aug 2026 09:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787909184;
 bh=WvynsJz86n5uZk/dJs9s/bBSfo4XSMFMCwxcTXWXUZM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IJ3AP64Z2MEElISQYZkXqDJw5rYZHwWKDbCsb7cw7iRsi9OQpUg6J3Cv/wIoUdbLW
 FkoXo/weQvWoHf3qyfyqaLDaesDvXfcLiHz3H8+CErzSCfyRgwns8SSbRzlaXMcOyo
 bExIsnwN9bG/1nC2tVQnHPdtfDnCbdgkSC1TYcPKcXyOgjCmbk5/AKKX57mB9DrfA3
 TnCNBvAJnQJAjCMPp/YHGwlm37BOqbowWQ2jYs11fH5Ye7tNj23Io8g9SkQzN0yI8r
 SyBHLerUU/ngox3Wt40dtCYuOt4lvgWLMOjW9FfXEftElqDa3HmX0QBMq5kX0jhXE5
 L3u9zdqd88rEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: analogix: Propagate PHY errors from resume
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828091334.5793-1-pengpeng@iscas.ac.cn>
References: <20260828091334.5793-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 09:26:24 +0000
Message-Id: <20260828092624.9054B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of the platform-specific dp->plat_data->power_on(=
) callback is ignored in analogix_dp_resume(), potentially leading to hardw=
are faults and unbalanced clock disables in the newly added error path.
--

commit 777e12c640d41a75f043282a8ce210a68d6eca97
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

drm/bridge: analogix: Propagate PHY errors from resume

This patch updates analogix_dp_resume() to check the return values of
phy_set_mode() and phy_power_on(). If either fails, it rolls back the power
configuration using a newly added power_off error path instead of ignoring
the error.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 30c0c0b41d5aa..00844f68d748e 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1461,12 +1461,23 @@ int analogix_dp_resume(struct analogix_dp_device =
*dp)
>  	if (dp->plat_data->power_on)
>  		dp->plat_data->power_on(dp->plat_data);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but should the return value of
dp->plat_data->power_on() be checked here?

If dp->plat_data->power_on() fails (for example, if clk_prepare_enable()
fails in rockchip_dp_poweron()), it returns a negative error code and
leaves the platform clock disabled. By ignoring this error, execution
proceeds to phy_set_mode() and analogix_dp_init_dp(), which can result in
accessing unpowered hardware registers. Accessing unpowered hardware
typically causes a synchronous external abort on Arm platforms.

Furthermore, this patch actively exacerbates this issue. If the platform
power initialization fails and subsequently phy_set_mode() or
phy_power_on() fails, the newly added goto power_off error path will
execute:

    power_off:
        if (dp->plat_data->power_off)
            dp->plat_data->power_off(dp->plat_data);
        clk_disable_unprepare(dp->clock);

Can this cause an unbalanced clock disable? The power_off path will blindly
call clk_disable_unprepare() on the platform clock that was never
successfully enabled.

> -	phy_set_mode(dp->phy, PHY_MODE_DP);
> -	phy_power_on(dp->phy);
> +	ret =3D phy_set_mode(dp->phy, PHY_MODE_DP);
> +	if (ret)
> +		goto power_off;
> +
> +	ret =3D phy_power_on(dp->phy);
> +	if (ret)
> +		goto power_off;
> =20
>  	analogix_dp_init_dp(dp);
> =20
>  	return 0;
> +
> +power_off:
> +	if (dp->plat_data->power_off)
> +		dp->plat_data->power_off(dp->plat_data);
> +	clk_disable_unprepare(dp->clock);
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828091334.5793=
-1-pengpeng@iscas.ac.cn?part=3D1
