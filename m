Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD9DC54F54
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C08F10E5FF;
	Tue, 28 Jul 2026 19:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hqp3xcVD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3454410E5E2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 19:41:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60B85600FC;
 Tue, 28 Jul 2026 19:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBB41F000E9;
 Tue, 28 Jul 2026 19:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785267691;
 bh=HjR5pw5/gfOy+jhyu25quQeDLamlpk27FN6+f+2Qb98=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hqp3xcVDDOWVvMEollem4sHf8bgYjz5Mimt4yqh4cwgVYD9EdFQT66W8O3zTzRl1D
 bFVtf8yQyqJssqQweAaJxuaAVkWPI7HQiL8XpdfhwJFkzefMzMnlc6YdA+qp02Q88W
 Y7Fiv/YWDxsX+hI6jb5xF0hNir8HJJfa8JNpVkDkTxXw6oCiavNWHsQZxDZPIlH1+f
 hRxTf7Q0VazFJIBLmgsxTK0RrFXnk9qerzslVf4MrGSY+dQ424Q43Wwzh05NG5K3h3
 DjSgXmOrs3kC25LLRDwOnnZq612aklr653oMeV8Iu2dVGLU4FLBIDYg0xyzQKtpCuc
 ToownFZDkBiOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/18] drm/rockchip: dw_dp: Implement out-of-band HPD
 handling
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260728-synopsys-dw-dp-improvements-v7-11-b7640fa8cf48@collabora.com>
References: <20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com>
 <20260728-synopsys-dw-dp-improvements-v7-11-b7640fa8cf48@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 19:41:30 +0000
Message-Id: <20260728194130.CCBB41F000E9@smtp.kernel.org>
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
- [Medium] Missing runtime PM acquisition in out-of-band HPD callbacks lead=
s to SError crashes once runtime PM is enabled.
--

--- Patch [11]: [PATCH v7 11/18] drm/rockchip: dw_dp: Implement out-of-band=
 HPD handling ---
commit 38a0d76cc721376e1ac94e73ba9bcc954b4597fd
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/rockchip: dw_dp: Implement out-of-band HPD handling

This patch implements out-of-band hotplug handling to receive external hotp=
lug
information from the USB-C state machine. This moves the logic from the USB=
DP
PHY driver to avoid SError crashes once runtime PM is enabled.

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index 005938dc66c9f..b2e817044c942 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c

[ ... ]

> +static void dw_dp_rockchip_hpd_sw_sel(void *data, bool force_hpd_from_sw)
> +{
> +	struct rockchip_dw_dp *dp =3D data;
> +	u32 hpd_reg =3D dp->pdata->hpd_reg[dp->id];
> +
> +	dp->hpd_sel =3D force_hpd_from_sw;
> +
> +	regmap_write(dp->vo_grf, hpd_reg,
> +		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL, dp->hpd_sel));

[Severity: Medium]
Will this regmap_write() trigger an SError if the USB-C state machine
triggers an out-of-band hotplug event while the DP controller is runtime
suspended?

The commit message notes this patch is intended to prevent SError problems
once runtime PM is enabled. Since the register access requires the DP
controller's power domain, should there be a runtime PM acquisition before
writing to the vo_grf regmap?

> +}
> +
> +static void dw_dp_rockchip_hpd_sw_cfg(void *data, bool hpd)
> +{
> +	struct rockchip_dw_dp *dp =3D data;
> +	u32 hpd_reg =3D dp->pdata->hpd_reg[dp->id];
> +
> +	dev_dbg(dp->dev, "Force HPD connected=3D%s\n", str_yes_no(hpd));
> +
> +	dp->hpd_cfg =3D hpd;
> +
> +	regmap_write(dp->vo_grf, hpd_reg,
> +		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG, dp->hpd_cfg));

[Severity: Medium]
Similarly, could this asynchronous write cause an SError crash if it fires
without first ensuring the DP controller's power domain is active via runti=
me
PM?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-synopsys-d=
w-dp-improvements-v7-0-b7640fa8cf48@collabora.com?part=3D11
