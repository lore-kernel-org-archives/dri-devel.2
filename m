Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC24CD6E57
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC3FC113DFC;
	Thu,  4 Jun 2026 09:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lPE307I3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E63113DFC
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 09:04:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B19E96014B;
 Thu,  4 Jun 2026 09:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3003E1F00893;
 Thu,  4 Jun 2026 09:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780563859;
 bh=+fLXV4pvkD+MbfAV1J1L+L3bo7Dsh9tsoeEEPsNbQyc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lPE307I3m0d/ILEy0r17KTgqtKH3Pgf/x+Nn25Wt16hBhR4qd5qEBGoVsfZu+klkh
 Q/8a52mw6fMC8aveKfTPSQ3XgCVgWIwcAK5RH4+kwa1zH/D67+GIgyb3LFP388t77T
 MjOnm6XacCrY7v6db1ZWjNX/x84+SFIzyKoNwruhY6MsCwo8owRj6hnEHGs3tE7hun
 /yukH4wvMjvKGSgVyRXnxQIei/OOdUwCqrH9Hh7dTHHR3j72EWRz6+FySCU8IggNNg
 4GkEsEefXUyak0yjCpMTR2IQsm1A7JaniaivCmeH29r36a7aLO8bpV5D6zRPkHbT6X
 v1zKTcVY/mkQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] drm/bridge: analogix_dp: Add support for
 optional data-lanes mapping
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260604085220.2862986-5-damon.ding@rock-chips.com>
References: <20260604085220.2862986-5-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 09:04:18 +0000
Message-Id: <20260604090419.3003E1F00893@smtp.kernel.org>
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
- [High] The logic-to-physical lane mapping is mathematically inverted when=
 programming the hardware, breaking support for asymmetric lane swap config=
urations.
- [Medium] Inconsistent endpoint resolution when reading the data-lanes pro=
perty.
--

commit b6abf6d746df1b04ca60b36cd37e77da204d915a
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Add support for optional data-lanes mapping
   =20
Parse the optional 'data-lanes' device tree property to support
custom physical lane mapping configuration. If no valid configuration
is found, fall back to the default lane map automatically.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index f23c2ae6e10d0..2dfe7de5d3101 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1234,6 +1234,59 @@ static const struct drm_bridge_funcs analogix_dp_b=
ridge_funcs =3D {

[ ... ]

> +static int analogix_dp_dt_parse_lanes_map(struct analogix_dp_device *dp)
> +{
> +	struct video_info *video_info =3D &dp->video_info;
> +	struct device_node *endpoint;
> +	u32 tmp[LANE_COUNT4];
> +	u32 map[LANE_COUNT4] =3D {0, 1, 2, 3};
> +	bool used[LANE_COUNT4] =3D {false};
> +	int num_lanes;
> +	int ret, i;
> +
> +	memcpy(video_info->lane_map, map, sizeof(map));
> +
> +	num_lanes =3D drm_of_get_data_lanes_count_ep(dp->dev->of_node, 1, 0, 1,
> +						   video_info->max_lane_count);
> +	if (num_lanes < 0)
> +		return -EINVAL;
> +
> +	endpoint =3D of_graph_get_endpoint_by_regs(dp->dev->of_node, 1, -1);

[Severity: Medium]
Will this result in reading from an inconsistent endpoint if port 1 has
multiple endpoints?

The call to drm_of_get_data_lanes_count_ep() above explicitly passes 0
for the endpoint reg, but this call uses -1. If there are multiple
endpoints, this could return the first one it finds rather than endpoint@0,
which might lead to reading the lane map from a different endpoint than
the one used for the count.

> +	if (!endpoint)
> +		return -EINVAL;
> +
> +	ret =3D of_property_read_u32_array(endpoint, "data-lanes", tmp, num_lan=
es);

[ ... ]

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/=
gpu/drm/bridge/analogix/analogix_dp_reg.c
> index 38fd8d5014d29..45c7652645a13 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -48,16 +48,15 @@ void analogix_dp_stop_video(struct analogix_dp_device=
 *dp)
>  	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
>  }
> =20
> -void analogix_dp_lane_swap(struct analogix_dp_device *dp, bool enable)
> +void analogix_dp_lane_mapping(struct analogix_dp_device *dp)
>  {
> +	u32 *lane_map =3D dp->video_info.lane_map;
>  	u32 reg;
> =20
> -	if (enable)
> -		reg =3D LANE3_MAP_LOGIC_LANE_0 | LANE2_MAP_LOGIC_LANE_1 |
> -		      LANE1_MAP_LOGIC_LANE_2 | LANE0_MAP_LOGIC_LANE_3;
> -	else
> -		reg =3D LANE3_MAP_LOGIC_LANE_3 | LANE2_MAP_LOGIC_LANE_2 |
> -		      LANE1_MAP_LOGIC_LANE_1 | LANE0_MAP_LOGIC_LANE_0;
> +	reg =3D lane_map[0] << LANE0_MAP_SHIFT;
> +	reg |=3D lane_map[1] << LANE1_MAP_SHIFT;
> +	reg |=3D lane_map[2] << LANE2_MAP_SHIFT;
> +	reg |=3D lane_map[3] << LANE3_MAP_SHIFT;

[Severity: High]
Does this logic mathematically invert the lane mapping for asymmetric
configurations?

The device tree data-lanes property specifies a mapping from logical to
physical lanes, so that lane_map[logical_lane] =3D physical_lane.
However, when programming the hardware, it expects the logical lane index
to be placed into the bit-field corresponding to the physical lane.

Here, the code shifts the physical lane number by the logical lane's
bit-shift, effectively programming the logical lane into the physical lane's
field. This happens to work by coincidence for symmetric mappings like
<3 2 1 0> or <0 1 2 3>, but it will corrupt asymmetric configurations
like <1 2 3 0>.

Should the logical lane index instead be shifted into the physical lane's
bit-field? For example, using reg |=3D i << (lane_map[i] * 2).

> =20
>  	writel(reg, dp->reg_base + ANALOGIX_DP_LANE_MAP);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604085220.2862=
986-1-damon.ding@rock-chips.com?part=3D4
