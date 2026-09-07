Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E140C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 988BB10E73B;
	Mon,  7 Sep 2026 09:44:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YkCJS5iV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7903810E73B
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:44:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48D6F43494;
 Mon,  7 Sep 2026 09:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF29F1F00A3A;
 Mon,  7 Sep 2026 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788774274;
 bh=+BrWoujzTJ5ag6Sdhj9jK3PZplQCciD9f6l3mHPXyQ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YkCJS5iVCfYa2Y1hZtCyDBJ/wyDdjyV8LzlUkU0GMBdc9SteIbitMqRqVwgEn+3/+
 JlIrJOOJVkHS+zIW4rVaaK/2k+Z8RjsAnLMAcpbAx/qtIHC51VZw+Q3/uMxD/4e9sR
 Nvg/nLwG13G6dfI79Wdu7xkl4izlgKlXXPIhH3uY32JM1LdsvVYAk5jrmE2DGYdEYw
 QRIoh6ybsEfvevCXsMy80GSNXzGLVhNlJPpxoPrVAlZTEHx+RBwuGN1DFCcc57z0rK
 QV3yJo6T7umSHBNg7vb0bLbWMIvJt7Akq1dGc0kuzj1TsbiJhGjO31G2JGlWlQyZOs
 yyHr3vijzfyEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] drm/rcar-du: dsi: Support DSC in the pipeline
To: "Tomi Valkeinen" <tomi.valkeinen+renesas@ideasonboard.com>
Cc: wsa+renesas@sang-engineering.com, linux-clk@vger.kernel.org,
 robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-rcar-du-dsc-v6-3-f8ef711a7494@ideasonboard.com>
References: <20260907-rcar-du-dsc-v6-0-f8ef711a7494@ideasonboard.com>
 <20260907-rcar-du-dsc-v6-3-f8ef711a7494@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 09:44:33 +0000
Message-Id: <20260907094433.DF29F1F00A3A@smtp.kernel.org>
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

New issues:
- [High] Missing validation of the assumed DSI bridge pointer and type can =
lead to a NULL pointer dereference or type confusion in rcar_mipi_dsi_pclk_=
enable().

Pre-existing issues:
- [High] The function rcar_mipi_dsi_pclk_enable calls sleeping functions bu=
t is executed from the CRTC atomic_enable callback, violating atomic contex=
t rules.
--

commit daca709dc803d35328aef5637d1cd674b65a8f0a
Author: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Subject: drm/rcar-du: dsi: Support DSC in the pipeline

This patch modifies the DU encoder initialization to support a DSC block=20
between the DU and the DSI. It ensures the DSI bridge is correctly identifi=
ed=20
and stored in the rcdu->dsi[] array by checking the bridge type.

> Enabling DSI clocks on rcar-du needs some tricks as the DU dot clock is
> provided by the DSI. Thus, we call rcar_mipi_dsi_pclk_enable() from the
> crtc, when enabling the crtc.

[Severity: High]
This is a pre-existing issue, but the call path mentioned here executes in
an atomic context and appears to call sleeping functions.

When the display hardware is enabled via a non-blocking modeset, the
rcar_du_crtc_atomic_enable() callback runs in atomic context. It calls
rcar_mipi_dsi_pclk_enable(), which sequentially calls clk_prepare_enable()
(which takes a mutex via the clk API) and rcar_mipi_dsi_startup() which
performs a direct sleep:

drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c:rcar_mipi_dsi_startup()
    usleep_range(400, 500);

Does this violate the atomic context rules by calling sleeping functions
(mutexes and usleep_range) during the atomic CRTC enable callback?

> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c b/drivers/=
gpu/drm/renesas/rcar-du/rcar_du_encoder.c
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
[ ... ]
> @@ -90,9 +90,22 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
>  				drm_bridge_get(bridge);
> =20
>  		if (output =3D=3D RCAR_DU_OUTPUT_DSI0 ||
> -		    output =3D=3D RCAR_DU_OUTPUT_DSI1)
> +		    output =3D=3D RCAR_DU_OUTPUT_DSI1) {
> +			struct drm_bridge *dsi_bridge;
> +
> +			/*
> +			 * When we have a DSC block between the DU and the DSI,
> +			 * the "bridge" points to the DSC. Detect the DSC by looking
> +			 * at the bridge type, and skip the DSC if the bridge is not
> +			 * the DSI bridge.
> +			 */
> +
> +			dsi_bridge =3D bridge->type =3D=3D DRM_MODE_CONNECTOR_DSI ?
> +				     bridge : bridge->next_bridge;
> +
>  			rcdu->dsi[output - RCAR_DU_OUTPUT_DSI0] =3D
> -				drm_bridge_get(bridge);
> +				drm_bridge_get(dsi_bridge);

[Severity: High]
If the bridge is not a DSI bridge (e.g., it is a DSC block), this grabs
bridge->next_bridge without validating if it is non-NULL or if it actually
represents an rcar_mipi_dsi bridge.

If the device tree configures an intermediate bridge before DSI that does n=
ot
have a next_bridge set, or if it points to a non-DSI bridge,
bridge->next_bridge will evaluate to NULL or the wrong bridge. This uncheck=
ed
value is then saved to rcdu->dsi[].

Later, on the modeset path, rcar_du_crtc_atomic_enable() passes this pointer
to rcar_mipi_dsi_pclk_enable(), which directly dereferences bridge->encoder
and casts it to struct rcar_mipi_dsi:

drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c:rcar_mipi_dsi_pclk_enable()
    struct rcar_mipi_dsi *dsi =3D bridge_to_rcar_mipi_dsi(bridge);
    ...
    connector =3D drm_atomic_get_new_connector_for_encoder(state,
                                                         bridge->encoder);

Could this lead to a NULL pointer dereference or type confusion if an
unsupported bridge topology is loaded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-rcar-du-ds=
c-v6-0-f8ef711a7494@ideasonboard.com?part=3D3
