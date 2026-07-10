Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF7AC44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F0210E13F;
	Fri, 10 Jul 2026 08:38:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ockyv8JF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB2110E13F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 08:38:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 971D960EEF;
 Fri, 10 Jul 2026 08:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D85D1F00A3E;
 Fri, 10 Jul 2026 08:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783672732;
 bh=osPmCY1iot6435qkvk8WcyAIDfJFj/K5CHvB/1/6VZM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ockyv8JFswuH2p8/hlLCLovWyj848QaflGegb97CTW4u77Yqh+FyJi20/2yyJsI08
 fH6WkU7XEIZIvUkQtHk4mEH5j2LaFCMJxcEB3GqRXkqWNY5Xuj9oZ5tBmQy+k1Lvyp
 Gu/mqRImJIaS+L/V740Nt6ZvYbANgUD7DHPgF8+dxV3B3SsMx/2O2teLI09iCFKZp8
 XYTioJ2nrH1UfFip65qadoLveJL/g/nmy4rlQ6c4BeCtn+aXmTxWBor20Jp3fEeNNC
 pZc31fSI/QH3mFMt+s2dqph1f0GmGzudOf8onZFxCme322AtTVTR3kzlWfShCmlylb
 7dXm8iBqXJMmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/bridge: ti-sn65dsi83: Add reversed lvds lanes
 support
To: "Wojciech Dubowik" <wojciech.dubowik@mt.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710082630.394040-1-wojciech.dubowik@mt.com>
References: <20260710082630.394040-1-wojciech.dubowik@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:38:51 +0000
Message-Id: <20260710083852.0D85D1F00A3E@smtp.kernel.org>
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
- [Medium] Strict parsing of the `data-lanes` property breaks device probe =
for valid configurations with fewer than 4 lanes or non-matching lane order=
ings.
--

--- Patch [1]: [PATCH v2] drm/bridge: ti-sn65dsi83: Add reversed lvds lanes=
 support ---
commit 33b38b449204d2ada7177a7a3ded61d90bf26441
Author: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

drm/bridge: ti-sn65dsi83: Add reversed lvds lanes support

This commit parses an optional data-lanes property on the LVDS endpoint to
inform the chip if the lanes have been reversed.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index e6dbe51d0dba9..d676ea3b40e87 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c

[ ... ]

> @@ -854,6 +873,37 @@ static int sn65dsi83_parse_lvds_endpoint(struct sn65=
dsi83 *ctx, int channel)
>  		goto exit;
>  	}
> =20
> +	ret_data =3D of_property_read_u32_array(endpoint, "data-lanes", data_la=
nes,
> +			ARRAY_SIZE(data_lanes));
> +	if (ret_data !=3D 0 && ret_data !=3D -EINVAL) {
> +		ret =3D ret_data;
> +		goto exit;
> +	}

[Severity: Medium]
Will this break the device probe for valid configurations with fewer than 4
lanes?

If a device tree specifies a valid data-lanes property on the LVDS endpoint
that has fewer than 4 elements (such as <1 2 3> for an 18-bpp display using
3 lanes), of_property_read_u32_array() will return -EOVERFLOW.

Since -EOVERFLOW is not -EINVAL, the probe will be aborted here.

> +
> +	if (!ret_data) {
> +		for (i =3D 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
> +			for (j =3D 0; j < DATA_LANES_COUNT; j++) {
> +				if (data_lanes[j] !=3D supported_data_lane_mapping[i][j])
> +					break;
> +			}
> +
> +			if (j =3D=3D DATA_LANES_COUNT)
> +				break;
> +		}
> +
> +		switch (i) {
> +		case NORMAL_LANE_MAPPING:
> +			break;
> +		case REVERSE_LANE_MAPPING:
> +			ctx->lvds_reverse_lanes_conf[channel] =3D true;
> +			break;
> +		default:
> +			dev_err(dev, "invalid data lanes mapping\n");
> +			ret =3D -EINVAL;
> +			goto exit;

[Severity: Medium]
Does this code also incorrectly reject valid 4-element arrays with alternat=
ive
numbering?

If the mapping doesn't exactly match the two hardcoded 1-based arrays (for
example, a 0-indexed mapping like <0 1 2 3>), it falls through to this
default case, returning -EINVAL and aborting the probe.

Could we make the parsing more lenient to avoid breaking existing setups
that specify valid but non-matching lane orderings?

> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710082630.3940=
40-1-wojciech.dubowik@mt.com?part=3D1
