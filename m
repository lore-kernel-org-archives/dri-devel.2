Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008C3C54F52
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 20:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC6710E243;
	Tue, 28 Jul 2026 20:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h7LMQcS+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0219D10E243
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 20:14:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5390D60A6C;
 Tue, 28 Jul 2026 20:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AD71F000E9;
 Tue, 28 Jul 2026 20:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785269676;
 bh=w3E+2fLn21qNNZLc5r92yrlAt1YbI2ZDUIoLBqHXaoU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h7LMQcS+F7WKyJC2rFSIavZAvyUtzbWZmEDNYfkeAwMrDE4H/+dYBGq00Ks9CMDE4
 mSYt7KlT+HwO6dRMrCKz9ooEAWCCugvWUwdGmii1UXbtBnmUcqRIlEArOsHStx3SoH
 yJdbHdp1on0zrJtxKUGfQ+oKcK/Ie7gDsJwAEBS4T0Fn5DrTubvR3dOFlF/1Yv76Ij
 jj10dQlLXuWP8CrUMkJyDGqqQoG9ohoPn7TsyYq42H9qt5lC+ivXz7U1abAL0/RqeX
 Ew1KvrBJaWTHbhK93cB5yHGI9wLjS3d5Kr15ijY5LMXJ3Th0Dg4SLphrYTocMC4+tc
 VjBc544j7cLAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/18] drm/rockchip: dw_dp: Add runtime PM support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260728-synopsys-dw-dp-improvements-v7-13-b7640fa8cf48@collabora.com>
References: <20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com>
 <20260728-synopsys-dw-dp-improvements-v7-13-b7640fa8cf48@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 20:14:35 +0000
Message-Id: <20260728201435.A7AD71F000E9@smtp.kernel.org>
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
- [High] Incorrect ordering of GRF (Video Output General Register File) res=
toration in `dw_dp_rockchip_runtime_resume` delays HPD signal visibility to=
 the DP hardware, breaking link training.
- [Medium] Missing system sleep callbacks prevent the device and its power =
domain from suspending during system sleep for native DP configurations.
--

--- Patch [13]: [PATCH v7 13/18] drm/rockchip: dw_dp: Add runtime PM suppor=
t ---
commit ea12bfaf9ea353b204570fe194d520aa064c1270
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/rockchip: dw_dp: Add runtime PM support

Add support for runtime PM to the Rockchip RK3576/3588 Synopsys
DesignWare DisplayPort driver.

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index b2e817044c942..01915f7b24d59 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
[ ... ]
> @@ -255,6 +274,34 @@ static void dw_dp_rockchip_remove(struct platform_de=
vice *pdev)
[ ... ]
> +static int dw_dp_rockchip_runtime_resume(struct device *dev)
> +{
> +	struct rockchip_dw_dp *dp =3D dev_get_drvdata(dev);
> +	u32 hpd_reg =3D dp->pdata->hpd_reg[dp->id];
> +	int ret;
> +
> +	ret =3D dw_dp_runtime_resume(dp->base);
> +	if (ret)
> +		return ret;
> +
> +	regmap_write(dp->vo_grf, hpd_reg,
> +		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL, dp->hpd_sel) |
> +		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG, dp->hpd_cfg));

[Severity: High]
Does restoring the GRF state after dw_dp_runtime_resume() break link traini=
ng?

Looking at dw_dp_runtime_resume(), it initializes the hardware and sleeps
for 110ms to debounce the HPD signal. Because the power domain was off, the
VO GRF is in its reset state, so during this 110ms wait, the DP controller
will see HPD as LOW.

Once the GRF is finally written here, the controller sees HPD go HIGH and
starts a new hardware debounce. Any immediate attempt to access the sink
by the display core might fail because the DP controller still believes
HPD is disconnected.

Should the GRF state be restored before calling dw_dp_runtime_resume() so
the hardware debounce sees the correct HPD signal?

> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops dw_dp_pm_ops =3D {
> +	RUNTIME_PM_OPS(dw_dp_rockchip_runtime_suspend, dw_dp_rockchip_runtime_r=
esume, NULL)
> +};

[Severity: Medium]
Will this prevent the system from entering deeper sleep states during system
suspend?

For native DP configurations, the core dw_dp driver acquires a runtime PM
reference in dw_dp_bind() and holds it indefinitely for Hot-Plug Detect
purposes. During system suspend (S3), since dw_dp_pm_ops is defined using
only RUNTIME_PM_OPS without system sleep callbacks, the PM core won't force
the device into a suspended state.

This means the generic PM domain might see the device as active and refuse
to power off the domain. Should system sleep callbacks be added to handle
this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-synopsys-d=
w-dp-improvements-v7-0-b7640fa8cf48@collabora.com?part=3D13
