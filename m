Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80631C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1DCC10E411;
	Fri, 17 Jul 2026 11:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P5XjCl66";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB95610E411
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:56:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 555EC60204;
 Fri, 17 Jul 2026 11:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58A61F000E9;
 Fri, 17 Jul 2026 11:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784289391;
 bh=cYZOuGCvi66JpK5LVBGPeRGprF1YQZAERovHARU+/Q8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P5XjCl66gRxAGcP2pAB1E47BZl+K/t+bjDEEmXXpqygjNfva4yykqP7duf+QQ5HhR
 bbL/NHpkbuWling7PQbV58/3BZ3lXoIyi+aHhHMaFS8a8TtQt02RQrHZj9Ymayfs3t
 ZWdcvtWi0mgIe0Eso7YZcmW3s1WjGp0wJbXenlhDg7K2Qbz9HkLmZI2AEScni93tuN
 2N/JeeryIR67rzH0Muo/FAlgZzcXugjB//J4GVoy3+8Ogp5aH9Dbv0NnK83QlowNzr
 ycI+HlJZR+3Y3/O71KZdEk9hzTZgzwzO8IIbUAYO89E4QBz/JOJ7YPA2O7+3h4F3A7
 Af8kevoOOiy8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] drm/bridge: ti-sn65dsi83: Add reversed lvds
 lanes support
To: "Wojciech Dubowik" <wojciech.dubowik@mt.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260717115002.308035-4-wojciech.dubowik@mt.com>
References: <20260717115002.308035-1-wojciech.dubowik@mt.com>
 <20260717115002.308035-4-wojciech.dubowik@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 11:56:30 +0000
Message-Id: <20260717115630.C58A61F000E9@smtp.kernel.org>
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
- [Medium] `memcmp()` is called with `ARRAY_SIZE(data_lanes)` instead of `s=
izeof(data_lanes)`, causing it to compare only the first element of the `u3=
2` array.
--

--- Patch [3]: [PATCH v5 3/3] drm/bridge: ti-sn65dsi83: Add reversed lvds l=
anes support ---
commit 5b0901160799f83c03f127b68580169dd845ac90
Author: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

drm/bridge: ti-sn65dsi83: Add reversed lvds lanes support

This commit adds support for parsing an optional "data-lanes" device tree
property. It allows the driver to configure the ti-sn65dsi83 chip for
reversed output LVDS lane order.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index f8a786953526d..df44df2e872af 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c

[ ... ]

> @@ -845,6 +863,19 @@ static int sn65dsi83_parse_lvds_endpoint(struct sn65=
dsi83 *ctx, int channel)
>  	else
>  		return -EINVAL;
> =20
> +	ret_data =3D of_property_read_u32_array(endpoint, "data-lanes", data_la=
nes,
> +			ARRAY_SIZE(data_lanes));
> +	if (!ret_data) {
> +		if (memcmp(data_lanes,
> +				supported_data_lane_mapping[LANE_MAPPING_REVERSE],
> +				ARRAY_SIZE(data_lanes)) =3D=3D 0)

[Severity: Medium]
Does this code compare the entire array? memcmp() expects the length in
bytes, but ARRAY_SIZE(data_lanes) evaluates to 4 (the number of elements).

Because data_lanes is an array of u32, checking only 4 bytes means only
the first element is compared. Should this be using sizeof(data_lanes)
instead?

> +			ctx->lvds_reverse_lanes_conf[channel] =3D true;
> +		else if (memcmp(data_lanes,
> +			   supported_data_lane_mapping[LANE_MAPPING_NORMAL],
> +			   ARRAY_SIZE(data_lanes)) !=3D 0)

[Severity: Medium]
The same question applies here. Because only the first element is verified,
would an invalid device tree configuration like <4 0 0 0> erroneously match
LANE_MAPPING_REVERSE and bypass the expected validation?

> +			return dev_err_probe(dev, -EINVAL, "invalid data lanes mapping\n");
> +	}
> +
>  	ret_data =3D of_property_read_u32_array(endpoint, "ti,lvds-vod-swing-da=
ta-microvolt",
>  					lvds_vod_swing_data, ARRAY_SIZE(lvds_vod_swing_data));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717115002.3080=
35-1-wojciech.dubowik@mt.com?part=3D3
