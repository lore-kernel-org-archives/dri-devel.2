Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21414C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A4C089343;
	Fri, 10 Jul 2026 08:37:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bW+5z7z+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F6889343
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 08:37:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 90DA860051;
 Fri, 10 Jul 2026 08:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1CB1F000E9;
 Fri, 10 Jul 2026 08:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783672658;
 bh=lA9Z16hJ38ZHTm5yh17D3L9U6TZvuj8iQ329kHZ2sgg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bW+5z7z+/eSCCNuHz5Jn6HcwS/ZxrxJ/TKI26cUgsnkR+R2odHwYaG34krwn5lDHN
 F/nCutW3f8JBumV5sP86ijl0i+Ray0WzrGZa/7ZzvvR9NRS6OE+nVo7kSCYYszdzoC
 jBVTh+kgL8Kd2AEbL3VOICnh07OQAaJlO+iOBk5l9iuaAC0hTkmjzTkxUVVSLX+Jc/
 A84N+BQdj00G3caj1/JwDTOYhBdseFqPEAEyqU5gsesSdP6EgseE4y8tVsTbvR0OH+
 mEvoZ+ldQALqlN57vmwnZA2gTYXvLgBWbItkngdl7MN0QmgMfyNfmSQFaCYOtxB2Bd
 55dclk5oMvblQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] drm/bridge: ti-sn65dsi83: Add reversed lvds
 lanes support
To: "Wojciech Dubowik" <wojciech.dubowik@mt.com>
Cc: imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, Frank.Li@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260710082630.394040-3-wojciech.dubowik@mt.com>
References: <20260710082630.394040-1-wojciech.dubowik@mt.com>
 <20260710082630.394040-3-wojciech.dubowik@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:37:37 +0000
Message-Id: <20260710083737.BD1CB1F000E9@smtp.kernel.org>
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
- [High] Probe definitively fails on valid legacy 3-lane or 0-indexed devic=
e trees due to rigid array bounds.
--

--- Patch [1]: [PATCH v3 1/2] drm/bridge: ti-sn65dsi83: Add reversed lvds l=
anes support ---
commit 47fc41c5744e78e6f8072b1226e9548c69361da5
Author: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

drm/bridge: ti-sn65dsi83: Add reversed lvds lanes support

The chip supports output lvds lanes in two orders, default <1 2 3 4>
and <4 3 2 1>. Add parsing of an optional output lvds data-lanes
property so we can inform chip that the lanes have been reversed.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
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

[Severity: High]
Does this code break valid legacy device trees that define fewer than 4 lan=
es?

If a device tree has a data-lanes property on the LVDS endpoint with fewer
than 4 lanes (e.g., <1 2 3>), of_property_read_u32_array() will return
-EOVERFLOW because it rigidly expects exactly ARRAY_SIZE(data_lanes) elemen=
ts.
This will immediately abort the probe, breaking previously working displays.

> +		ret =3D ret_data;
> +		goto exit;
> +	}
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

[Severity: High]
Will this cause the probe to fail on 0-indexed device tree configurations?

The array comparison logic above this switch strictly checks for 1-indexed
mappings. If the device tree uses a valid 0-indexed scheme (e.g., <0 1 2 3>=
),
it falls through to this default case, causing the probe to fail with -EINV=
AL.

> +			goto exit;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710082630.3940=
40-1-wojciech.dubowik@mt.com?part=3D1
