Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9815C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 03:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AF9310E5F8;
	Mon, 10 Aug 2026 03:59:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dgFroHR5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57BF510E5F8
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 03:59:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D8F960052;
 Mon, 10 Aug 2026 03:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA59C1F000E9;
 Mon, 10 Aug 2026 03:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786334366;
 bh=pMx5kANNEUaQ/O+JA1N92zQv0u43IRnCNbK0OECGgfI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dgFroHR53Bb1VhAnKOKNTxA8GrzwpzArek4tNRK9DfJTIr9FM72uZ5abw3rlGMMJB
 bd6UrNf3cSD6eSZLSL1Rqi3FMLxkb0LKBScZzf+RVNfkT5y+H8tw4hs78fHkQL4Q9x
 Zm9rsjz7tTj6UvdT5GCuSSdg9gI6D6FXCAjiTeUDF85jziJS7JaL2tTXuB0EUtMd6w
 9Kf3ONxfnaQ0xuf32Ff9+vfxcQqcJRG41F8CnMjdh1BHjdy43fMgJitgaPgziTc9yw
 s5aSxlwbHafbVynEaMIvpCf4yaG8RWPJ42QWqvQnlK620aWY4IonS+dgoxTrKmgwfK
 NNFP7+teXfPDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] drm/rockchip: dsi: Add dphy_get_timing support
 for multiple PHY types
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810034139.148-3-kernel@airkyi.com>
References: <20260810034139.148-1-kernel@airkyi.com>
 <20260810034139.148-3-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 03:59:26 +0000
Message-Id: <20260810035926.CA59C1F000E9@smtp.kernel.org>
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
- [High] Missing `dphy_get_timing` callback initialization in `rk3506_chip_=
data` causes a NULL pointer dereference on the RK3506 platform.
--

--- Patch [2]: [PATCH v3 2/3] drm/rockchip: dsi: Add dphy_get_timing suppor=
t for multiple PHY types ---
commit 266dcada14f6495a40e461eefa6793e6e1dcb8ca
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: dsi: Add dphy_get_timing support for multiple PHY types

This commit introduces platform-specific D-PHY timing callbacks to handle
timing differences between older and newer Rockchip platforms.

> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gp=
u/drm/rockchip/dw-mipi-dsi-rockchip.c
> index fd91343d0f6d5..557708bc4faa4 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
[ ... ]
> @@ -737,6 +742,32 @@ dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned=
 int lane_mbps,
>  	return 0;
>  }
> =20
> +static const struct dw_mipi_dsi_dphy_timing dphy_timing_px30 =3D {
> +	.clk_lp2hs =3D 0x40,
> +	.clk_hs2lp =3D 0x40,
> +	.data_lp2hs =3D 0x10,
> +	.data_hs2lp =3D 0x14,
> +};
> +
> +static int
> +dw_mipi_dsi_phy_px30_get_timing(struct dw_mipi_dsi_rockchip *dsi,
> +				unsigned int lane_mbps,
> +				struct dw_mipi_dsi_dphy_timing *timing)
> +{
> +	*timing =3D dphy_timing_px30;
> +
> +	return 0;
> +}
> +
> +static int
> +dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
> +			   struct dw_mipi_dsi_dphy_timing *timing)
> +{
> +	struct dw_mipi_dsi_rockchip *dsi =3D priv_data;
> +
> +	return dsi->cdata->dphy_get_timing(dsi, lane_mbps, timing);

[Severity: High]
Will this cause a NULL pointer dereference on the RK3506 platform?

The patch updates multiple platform definitions to set the .dphy_get_timing
callback, but it appears to have missed rk3506_chip_data, leaving its
callback as NULL.

When dw_mipi_dsi_phy_get_timing() is called during modeset on RK3506, it
unconditionally dereferences dsi->cdata->dphy_get_timing, which will lead
to an immediate crash.

Should a NULL check be added here, or should rk3506_chip_data be updated to
include a timing callback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810034139.148-=
1-kernel@airkyi.com?part=3D2
