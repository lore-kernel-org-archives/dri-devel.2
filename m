Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E2FCD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8968C113253;
	Mon,  1 Jun 2026 11:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="aGhxFuf4";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B25113253
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 11:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780315177; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=U1Syv7zfhXvwwo1exj8uJZCBU7MyWW3QbmsuUB1gXj1nEp9FC7yI2ixf5+TtKrQX8mwcdFCr2tiZ6EFX2TzYMloTXk2ChRHVV6Xw7u0RLQmGvplSsDaNZXhxQ4wY9skgtTL7TORSXfSQgtr61CzpjspbLHZKncILsqtrdMLqkjQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780315177;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DIMM/UuiKwfx/YeG9zdQSBbNa1KLdJ52JXl7ajReGSM=; 
 b=lwJOkuTR5VjGe+KvnVblShkU0ytUU6TMpQ+FoaDTPT/4ZxozaGdAvwct91RE18k/izj3oKGp+U7mH15lWZYIkxBOVWNjMust257gfykB5vMefa7NljZ/8Vo1mg7wyUch/hv3nrH9NUC0SyWoD1O98H6igfehzSxlEMHP8tQyWfw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780315177; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=DIMM/UuiKwfx/YeG9zdQSBbNa1KLdJ52JXl7ajReGSM=;
 b=aGhxFuf48cjhVftQG1KkPTLUSnFnLenyMVbHbJ7S1yzD64VRSkAl/JoYjEhqx6l0
 FTNwJ4tL+jVa8Gf4iBqOZtKkZcOzKDCKlYEbnJSgc9sTRgJ1RnJwlAVpIYXtu/xXSiC
 9j2b/E6G1MLH/MuX+FS+mi98jo42edRdpOeoA6bE=
Received: by mx.zohomail.com with SMTPS id 1780315176260511.75002317945086;
 Mon, 1 Jun 2026 04:59:36 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id E0298181D80; Mon, 01 Jun 2026 13:59:29 +0200 (CEST)
Date: Mon, 1 Jun 2026 13:59:29 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, 
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 nicolas.frattaroli@collabora.com, cristian.ciocaltea@collabora.com, 
 dmitry.baryshkov@oss.qualcomm.com, luca.ceresoli@bootlin.com,
 dianders@chromium.org, 
 m.szyprowski@samsung.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] drm/bridge: analogix_dp: Add support for optional
 data-lanes mapping
Message-ID: <ah1zPfYFYYLNzbqV@venus>
References: <20260529040530.741336-1-damon.ding@rock-chips.com>
 <20260529040530.741336-4-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t74ugcorb2thls5c"
Content-Disposition: inline
In-Reply-To: <20260529040530.741336-4-damon.ding@rock-chips.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/280.300.36
X-ZohoMailClient: External
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


--t74ugcorb2thls5c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/3] drm/bridge: analogix_dp: Add support for optional
 data-lanes mapping
MIME-Version: 1.0

Hi,

On Fri, May 29, 2026 at 12:05:30PM +0800, Damon Ding wrote:
> Parse the optional 'data-lanes' device tree property to support
> custom physical lane mapping configuration.
>=20
> If no valid configuration is found, fall back to the default
> lane map (0, 1, 2, 3) automatically and keep the driver running.
>=20
> Lane mapping is mainly used for below scenarios:
> 1. Correct PCB lane swap and differential line routing crossover
>    without hardware changes;
> 2. Adapt mismatched lane pin definitions between SoC and eDP panel;
> 3. Support multiple panel hardware variants on the same board
>    by configuring data-lanes in device tree only.
>=20
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>=20
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>=20
> Changes in v2:
> - Add lane mapping application scenarios in commit message.
> ---
>  .../drm/bridge/analogix/analogix_dp_core.c    | 56 +++++++++++++++++++
>  .../drm/bridge/analogix/analogix_dp_core.h    |  4 +-
>  .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 15 +++--
>  .../gpu/drm/bridge/analogix/analogix_dp_reg.h |  4 ++
>  4 files changed, 70 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 699a7f380c56..b2e729850391 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1234,6 +1234,59 @@ static const struct drm_bridge_funcs analogix_dp_b=
ridge_funcs =3D {
>  	.detect =3D analogix_dp_bridge_detect,
>  };
> =20
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
> +	if (!endpoint)
> +		return -EINVAL;
> +
> +	ret =3D of_property_read_u32_array(endpoint, "data-lanes", tmp, num_lan=
es);
> +	of_node_put(endpoint);
> +	if (ret)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < num_lanes; i++) {
> +		if (tmp[i] >=3D LANE_COUNT4) {
> +			dev_dbg(dp->dev, "data-lanes[%d] =3D %u is out of range\n", i, tmp[i]=
);
> +			return -EINVAL;
> +		}
> +
> +		if (used[tmp[i]]) {
> +			dev_dbg(dp->dev, "data-lanes[%d] =3D %u is duplicate\n", i, tmp[i]);
> +			return -EINVAL;
> +		}
> +
> +		used[tmp[i]] =3D true;
> +		map[i] =3D tmp[i];
> +	}
> +
> +	for (i =3D 0; i < LANE_COUNT4 && num_lanes < LANE_COUNT4; i++) {
> +		if (!used[i])
> +			map[num_lanes++] =3D i;
> +	}
> +
> +	dev_dbg(dp->dev, "Using parsed lane map: <%u %u %u %u>\n", map[0], map[=
1], map[2], map[3]);
> +
> +	memcpy(video_info->lane_map, map, sizeof(map));
> +
> +	return 0;
> +}
> +
>  static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
>  {
>  	struct device_node *dp_node =3D dp->dev->of_node;
> @@ -1274,6 +1327,9 @@ static int analogix_dp_dt_parse_pdata(struct analog=
ix_dp_device *dp)
>  		break;
>  	}
> =20
> +	if (analogix_dp_dt_parse_lanes_map(dp))
> +		dev_dbg(dp->dev, "No valid data-lanes found, using default lane map\n"=
);
> +
>  	return 0;
>  }
> =20
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.h
> index 17347448c6b0..634fad241e69 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> @@ -137,6 +137,8 @@ struct video_info {
> =20
>  	int max_link_rate;
>  	enum link_lane_count_type max_lane_count;
> +
> +	u32 lane_map[LANE_COUNT4];
>  };
> =20
>  struct link_train {
> @@ -175,7 +177,7 @@ struct analogix_dp_device {
>  /* analogix_dp_reg.c */
>  void analogix_dp_enable_video_mute(struct analogix_dp_device *dp, bool e=
nable);
>  void analogix_dp_stop_video(struct analogix_dp_device *dp);
> -void analogix_dp_lane_swap(struct analogix_dp_device *dp, bool enable);
> +void analogix_dp_lane_mapping(struct analogix_dp_device *dp);
>  void analogix_dp_init_analog_param(struct analogix_dp_device *dp);
>  void analogix_dp_init_interrupt(struct analogix_dp_device *dp);
>  void analogix_dp_reset(struct analogix_dp_device *dp);
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/=
gpu/drm/bridge/analogix/analogix_dp_reg.c
> index 38fd8d5014d2..45c7652645a1 100644
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
> =20
>  	writel(reg, dp->reg_base + ANALOGIX_DP_LANE_MAP);
>  }
> @@ -140,7 +139,7 @@ void analogix_dp_reset(struct analogix_dp_device *dp)
> =20
>  	usleep_range(20, 30);
> =20
> -	analogix_dp_lane_swap(dp, 0);
> +	analogix_dp_lane_mapping(dp);
> =20
>  	writel(0x0, dp->reg_base + ANALOGIX_DP_SYS_CTL_1);
>  	writel(0x40, dp->reg_base + ANALOGIX_DP_SYS_CTL_2);
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h b/drivers/=
gpu/drm/bridge/analogix/analogix_dp_reg.h
> index 12735139046c..ac914e37089b 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h
> @@ -209,6 +209,10 @@
>  #define LANE0_MAP_LOGIC_LANE_1			(0x1 << 0)
>  #define LANE0_MAP_LOGIC_LANE_2			(0x2 << 0)
>  #define LANE0_MAP_LOGIC_LANE_3			(0x3 << 0)
> +#define LANE3_MAP_SHIFT				(6)
> +#define LANE2_MAP_SHIFT				(4)
> +#define LANE1_MAP_SHIFT				(2)
> +#define LANE0_MAP_SHIFT				(0)
> =20
>  /* ANALOGIX_DP_ANALOG_CTL_1 */
>  #define TX_TERMINAL_CTRL_50_OHM			(0x1 << 4)
> --=20
> 2.34.1
>=20

--t74ugcorb2thls5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmoddCEACgkQ2O7X88g7
+poaCQ//T78V/qc8Cf73l6MRp6lUG032nhDoN6X5opJBT/O4rt8pXA1BBah+QUlS
Jak5Y/RU4d9Ho9lu3EG2DJMDIeEuI9PcHORVGRXsTlDt1+WvVzcGsiDhxpUrJ5hP
eyszyt/z6GmRJ/WIj+PQunwssofNoKtA5CxeNAv8K8e9euGYu5A4YVqODHmb6rlj
V5eOc8rVY9EHKAWa5q3adANnAyR18zItfQ3zu2Fqz3flV/h/MxmtHrhYp/dHcp2F
uspj8JWQA4sRJaIHhyQVRUI4bQjtxscVDlJCGr9pJOgnEJx7ivRmeXIfUaSXKnMD
g4YcTxh3oRVj0mI3GAhfOXvMTloMub+DZ4v/dxRp/R255D5sx94DtiMHdBxGH6f2
eU2Ny/VCeLSfPq42kR7RD8Tfg5udQEpQ+CCjLaNduZDOFgYJjP45G6L+ogGqHs7L
osXOatEeey1LfK3bLV6FZXIySDEJrz4jPsW6nkCrfcf3S6hQpoqz4qoPLB6TGjqb
ryK+AB0v1StH6AJh3bR8qjD2r4HNYSAtRCPkIBAnzX9YNhLhD4WmPrsQ9O0iT2PD
kJtIUDzmnGDTbY0uZ6CxtgQLfaO0mXX18hhO+LsRq1wQvVnQg2Pb5hvFVZfYZVdv
6z1qAeNg4deE8A4fPnkbiPnQ02qwsu3zmy0MBfd/r5NpkxCN/Ac=
=+lYi
-----END PGP SIGNATURE-----

--t74ugcorb2thls5c--
