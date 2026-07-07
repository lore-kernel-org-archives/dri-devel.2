Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7B0C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 04:20:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6190910E1F6;
	Tue,  7 Jul 2026 04:20:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XIT3aAoE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B446A10E1F6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 04:20:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F03740DB5;
 Tue,  7 Jul 2026 04:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42141F000E9;
 Tue,  7 Jul 2026 04:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783398026;
 bh=5Wu4fL6JghK54swZJEkEZ06xtYGdhIdVwbBxVKsB3tA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XIT3aAoEUyjHpy2gFpUTfMcntszycai8uZcOJWDAmQ74fb/UzITr8CKxLlSIKfINn
 tj4aG6kKMzSIKSWhV7ptXdvIBud/B+WfRr+Ae0fJiizcrTQK7YMhyDbp7mx2yPisWa
 Y11eMXMRVTnfbEIs1WvSL3Z3r2UzrwMaI+vOcWvtGk1cSoT8367eGda33TG4CHLRsL
 ++0BrxY9OOg48n9ACpCnC5ozJz/kAz9hBQdT9KZOLHH1qePS9JU7+78HeNRMWmxyRE
 qOaYlfGg+YslzZTASVsIhpkk9w1avKdksTfW3vHz7i89ZGYTAqhEa7fRPhf0KFm0zn
 HeBDJAON3h6pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] drm/bridge: analogix_dp: Add support for
 optional data-lanes mapping
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260707040613.1992841-6-damon.ding@rock-chips.com>
References: <20260707040613.1992841-1-damon.ding@rock-chips.com>
 <20260707040613.1992841-6-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 04:20:25 +0000
Message-Id: <20260707042025.C42141F000E9@smtp.kernel.org>
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
- [High] The `data-lanes` array is interpreted backwards when configuring t=
he `ANALOGIX_DP_LANE_MAP` register, applying the inverse of the intended ha=
rdware lane mapping.
- [High] The external PHY's analog configuration (voltage and pre-emphasis)=
 ignores the logical-to-physical lane mapping.
- [Medium] Mismatched endpoint specifiers are used when counting data lanes=
 versus reading the `data-lanes` property, which could lead to parsing the =
wrong endpoint.
--

--- Patch [5]: [PATCH v6 5/5] drm/bridge: analogix_dp: Add support for opti=
onal data-lanes mapping ---
commit 99a86aa8f074546e71df9c8b7f51f7d473ef6dac
Author: Damon Ding <damon.ding@rock-chips.com>

drm/bridge: analogix_dp: Add support for optional data-lanes mapping
   =20
Parse the optional data-lanes device tree property to support custom physic=
al
lane mapping configuration. If no valid configuration is found, fall back to
the default lane map automatically.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index b69743837092b..5c5cb6148cf6c 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
[ ... ]
> @@ -1234,6 +1234,59 @@ static const struct drm_bridge_funcs analogix_dp_b=
ridge_funcs =3D {
>  static int analogix_dp_dt_parse_lanes_map(struct analogix_dp_device *dp)
>  {
>  	struct video_info *video_info =3D &dp->video_info;
>  	struct device_node *endpoint;
>  	u32 tmp[LANE_COUNT4];
>  	u32 map[LANE_COUNT4] =3D {0, 1, 2, 3};
>  	bool used[LANE_COUNT4] =3D {false};
>  	int num_lanes;
>  	int ret, i;
> =20
>  	memcpy(video_info->lane_map, map, sizeof(map));
> =20
>  	num_lanes =3D drm_of_get_data_lanes_count_ep(dp->dev->of_node, 1, 0, 1,
>  						   video_info->max_lane_count);
>  	if (num_lanes < 0)
>  		return -EINVAL;
> =20
>  	endpoint =3D of_graph_get_endpoint_by_regs(dp->dev->of_node, 1, -1);

[Severity: Medium]
Will this return the correct endpoint if there are multiple endpoints on
port 1?

When counting the data lanes, drm_of_get_data_lanes_count_ep() is called wi=
th
reg =3D 0. However, of_graph_get_endpoint_by_regs() uses reg =3D -1 (wildca=
rd),
which returns the first available endpoint.

If the device tree has multiple endpoints, could this result in counting la=
nes
on one endpoint but reading the data-lanes property from a different one?

>  	if (!endpoint)
>  		return -EINVAL;
> =20
>  	ret =3D of_property_read_u32_array(endpoint, "data-lanes", tmp, num_lan=
es);
>  	of_node_put(endpoint);
>  	if (ret)
>  		return -EINVAL;
> =20
>  	for (i =3D 0; i < num_lanes; i++) {
>  		if (tmp[i] >=3D LANE_COUNT4) {
>  			dev_dbg(dp->dev, "data-lanes[%d] =3D %u is out of range\n", i, tmp[i]=
);
>  			return -EINVAL;
>  		}
> =20
>  		if (used[tmp[i]]) {
>  			dev_dbg(dp->dev, "data-lanes[%d] =3D %u is duplicate\n", i, tmp[i]);
>  			return -EINVAL;
>  		}
> =20
>  		used[tmp[i]] =3D true;
>  		map[i] =3D tmp[i];

[Severity: High]
Does analogix_dp_set_lane_link_training() need to be updated to use this la=
ne
map?

This parsing logic creates a logical-to-physical mapping. However, looking =
at
analogix_dp_set_lane_link_training(), it appears to still use the logical l=
ane
index to populate the physical PHY configuration structure:

	for (lane =3D 0; lane < lane_count; lane++) {
		...
		phy_cfg.dp.voltage[lane] =3D vs;
		phy_cfg.dp.pre[lane] =3D pe;
	...

Will this cause the external PHY to apply the analog settings to the wrong
physical lanes when an asymmetric mapping is used?

>  	}
> =20
>  	for (i =3D 0; i < LANE_COUNT4 && num_lanes < LANE_COUNT4; i++) {
>  		if (!used[i])
>  			map[num_lanes++] =3D i;
>  	}
[ ... ]
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/=
gpu/drm/bridge/analogix/analogix_dp_reg.c
> index 38fd8d5014d29..45c7652645a13 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
[ ... ]
> @@ -48,16 +48,15 @@ void analogix_dp_stop_video(struct analogix_dp_device=
 *dp)
>  void analogix_dp_lane_mapping(struct analogix_dp_device *dp)
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
Does this logic configure the lane mapping backwards?

The lane map parsed from the device tree establishes lane_map[logical] =3D
physical. However, this register assignment shifts the physical lane index
(lane_map[i]) by the shift for the physical lane's register field
(LANEi_MAP_SHIFT).

Because the hardware register expects the logical lane number to be written
to the physical lane's bitfield, won't this write the physical lane number
into the physical lane's field instead? This effectively applies the inverse
permutation and could break output for any asymmetric lane mappings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707040613.1992=
841-1-damon.ding@rock-chips.com?part=3D5
