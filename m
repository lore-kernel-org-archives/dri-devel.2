Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005CF606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeiR2Hy4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E7A10EC2C;
	Tue, 20 Oct 2026 23:31:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C171B10EC2C
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 23:31:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E74B160098;
 Tue, 20 Oct 2026 23:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D691F000CA;
 Tue, 20 Oct 2026 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792539064;
 bh=WyTydnEI7HaZcYU8Jg8Dgk33OVrWs9PmKRbuXg17Oyw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EeiR2Hy4d4o/s/Rjqykrd8x8aJE3gcmxa3ZvBSN2zlwBCU+KaCsM+YvSB3xEQzBW3
 wkYsmSZH44UltBNiPI4Dk0iBdyrlkdDSLr+nfww91a/0SyhqPj6ej6xeSICEEMAme4
 rsESQJFAmJqwzlj9fCEOjH9Avb0BtpQtZtAPqlRt+U+7iyx70sxHt/ATgSyZL8DZJC
 i4JWEl7TADOlI585o4hJcbtfn1oN2Q71nEEK5Qs3BidT+EBT9T6EogIRn3N/z4+m/w
 5veoUoyL+Jl+zj9tAg5jLGI3VZJ1cNr/VpbTysy72iQi50Oi3NAt//EkN5KI8nZXkK
 iBL9gs3W4Aeaw==
Message-ID: <sashiko-outbox-179604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] arm64: dts: imx8dxl-evk: add lcdif overlay
To: Frank.Li@oss.nxp.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261020-dxl_lcdif-v3-7-adc944659e14@nxp.com>
References: <20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com>
 <20261020-dxl_lcdif-v3-7-adc944659e14@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 23:31:03 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] arm64: dts: imx8dxl-evk: invalid and ignored bus-width in adma_lcd=
if endpoint
- [Medium] arm64: dts: imx8dxl-evk: incomplete audio disabling in lcdif ove=
rlay
--

commit 99ed2360e1f19a7e9e6652f9b6385f7a7a06174f
Author: Frank Li <Frank.Li@nxp.com>

arm64: dts: imx8dxl-evk: add lcdif overlay

This commit adds a device tree overlay to support the waiken,101wx001-wct L=
CD
panel on the i.MX8DXL EVK board, configuring the LCDIF controller pins and
disabling conflicting peripherals.

> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif-101wx001.dts=
o b/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif-101wx001.dtso
> new file mode 100644
> index 0000000000000..39abf9b3884ea
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif-101wx001.dtso
> @@ -0,0 +1,119 @@

[ ... ]

> +&acm {
> +	status =3D "disabled";
> +};
> +
> +&adma_lcdif {
> +	pinctrl-0 =3D <&pinctrl_lcdif>, <&lcd_0_fun>, <&lcd_1_fun>, <&lcd_2_fun=
>, <&lcd_3_fun>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +
> +	port {
> +		lcdif_out: endpoint {
> +			bus-width =3D <18>;
> +			remote-endpoint =3D <&panel_in>;
> +		};
> +	};
> +};

[Severity: High]
Is bus-width =3D <18> in lcdif_out valid for the fsl,lcdif binding or handl=
ed
by the mxsfb driver?

In Documentation/devicetree/bindings/display/fsl,lcdif.yaml, the port
property references /schemas/graph.yaml#/properties/port directly without
video-interfaces.yaml:

  port:
    $ref: /schemas/graph.yaml#/properties/port
    description: The LCDIF output port

Because /schemas/graph.yaml#/properties/port enforces additionalProperties:
false on endpoint nodes, adding bus-width =3D <18> causes dtbs_check schema
validation to fail on imx8dxl-evk-lcdif-101wx001.dtb.

In addition, neither mxsfb, drm_panel_bridge, nor panel-simple parses
bus-width from the endpoint node. When mxsfb_crtc_atomic_enable() calls
mxsfb_set_formats() in drivers/gpu/drm/mxsfb/mxsfb_kms.c, the hardware bus
width is selected from bridge_state->input_bus_cfg.format:

	switch (bus_format) {
	case MEDIA_BUS_FMT_RGB565_1X16:
		ctrl |=3D CTRL_BUS_WIDTH_16;
		break;
	case MEDIA_BUS_FMT_RGB666_1X18:
		ctrl |=3D CTRL_BUS_WIDTH_18;
		break;
	case MEDIA_BUS_FMT_RGB888_1X24:
		ctrl |=3D CTRL_BUS_WIDTH_24;
		break;

Since waiken_101wx001_panel in drivers/gpu/drm/panel/panel-simple.c sets
bus_format to MEDIA_BUS_FMT_RGB888_1X24:

static const struct panel_desc waiken_101wx001_panel =3D {
	...
	.bus_format =3D MEDIA_BUS_FMT_RGB888_1X24,
	.connector_type =3D DRM_MODE_CONNECTOR_DPI,
	.bus_flags =3D DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
};

mxsfb_set_formats() will program CTRL_BUS_WIDTH_24 instead of
CTRL_BUS_WIDTH_18 even though only 18 data lines (D00..D17) are wired in
pinctrl_lcdif, dropping the upper 6 bits of each pixel.

[ ... ]

> +&sai0 {
> +	status =3D "disabled";
> +};
> +
> +&sai1 {
> +	status =3D "disabled";
> +};
> +
> +&wm8960_1 {
> +	status =3D "disabled";
> +};
> +
> +&wm8960_2 {
> +	status =3D "disabled";
> +};
> +
> +&wm8960_3 {
> +	status =3D "disabled";
> +};

[Severity: Medium]
Should this overlay also disable the remaining audio nodes in
arch/arm64/boot/dts/freescale/imx8dxl-evk.dts and
arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi that depend on &acm, &sai0,
&sai1, and &wm8960_1..&wm8960_3?

Because of_link_to_phandle() in drivers/of/property.c does not create
fw_devlink links to suppliers with status =3D "disabled", the enabled consu=
mer
devices still attempt to probe when this overlay is applied:

1. The audio LPCG nodes in arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
(spdif0_lpcg, sai0_lpcg, sai1_lpcg, sai2_lpcg, sai3_lpcg, mclkout0_lpcg,
mclkout1_lpcg, and mqs0_lpcg) remain enabled and reference disabled &acm. In
drivers/clk/imx/clk-imx8qxp-lpcg.c, imx8qxp_lpcg_clk_probe() ->
imx_lpcg_parse_clks_from_dt() fails with -ENODEV:

	ret =3D of_clk_parent_fill(np, parent_names, count);
	if (ret !=3D count) {
		dev_err(&pdev->dev, "failed to get clock parent names\n");
		return count;
	}

2. &asrc0, &sai2, and &sai3 remain enabled in
arch/arm64/boot/dts/freescale/imx8dxl-evk.dts and fail clock acquisition in
fsl_asrc_probe() and fsl_sai_probe() because their parent clocks in &acm,
sai2_lpcg, and sai3_lpcg are unavailable.

3. The four sound card nodes in arch/arm64/boot/dts/freescale/imx8dxl-evk.d=
ts
(sound-bt-sco, sound-wm8960-1, sound-wm8960-2, and sound-wm8960-3) remain
enabled while referencing the disabled &sai0, &sai1, and &wm8960_1..&wm8960=
_3
nodes:

	sound-bt-sco {
		compatible =3D "simple-audio-card";
		...
		btcpu: simple-audio-card,cpu {
			sound-dai =3D <&sai0>;
		...
	};

	sound-wm8960-1 {
		compatible =3D "fsl,imx-audio-wm8960";
		model =3D "wm8960-audio";
		audio-cpu =3D <&sai1>;
		audio-codec =3D <&wm8960_1>;
		audio-asrc =3D <&asrc0>;

causing simple_probe(), fsl_asoc_card_probe(), and graph_probe() to defer
probe indefinitely on boot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-dxl_lcdif-=
v3-0-adc944659e14@nxp.com?part=3D7
