Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C88CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD3E10ECB2;
	Tue, 23 Jun 2026 20:51:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WVVS3Osz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA8810ECB2
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:51:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FF7F41A49;
 Tue, 23 Jun 2026 20:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DC61F000E9;
 Tue, 23 Jun 2026 20:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782247908;
 bh=2r3F2fqRrB3QUJWG7R7MxVMUzAVNliS74R6UCPnQhuM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WVVS3OszbkEGzSzX0Q+ipz3UAFehN1ZbtrulmRF7tdCW7LoWYUuQ8J7fML4dbGYFJ
 wcleOEgqGH48tTnEUC96bz8d/EMwJ8vb04x/cj/MEYLb1Hje8PP/rGYRCiXv/kZDWI
 XIIDtUNzfIfCT3bn0ORZCosmchoe518XITgkFeLUW+duMwBgh7qpjhVISwSpFN6NEc
 fZJ9OLSzLSksUv9qGSFh+gaEc5BqZDQF+OP7HKt5yzokrlrTFdR5/sKNBxh5h0aqyU
 UR2ug4TLWlrADzZb3a2cwi2NuNT4K94dgYZBviilTsDZV3MDj8X7OsIOgn+SR7Hviu
 qZ5Ro9l+lDHWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 09/10] dt-bindings: display: rockchip: dw-dp: fix
 sound DAI cells
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260612-synopsys-dw-dp-improvements-v3-9-dc61e6352508@collabora.com>
References: <20260612-synopsys-dw-dp-improvements-v3-9-dc61e6352508@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:51:47 +0000
Message-Id: <20260623205147.F2DC61F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Unconditionally changing `#sound-dai-cells` from `const: 0` to=
 `const: 1` breaks backward compatibility with existing device tree binarie=
s and causes `make dtbs_check` failures.
- [High] dw_dp_runtime_resume() fails to check the return value of clk_prep=
are_enable() for apb_clk and aux_clk, leading to unclocked hardware accesse=
s.
- [High] The driver ignores the return value of pm_runtime_get_sync() and i=
ts scoped guard wrappers, leading to potential unclocked register accesses.
- [Medium] The `#sound-dai-cells =3D <1>` design is mathematically insuffic=
ient to support the RK3576's 6 DAI interfaces, ensuring future ABI breakage=
 when MST is fully implemented.
--

commit dcfc80f29db8ade71eb0e49550ea25781716e785
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

dt-bindings: display: rockchip: dw-dp: fix sound DAI cells

This commit updates the #sound-dai-cells property to support the two
possible DAI interfaces (I2S and S/PDIF) on RK3588 and RK3576 DesignWare
DisplayPort controllers. It changes the const value to 1 and discusses
options for future Multi Stream Transport (MST) support.

> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,=
dw-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw=
-dp.yaml
> index 2b0d9e23e9432..1303d0e2145a9 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.y=
aml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.y=
aml
> @@ -83,7 +83,8 @@ properties:
>      maxItems: 1
> =20
>    "#sound-dai-cells":
> -    const: 0
> +    const: 1
> +    description: 0 for I2S, 1 for SPDIF

[Severity: Critical]
Does unconditionally changing #sound-dai-cells from const: 0 to const: 1
break backward compatibility with existing device tree binaries?

Existing device trees supplying 0 cells will now fail validation during
make dtbs_check, and older DTBs will no longer conform to the schema.

[Severity: Medium]
Is setting #sound-dai-cells =3D <1> mathematically sufficient to support the
RK3576 hardware?

The commit message mentions the RK3576 features MST with 6 DAIs, so a single
cell constraint only supports 2 states (I2S and S/PDIF). Will this necessit=
ate
another breaking change when MST is implemented?

> =20
>  required:
>    - compatible

[ ... ]

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 36ee6e027af52..7f4f36c614844 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -1651,6 +1657,8 @@ static void dw_dp_bridge_atomic_enable(struct drm_b=
ridge *bridge,
>  	struct drm_connector_state *conn_state;
>  	int ret;
> =20
> +	pm_runtime_get_sync(dp->dev);
> +

[Severity: High]
Does this code discard the return value of pm_runtime_get_sync()?

If the PM core fails to resume the device, the code proceeds with the enable
sequence, which could risk unclocked register accesses later on.

>  	connector =3D drm_atomic_get_new_connector_for_encoder(state, bridge->e=
ncoder);
>  	if (!connector) {
>  		dev_err(dp->dev, "failed to get connector\n");

[ ... ]

> @@ -1725,6 +1734,8 @@ static enum drm_connector_status dw_dp_bridge_detec=
t(struct drm_bridge *bridge,
>  {
>  	struct dw_dp *dp =3D bridge_to_dp(bridge);
> =20
> +	ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
> +
>  	if (!dw_dp_hpd_detect(dp))

[Severity: High]
Does using this unconditional PM scope guard discard the return value?

If the device failed to resume, the code will proceed to access hardware
registers in dw_dp_hpd_detect(), which could trigger a bus fault.

>  		return connector_status_disconnected;
> =20
>  	if (!dw_dp_hpd_detect_link(dp, connector))

[ ... ]

> @@ -2099,6 +2160,26 @@ void dw_dp_unbind(struct dw_dp *dp)
>  }
>  EXPORT_SYMBOL_GPL(dw_dp_unbind);
> =20
> +int dw_dp_runtime_suspend(struct dw_dp *dp)
> +{
> +	clk_disable_unprepare(dp->aux_clk);
> +	clk_disable_unprepare(dp->apb_clk);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_dp_runtime_suspend);
> +
> +int dw_dp_runtime_resume(struct dw_dp *dp)
> +{
> +	clk_prepare_enable(dp->apb_clk);
> +	clk_prepare_enable(dp->aux_clk);
> +

[Severity: High]
Are we ignoring the return values of clk_prepare_enable() here?

If the clocks fail to enable, unconditionally calling dw_dp_init_hw() will
access hardware registers while unclocked, which could lead to a bus hang.

> +	dw_dp_init_hw(dp);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_dp_runtime_resume);

[ ... ]

> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/=
rockchip/dw_dp-rockchip.c
> index 0de822360c8db..1f53228e56d9f 100644
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
> +	ACQUIRE(pm_runtime_active_auto, pm)(dp->dev);
> +
> +	regmap_write(dp->vo_grf, hpd_reg,
> +		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_SEL, dp->hpd_sel));

[Severity: High]
Does this ignore the possibility that the power domain failed to resume?

If the unconditional PM guard fails, writing to the vo_grf syscon will
trigger a bus fault.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-synopsys-d=
w-dp-improvements-v3-0-dc61e6352508@collabora.com?part=3D9
