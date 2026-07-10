Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB7AC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3947B10E0B4;
	Fri, 10 Jul 2026 14:27:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ow7WnFDU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91B1610E0B4
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:27:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A471860052;
 Fri, 10 Jul 2026 14:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0A71F00A3A;
 Fri, 10 Jul 2026 14:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783693643;
 bh=NXRjPjp+m5NPPpy9nIoVFkJ2qTZyWxPsegteYySlKI8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ow7WnFDUvm8ah/TfVVwhMAJMTwRWx8SFUZZ40q6jLwA7aopqexweKamUx20cyB7Xk
 dEgHK9uvlq1o0NGx97hF0h/0SuHcTKH5Q2XIK8nXfe3skHgtG2BJrUK0dRFTz4WzES
 aiYC2mvW7I1n9R++KrNx8FCtWIZRF+yH407YmqVWah053868UtaWNbGRqlulVz/29W
 5mErkTFJwI6lnd03uBGhROUq2VjLYpHftLuJWHM73KBKdJ0ZW8X5vtFnCQQKg4h1PD
 X+PWCw9Q88zKm45ar8TfUt3oOWkcvsHFEXlcyYNJt6IvAZAPNbRitT87F+0mGothn/
 CIC7jI0vMzW8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/bridge: nwl-dsi: Correct MIPI DSI horizontal
 sync timing
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710-nwl-dsi-fixes-v1-3-927d918a86ad@geanix.com>
References: <20260710-nwl-dsi-fixes-v1-0-927d918a86ad@geanix.com>
 <20260710-nwl-dsi-fixes-v1-3-927d918a86ad@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 14:27:22 +0000
Message-Id: <20260710142723.3A0A71F00A3A@smtp.kernel.org>
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
- [Critical] Division by zero kernel panic if a display mode has zero horiz=
ontal blanking.
- [High] Integer underflow leading to hardware register corruption when hor=
izontal blanking is too small.
- [Low] Build failure on 32-bit architectures due to 64-bit division.
--

--- Patch [3]: [PATCH 3/3] drm/bridge: nwl-dsi: Correct MIPI DSI horizontal=
 sync timing ---
commit eb9d34f1c88e6933d5822b8331847848414cfe4d
Author: Esben Haabendal <esben@geanix.com>

drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync timing

The NWL MIPI Host controller registers specifies the horizontal front
porch, sync pulse, and back porch in DSI packet payload size in bytes (ie.
not in pixel clocks).

The formula implemented here converts the hfp, hsa, and hbp to DSI packet
bytes and then subtracts the number of packet header bytes.

> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nw=
l-dsi.c
> index c9af6a3d47e1d..ed61580a35457 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -317,9 +322,54 @@ static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
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
Will this cause a build failure on 32-bit architectures?

The variables pclk_period and hs_period are 64-bit unsigned integers
(unsigned long long), and using the native division operator here instead of
kernel macros like div64_u64() can result in an undefined reference to
'__udivdi3' when compiling on 32-bit systems.

> +
> +	/* Make sure horizontal blankins are even numbers */
> +	hfp =3D roundup(hfp, 2);
> +	hbp =3D roundup(hbp, 2);
> +	hsa =3D roundup(hsa, 2);
> +
> +	/*
> +	 * We need to subtract the packet header length: 32
> +	 * In order to make sure we don't get negative values,
> +	 * subtract a proportional value to the total length of the
> +	 * horizontal blanking duration.
> +	 */
> +	h_blank =3D hfp + hbp + hsa;
> +
> +	pkt_len =3D roundup(((hfp * 100 / h_blank) * 32) / 100, 2);

[Severity: Critical]
Could h_blank be zero here?

If userspace configures a display mode where hdisplay =3D=3D hsync_start =
=3D=3D
hsync_end =3D=3D htotal (meaning zero horizontal blanking), the porches and
sync length will be zero. This makes hfp, hbp, and hsa zero, causing h_blank
to evaluate to 0.

Since the mode parameters are not restricted from being zero during validat=
ion,
could a custom mode submitted via DRM atomic commits trigger a division by
zero kernel panic here?

> +	pkt_hdr_len =3D pkt_len;
> +	hfp -=3D pkt_len;
> +
> +	pkt_len =3D roundup(((hbp * 100 / h_blank) * 32) / 100, 2);
> +	pkt_hdr_len +=3D pkt_len;
> +	hbp -=3D pkt_len;
> +
> +	hsa -=3D (32 - pkt_hdr_len);
> +
> +	DRM_DEV_DEBUG_DRIVER(dsi->dev, "Register values: hfp=3D%d hbp=3D%d hsa=
=3D%d\n", hfp, hbp, hsa);
> +
> +	nwl_dsi_write(dsi, NWL_DSI_HFP, hfp);
> +	nwl_dsi_write(dsi, NWL_DSI_HBP, hbp);
> +	nwl_dsi_write(dsi, NWL_DSI_HSA, hsa);

[Severity: High]
Can these subtractions cause integer underflow if the horizontal blanking is
too small?

If userspace configures a mode with a valid but very small horizontal blank=
ing
(where the calculated h_blank is less than the equivalent of 32 bytes),
subtracting up to 32 bytes proportionally could cause hfp, hbp, or hsa to
underflow and become negative.

Would those underflowed negative values then be implicitly cast to large u32
integers when written directly to the DSI hardware registers here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-nwl-dsi-fi=
xes-v1-0-927d918a86ad@geanix.com?part=3D3
