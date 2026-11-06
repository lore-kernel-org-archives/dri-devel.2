Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14CB606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=XkdRU4zo;
	dkim=fail reason="signature verification failed" header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=qpH3MdGs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CBB610E2AE;
	Fri,  6 Nov 2026 11:00:10 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B9910E2AE
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 11:00:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793962788; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=NwcPFHMFrsNg1/QznMSw+AMqk2RvbLOOyR7U5n8/gkz3rA4Uo+110xTdnyai8ICaO2
 wy/f30ByyRysIlEhSg0/AUbRQQCP9+jQUtohv5+mSoffsCtv7aBSMDrgbgUxjw5OWH9P
 +a3+wh2YzZHCPTxa4XNUQVA2B/a+Q0P6i7fS+GOKus+K/RuEqpH1gUBhmFMIBf3RWFoH
 IL48iLPG8QP9SP9M3/blfz3V3qzbT1PTR7cBAtFzfNMBcuKYwlSc5q8pZlRMISmAAMA8
 h52Uwb9BBpm+0ekkRkN1tlE7h0uYKkYM2mfaGQcMQ6sNdyzyung+Jq3Npw8PWP6kOgpq
 9Lhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793962788;
 s=strato-dkim-0002; d=strato.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=z0or9Ayyy8lz4U+Tnkzn/bhcEkn9Da7YqzGnhtayipM=;
 b=X1fCFxyUZj5+YzngM8+Q+hbiRAoXH/8S/v0X57KM/SAXiwSFV3WMNJ2L/h4yNcHVv8
 Gcs6SamuiRQDnTyaNDUETq0PQPBZiZfWF4v2+nmrq0wJe/4I1UEP/FuPpcXdJ/nvjA0S
 SFoD7yUDpFeXXkjK1e7E1QfAvy9vnZZI2e6VOpkprtyVrmNKkKXALob7QltZ3gxd1XpE
 xuJ8m1hCkzku35jOQHyW5iN8stdLN57jwNA29spLBpZUeoRDs4+VpCVQDbo0lfvr0gj1
 +A/fupvf/te8HVZf1xniaHV18szj8EPoxqtjCq2O5u8R9kXAdRXlCPobrbmXP6CWZS3m
 tkXw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793962788;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=z0or9Ayyy8lz4U+Tnkzn/bhcEkn9Da7YqzGnhtayipM=;
 b=XkdRU4zoB0ibcFbozQY01LAigHtjUCLBDtTw4R0FpR94lgoTIJUa3aoPDPUaTbUSLx
 aVYfiQoArnwEcEbINyzvURHzCmeIbK5p3yUtxdhUzjR3E6QAJVR2h9buq6QQ1W7IuRFS
 YxvYJNNpYolkjIQpCWhZ0BhmLmx0y/3HnPAtFRyQm/Yj0C9l9xAGvjFQJIwTVY6G+NyQ
 o7H3alIREDr3C9I1i9SEluE28YXjugGzSOKoR/rnIFywzQxDQ7aMWBVZZF9PDyQBSFVL
 WrLONN/+3whN54QPt8ObT01657aBbuw+KySJhLqLzWqU508f7aA+X+BcVOgcXdFzNE6f
 FlMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793962788;
 s=strato-dkim-0003; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=z0or9Ayyy8lz4U+Tnkzn/bhcEkn9Da7YqzGnhtayipM=;
 b=qpH3MdGsVClo42wa5cIRFgei+dX5n2JngGFlqV8dgWGgz1aiS1CRbMzmIVv7Cp4PpM
 V15IFqplfbi9CqzHxXCg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrVjZoMy8iN4frnsPsBQ4l+mfK4O7kvgww6TmAq"
Received: from smtpclient.apple by smtp.strato.de (RZmta 55.6.3 AUTH)
 with ESMTPSA id Qb56a22A6Axlmwb
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Fri, 6 Nov 2026 11:59:47 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.10\))
Subject: Re: [PATCH] drm/ingenic: Allocate and register the internal bridge
 separately
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261105203517.2293404-1-f.fainelli@gmail.com>
Date: Fri, 6 Nov 2026 11:59:16 +0100
Cc: linux-kernel@vger.kernel.org, Paul Boddie <paul@boddie.org.uk>,
 paul@crapouillou.net,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 "open list:INGENIC JZ47xx SoCs" <linux-mips@vger.kernel.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5197EDEE-A739-4ADB-A1A9-08B0516735C7@goldelico.com>
References: <20261105203517.2293404-1-f.fainelli@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.10)
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> Am 05.11.2026 um 21:35 schrieb Florian Fainelli =
<f.fainelli@gmail.com>:
>=20
> The LCD controller's internal bridge is embedded in an object =
allocated
> with drmm_encoder_alloc(). This initializes the encoder but leaves the
> bridge's reference count at zero. Since drm_bridge_attach() takes a
> reference, probing the CI20 display produces addition-on-zero and
> underflow warnings and fails to attach the HDMI bridge chain.
>=20
> Allocate the internal bridge with devm_drm_bridge_alloc() and register
> it with devm_drm_bridge_add() before attaching it. Keep the encoder in =
a
> separate DRM-managed allocation: encoder cleanup can drop the final
> bridge reference before it has finished accessing the encoder. Find
> the internal bridge through the encoder's bridge chain during mode
> setting, and use the bridge argument directly in bridge callbacks.
>=20
> Fixes: 94d50c1a2ca3 ("drm/bridge: get/put the bridge reference in =
drm_bridge_attach/detach()")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 31 +++++++++++++++--------
> 1 file changed, 21 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c =
b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index 625ec76cf04d..520912f9ed0d 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -121,16 +121,15 @@ struct ingenic_drm {
> };
>=20
> struct ingenic_drm_bridge {
> - struct drm_encoder encoder;
> struct drm_bridge bridge, *next_bridge;
>=20
> struct drm_bus_cfg bus_cfg;
> };
>=20
> static inline struct ingenic_drm_bridge *
> -to_ingenic_drm_bridge(struct drm_encoder *encoder)
> +to_ingenic_drm_bridge(struct drm_bridge *bridge)
> {
> - return container_of(encoder, struct ingenic_drm_bridge, encoder);
> + return container_of(bridge, struct ingenic_drm_bridge, bridge);
> }
>=20
> static inline struct ingenic_drm_private_state *
> @@ -738,7 +737,9 @@ static void =
ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
> {
> struct ingenic_drm *priv =3D drm_device_get_priv(encoder->dev);
> struct drm_display_mode *mode =3D &crtc_state->adjusted_mode;
> - struct ingenic_drm_bridge *bridge =3D =
to_ingenic_drm_bridge(encoder);
> + struct drm_bridge *first_bridge __free(drm_bridge_put) =3D
> + drm_bridge_chain_get_first_bridge(encoder);
> + struct ingenic_drm_bridge *bridge =3D =
to_ingenic_drm_bridge(first_bridge);
> unsigned int cfg, rgbcfg =3D 0;
>=20
> priv->panel_is_sharp =3D bridge->bus_cfg.flags & =
DRM_BUS_FLAG_SHARP_SIGNALS;
> @@ -799,7 +800,7 @@ static int ingenic_drm_bridge_attach(struct =
drm_bridge *bridge,
>     struct drm_encoder *encoder,
>     enum drm_bridge_attach_flags flags)
> {
> - struct ingenic_drm_bridge *ib =3D to_ingenic_drm_bridge(encoder);
> + struct ingenic_drm_bridge *ib =3D to_ingenic_drm_bridge(bridge);
>=20
> return drm_bridge_attach(encoder, ib->next_bridge,
> &ib->bridge, flags);
> @@ -811,7 +812,7 @@ static int ingenic_drm_bridge_atomic_check(struct =
drm_bridge *bridge,
>   struct drm_connector_state *conn_state)
> {
> struct drm_display_mode *mode =3D &crtc_state->adjusted_mode;
> - struct ingenic_drm_bridge *ib =3D =
to_ingenic_drm_bridge(bridge->encoder);
> + struct ingenic_drm_bridge *ib =3D to_ingenic_drm_bridge(bridge);
>=20
> ib->bus_cfg =3D bridge_state->output_bus_cfg;
>=20
> @@ -1303,22 +1304,32 @@ static int ingenic_drm_bind(struct device =
*dev, bool has_components)
> drm_panel_put(panel);
> }
>=20
> - ib =3D drmm_encoder_alloc(drm, struct ingenic_drm_bridge, encoder,
> - NULL, DRM_MODE_ENCODER_DPI, NULL);
> + ib =3D devm_drm_bridge_alloc(dev, struct ingenic_drm_bridge, bridge,
> +   &ingenic_drm_bridge_funcs);
> if (IS_ERR(ib)) {
> ret =3D PTR_ERR(ib);
> + dev_err(dev, "Failed to allocate bridge: %d\n", ret);
> + goto err_drvdata;
> + }
> +
> + encoder =3D drmm_plain_encoder_alloc(drm, NULL,
> +   DRM_MODE_ENCODER_DPI, NULL);
> + if (IS_ERR(encoder)) {
> + ret =3D PTR_ERR(encoder);
> dev_err(dev, "Failed to init encoder: %d\n", ret);
> goto err_drvdata;
> }
>=20
> - encoder =3D &ib->encoder;
> encoder->possible_crtcs =3D drm_crtc_mask(&priv->crtc);
>=20
> drm_encoder_helper_add(encoder, &ingenic_drm_encoder_helper_funcs);
>=20
> - ib->bridge.funcs =3D &ingenic_drm_bridge_funcs;
> ib->next_bridge =3D bridge;
>=20
> + ret =3D devm_drm_bridge_add(dev, &ib->bridge);
> + if (ret)
> + goto err_drvdata;
> +
> ret =3D drm_bridge_attach(encoder, &ib->bridge, NULL,
> DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> if (ret) {
> --=20
> 2.53.0

Works for me on CI20 with HDMI display.

Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # CI20 V2a

