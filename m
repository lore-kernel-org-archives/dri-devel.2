Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE71EC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3474310E4E8;
	Mon,  7 Sep 2026 13:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BDf94LKL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C16110E7FF
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:06:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 80E9E60A9C;
 Mon,  7 Sep 2026 13:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E673D1F00A3A;
 Mon,  7 Sep 2026 13:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788786394;
 bh=AxbGZPmHx0BObJ0+cww/U0bN0G/xmViudIJnn9VJkF4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BDf94LKLvo18RQ+yVjzLjp6aN4RmP2cNNnUzZpdXPwuoh3a/qF8IR/JFC55L+f24H
 H3ZfkHMy8oiayp4INPIaxlDu1p5f8NOL/jlNFtKygd3z10Cfe7+yYkvOPtMJ8Xdqm3
 5GEvQrLYj+8cHOltth0qSplmF0DowS3h5P1PU942+01FXJcJZlU1BszrUfGD9sLMug
 aSf0wHailcRHC90z1ztEk8M7yeCjoUHqN8UjIZKmssk1mP0hq6OvLZJnR0jvRbMK1Z
 jig9kJHGupYrhQhu97BnMlAsj7E6UQfnweKTASCYjvCfs3ApyJylHpu8tfK6HiKY9W
 z9tci5rdDx6PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] drm/msm/hdmi_phy: Cleanup after
 msm_hdmi_phy_resource_enable() failure
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-1-b097cf1eac77@oss.qualcomm.com>
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
 <20260907-drm-msm-hdmi-fixes-before-eliza-v2-1-b097cf1eac77@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 13:06:33 +0000
Message-Id: <20260907130633.E673D1F00A3A@smtp.kernel.org>
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
- [Medium] Missing regulator disable on the newly added clock enablement er=
ror path.
--

commit 89a12851603b82367d9387f6f70068a1f77f92b9
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure

This commit adds an error cleanup path to msm_hdmi_phy_resource_enable()
to ensure resources are properly unwound if regulators or clocks fail to
enable.

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hd=
mi/hdmi_phy.c
> index eb1088755cb3a..fd675f537f2b8 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
> @@ -67,16 +67,26 @@ int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
>  	ret =3D regulator_bulk_enable(cfg->num_regs, phy->regs);
>  	if (ret) {
>  		DRM_DEV_ERROR(dev, "failed to enable regulators: (%d)\n", ret);
> -		return ret;
> +		goto err_pm_put;
>  	}
> =20
>  	for (i =3D 0; i < cfg->num_clks; i++) {
>  		ret =3D clk_prepare_enable(phy->clks[i]);
> -		if (ret)
> +		if (ret) {
>  			DRM_DEV_ERROR(dev, "failed to enable clock: %s (%d)\n",
>  				cfg->clk_names[i], ret);
> +			goto err_clk_unprepare;
> +		}
>  	}
> =20
> +	return 0;
> +
> +err_clk_unprepare:
> +	for (; i > 0; i--)
> +		clk_disable_unprepare(phy->clks[i - 1]);
> +err_pm_put:
> +	pm_runtime_put_sync(dev);

[Severity: Medium]
Does this new error path leak the regulator enable count?

If clk_prepare_enable() fails, the code jumps to err_clk_unprepare,
unwinds the clocks, and drops the PM runtime reference at err_pm_put.
However, it appears to skip calling regulator_bulk_disable() for the
regulators that were successfully enabled earlier in the function.

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-drm-msm-hd=
mi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com?part=3D1
