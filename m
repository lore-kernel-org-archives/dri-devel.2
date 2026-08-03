Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99E4C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3260610E6C1;
	Mon,  3 Aug 2026 15:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hivbX5F6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A14EB10E6C1
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 15:18:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B1E4460A78;
 Mon,  3 Aug 2026 15:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49ABB1F000E9;
 Mon,  3 Aug 2026 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785770338;
 bh=y5BXutHSZfrGaa7UWX+DPEoQKSU6qA9dfZ2odcxZHOc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hivbX5F6ty8m5oy0nACHasAmpyGcVniHFu7K+t4V2lKA2hj9WWGCJuO7e5YjQOzm6
 JEz01NNrYiRCZNV22LMGqKnEbZhgz0yTe95Bn+GV3qgDYg/o0FNVU/H2YpJdscKCta
 L26YU5dvOuNMVUbeseS8gEvMBfUxgw0miZQH8sXxYpT+5M3oLQSHkl8whlrRoOBnOp
 X0ozMRRhLbX0ZGefIYvzaBXtC35fS/eF/eq7UklyhXCZYyRofcap2mSIdxnempIyak
 eoqEq+ZM84W9PLq+IURigZLXUy1w9Hdw+Gxoi6ztuMhP7pYxczuBoxtK6Q3gG8k461
 cem+4LkdvnL6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] drm/bridge: nwl-dsi: Correct MIPI DSI horizontal
 sync timing
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260803-nwl-dsi-fixes-v2-3-1809a0ac453f@geanix.com>
References: <20260803-nwl-dsi-fixes-v2-0-1809a0ac453f@geanix.com>
 <20260803-nwl-dsi-fixes-v2-3-1809a0ac453f@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:18:57 +0000
Message-Id: <20260803151858.49ABB1F000E9@smtp.kernel.org>
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
- [Low] 64-bit division using the '/' operator causes a linker error on 32-=
bit architectures.
--

--- Patch [3]: [PATCH v2 3/4] drm/bridge: nwl-dsi: Correct MIPI DSI horizon=
tal sync timing ---
commit 2e5ea2d668a183af376a6de9dd60e558786a8b7f
Author: Esben Haabendal <esben@geanix.com>

drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync timing

This commit corrects the horizontal sync timing for the NWL MIPI Host
controller by calculating the hfp, hsa, and hbp in DSI packet payload size =
in
bytes instead of pixel clocks. It implements the calculation based on the
i.MX 8M reference manual while also taking the packet header size into acco=
unt.

> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nw=
l-dsi.c
> index c9af6a3d47e1d..226036d22e3f8 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
[ ... ]
> @@ -317,9 +322,62 @@ static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
>  			      dsi->mode.hdisplay);
>  	}
> =20
> -	nwl_dsi_write(dsi, NWL_DSI_HFP, hfront_porch);
> -	nwl_dsi_write(dsi, NWL_DSI_HBP, hback_porch);
> -	nwl_dsi_write(dsi, NWL_DSI_HSA, hsync_len);
> +	pclk_period =3D DIV_ROUND_UP_ULL(PSEC_PER_SEC, dsi->mode.clock * 1000);
> +	DRM_DEV_DEBUG_DRIVER(dsi->dev, "pclk_period: %llu\n", pclk_period);
> +
> +	hs_period =3D DIV_ROUND_UP_ULL(PSEC_PER_SEC, dsi->phy_cfg.mipi_dphy.hs_=
clk_rate);
> +	DRM_DEV_DEBUG_DRIVER(dsi->dev, "hs_period: %llu\n", hs_period);
> +
> +	/*
> +	 * Calculate the bytes needed, according to the RM formula:
> +	 * Time of DPI event =3D time to transmit x number of bytes on the DSI
> +	 * interface
> +	 * dpi_event_size * dpi_pclk_period =3D dsi_bytes * 8 * hs_bit_period /
> +	 * num_lanes
> +	 * =3D=3D=3D>
> +	 * dsi_bytes =3D dpi_event_size * dpi_pclk_period * num_lanes /
> +	 * (8 * hs_bit_period)
> +	 */
> +	hfp =3D hfront_porch * pclk_period * dsi->lanes / (8 * hs_period);
> +	hbp =3D hback_porch * pclk_period * dsi->lanes / (8 * hs_period);
> +	hsa =3D hsync_len * pclk_period * dsi->lanes / (8 * hs_period);

[Severity: Low]
Since hs_period and pclk_period are unsigned long long, does using the dire=
ct
'/' operator for 64-bit division cause a linker error (such as undefined
reference to __udivdi3) when building for 32-bit architectures?

Could this be resolved by using standard kernel 64-bit division macros such=
 as
div64_u64() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-nwl-dsi-fi=
xes-v2-0-1809a0ac453f@geanix.com?part=3D3
