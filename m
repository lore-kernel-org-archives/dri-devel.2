Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6716CD8CA8
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 00:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0870810E149;
	Mon, 15 Jun 2026 00:17:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hoNvYfSG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B05610E149
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 00:17:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 42CBE40836;
 Mon, 15 Jun 2026 00:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20EF1F000E9;
 Mon, 15 Jun 2026 00:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781482652;
 bh=bkg4OeOIcwwOnOaOevDw5KNxb45k8KO+LmgAiyCyxvs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hoNvYfSGTQog8EySiAHhquR1AWGjHCyDGOKTfdPFLKAVk5kN4xewKNZBybxxBTR1k
 pIHDEilwZSo+FB4+X42FTgu+Rf7cxgiWoInbrzTrEh++Xeq7bRjtxPLUce/0R+L3pr
 x9guBHrvHnU+Ktwz6ToSVG1fUQONvpw8Am0L4ulZiL6OGhSjfeEHDbykGN1t9wWl9A
 GXW+heUrBHn463UzMzaIa5MAB4zHO0lyN9NPjJTLeQUNACHgdB6ZUwSYlGejw3vLEs
 EwTXzMzVkhccNzX9eNaAMWduNrrnDbBWvKA2vYwzZGuATkiyH71BhdsreYb7TISING
 WkKaNgiUTh1zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: display: panel: Add documentation
 for lg,sw49410-lh609qh1
To: "Paul Sajna" <sajattack@postmarketos.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260614-judyln-panel-v3-2-07f4134441bd@postmarketos.org>
References: <20260614-judyln-panel-v3-2-07f4134441bd@postmarketos.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 00:17:30 +0000
Message-Id: <20260615001731.E20EF1F000E9@smtp.kernel.org>
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
- [High] Sending DSI commands in `unprepare` after asserting the reset GPIO=
 will cause DSI transmission timeouts.
- [High] The `MIPI_DSI_MODE_LPM` flag toggle for the PPS transfer is wrappe=
d around the wrong function, rendering it ineffective.
- [Medium] The `compatible` property definition enforces an incorrect gener=
ic-first string order and mismatches the device tree example, causing valid=
ation to fail.
--

commit faf055f392f23751b6b923b1d2e80556b912da18
Author: Paul Sajna <sajattack@postmarketos.org>

dt-bindings: display: panel: Add documentation for lg,sw49410-lh609qh1

This commit documents the bindings for the LG LH609QH1 MIPI DSI panel. It
also introduces the DRM panel driver for the SW49410 controller found in the
LG G7 ThinQ smartphone.

> diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw49410.y=
aml b/Documentation/devicetree/bindings/display/panel/lg,sw49410.yaml
> new file mode 100644
> index 0000000000000..4c4bf4d89353f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/lg,sw49410.yaml
> @@ -0,0 +1,79 @@
[ ... ]
> +properties:
> +  compatible:
> +    items:
> +      - const: lg,sw49410
> +      - const: lg,sw49410-lh609qh1

[Severity: Medium]
Does the compatible array enforce a generic-to-specific order?

Device tree standard typically dictates specific-to-generic ordering.
Additionally, since the device tree example further down only provides a
single string:

	compatible =3D "lg,sw49410-lh609qh1";

Will this single-string example fail validation against the two-item schema
constraint defined here?

> +
> +  reg:
[ ... ]
> diff --git a/drivers/gpu/drm/panel/panel-lg-sw49410.c b/drivers/gpu/drm/p=
anel/panel-lg-sw49410.c
> new file mode 100644
> index 0000000000000..02d1b85c3affb
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-lg-sw49410.c
> @@ -0,0 +1,528 @@
[ ... ]
> +static int sw49410_panel_program(struct sw49410_panel *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +	struct drm_dsc_picture_parameter_set pps;
[ ... ]
> +	ctx->dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +
> +	drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
> +
> +	ctx->dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);

[Severity: High]
Are the MIPI_DSI_MODE_LPM flags being toggled around the right function?

This code wraps the local memory packing function drm_dsc_pps_payload_pack()
instead of the actual transmission function
mipi_dsi_picture_parameter_set_multi().=20

Does this mean the PPS command is still incorrectly sent in low-power mode?

> +
> +	mipi_dsi_compression_mode_ext_multi(&dsi_ctx, true, MIPI_DSI_COMPRESSIO=
N_DSC, 1);
[ ... ]
> +static int sw49410_panel_unprepare(struct drm_panel *panel)
> +{
> +	struct sw49410_panel *ctx =3D to_sw49410_panel(panel);
> +
> +	gpiod_set_value(ctx->reset_gpio, 1);
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);

[Severity: High]
Could asserting the reset GPIO before sending DSI commands lead to
transmission timeouts?

Because the panel is already put into reset by gpiod_set_value(..., 1),
it seems like it won't be able to acknowledge the display_off and
enter_sleep_mode commands sent immediately after.

> +	mipi_dsi_msleep(&dsi_ctx, 100);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614-judyln-pan=
el-v3-0-07f4134441bd@postmarketos.org?part=3D2
