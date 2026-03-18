Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC835103E18F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1130E10E120;
	Wed, 18 Mar 2026 14:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VzJQfpLN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8128110E153
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 14:36:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 92FCB60054;
 Wed, 18 Mar 2026 14:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FAFC19421;
 Wed, 18 Mar 2026 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773844582;
 bh=7cwu4Ega8UtaQtRj9zVbnViUcpr1YFc56yM6AII7k6Y=;
 h=Date:From:To:Cc:Subject:From;
 b=VzJQfpLN3zU6pDsKrUbRq5lKmDn9M33EwTEe7LucUUHE/qGehTFxwtgKV1JPx+uSs
 66E/JZHvr5keb3muK5LR9CQkNHCh8stbM7Eg89OG1PyOQ5IQ3zfztG+bv9UPrqWxj3
 L9BWXStF0vXm+HZEUekTTI7wT5HSuBdGOYCI3mZHGrX845RnGIpGBpp2KCrmTfLlkI
 dLzvEz+HyUuyef3OOPH0MplJ0CaFk2nBHBOpHJThi7wR9o6RvW1JVJxgi+CTpcAkgl
 wtSEMaHJjJwu28tjeCeZJZis4SgZaeMxS7WKLcRMRS2tYyRDd4beS4WnVv/wrd0Siu
 +bTZoOp7wDHZQ==
Date: Wed, 18 Mar 2026 14:36:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Christian Hewitt <christianshewitt@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Daniel Stone <daniels@collabora.com>, Jonas Karlman <jonas@kwiboo.se>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes tree
Message-ID: <abq4YV8QgsmpUoHI@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xbJjccWe39/nGeLS"
Content-Disposition: inline
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


--xbJjccWe39/nGeLS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c

between commit:

  cffcb42c57686 ("drm/bridge: dw-hdmi-qp: fix multi-channel audio output")

=66rom the drm-misc-fixes tree and commit:

  3ea699b56d31c ("drm/bridge: dw-hdmi-qp: Rework Audio InfoFrame handler")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index facfb7526928d,d649a1cf07f5c..0000000000000
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@@ -11,6 -11,7 +11,7 @@@
  #include <linux/export.h>
  #include <linux/i2c.h>
  #include <linux/irq.h>
+ #include <linux/minmax.h>
  #include <linux/module.h>
  #include <linux/mutex.h>
  #include <linux/of.h>
@@@ -748,120 -749,6 +749,6 @@@ static struct i2c_adapter *dw_hdmi_qp_i
  	return adap;
  }
 =20
- static int dw_hdmi_qp_config_avi_infoframe(struct dw_hdmi_qp *hdmi,
- 					   const u8 *buffer, size_t len)
- {
- 	u32 val, i, j;
-=20
- 	if (len !=3D HDMI_INFOFRAME_SIZE(AVI)) {
- 		dev_err(hdmi->dev, "failed to configure avi infoframe\n");
- 		return -EINVAL;
- 	}
-=20
- 	/*
- 	 * DW HDMI QP IP uses a different byte format from standard AVI info
- 	 * frames, though generally the bits are in the correct bytes.
- 	 */
- 	val =3D buffer[1] << 8 | buffer[2] << 16;
- 	dw_hdmi_qp_write(hdmi, val, PKT_AVI_CONTENTS0);
-=20
- 	for (i =3D 0; i < 4; i++) {
- 		for (j =3D 0; j < 4; j++) {
- 			if (i * 4 + j >=3D 14)
- 				break;
- 			if (!j)
- 				val =3D buffer[i * 4 + j + 3];
- 			val |=3D buffer[i * 4 + j + 3] << (8 * j);
- 		}
-=20
- 		dw_hdmi_qp_write(hdmi, val, PKT_AVI_CONTENTS1 + i * 4);
- 	}
-=20
- 	dw_hdmi_qp_mod(hdmi, 0, PKTSCHED_AVI_FIELDRATE, PKTSCHED_PKT_CONFIG1);
-=20
- 	dw_hdmi_qp_mod(hdmi, PKTSCHED_AVI_TX_EN | PKTSCHED_GCP_TX_EN,
- 		       PKTSCHED_AVI_TX_EN | PKTSCHED_GCP_TX_EN, PKTSCHED_PKT_EN);
-=20
- 	return 0;
- }
-=20
- static int dw_hdmi_qp_config_drm_infoframe(struct dw_hdmi_qp *hdmi,
- 					   const u8 *buffer, size_t len)
- {
- 	u32 val, i;
-=20
- 	if (len !=3D HDMI_INFOFRAME_SIZE(DRM)) {
- 		dev_err(hdmi->dev, "failed to configure drm infoframe\n");
- 		return -EINVAL;
- 	}
-=20
- 	dw_hdmi_qp_mod(hdmi, 0, PKTSCHED_DRMI_TX_EN, PKTSCHED_PKT_EN);
-=20
- 	val =3D buffer[1] << 8 | buffer[2] << 16;
- 	dw_hdmi_qp_write(hdmi, val, PKT_DRMI_CONTENTS0);
-=20
- 	for (i =3D 0; i <=3D buffer[2]; i++) {
- 		if (i % 4 =3D=3D 0)
- 			val =3D buffer[3 + i];
- 		val |=3D buffer[3 + i] << ((i % 4) * 8);
-=20
- 		if ((i % 4 =3D=3D 3) || i =3D=3D buffer[2])
- 			dw_hdmi_qp_write(hdmi, val,
- 					 PKT_DRMI_CONTENTS1 + ((i / 4) * 4));
- 	}
-=20
- 	dw_hdmi_qp_mod(hdmi, 0, PKTSCHED_DRMI_FIELDRATE, PKTSCHED_PKT_CONFIG1);
- 	dw_hdmi_qp_mod(hdmi, PKTSCHED_DRMI_TX_EN, PKTSCHED_DRMI_TX_EN,
- 		       PKTSCHED_PKT_EN);
-=20
- 	return 0;
- }
-=20
- /*
-  * Static values documented in the TRM
-  * Different values are only used for debug purposes
-  */
- #define DW_HDMI_QP_AUDIO_INFOFRAME_HB1	0x1
- #define DW_HDMI_QP_AUDIO_INFOFRAME_HB2	0xa
-=20
- static int dw_hdmi_qp_config_audio_infoframe(struct dw_hdmi_qp *hdmi,
- 					     const u8 *buffer, size_t len)
- {
- 	/*
- 	 * AUDI_CONTENTS0: { RSV, HB2, HB1, RSV }
- 	 * AUDI_CONTENTS1: { PB3, PB2, PB1, PB0 }
- 	 * AUDI_CONTENTS2: { PB7, PB6, PB5, PB4 }
- 	 *
- 	 * PB0: CheckSum
- 	 * PB1: | CT3    | CT2  | CT1  | CT0  | F13  | CC2 | CC1 | CC0 |
- 	 * PB2: | F27    | F26  | F25  | SF2  | SF1  | SF0 | SS1 | SS0 |
- 	 * PB3: | F37    | F36  | F35  | F34  | F33  | F32 | F31 | F30 |
- 	 * PB4: | CA7    | CA6  | CA5  | CA4  | CA3  | CA2 | CA1 | CA0 |
- 	 * PB5: | DM_INH | LSV3 | LSV2 | LSV1 | LSV0 | F52 | F51 | F50 |
- 	 * PB6~PB10: Reserved
- 	 *
- 	 * AUDI_CONTENTS0 default value defined by HDMI specification,
- 	 * and shall only be changed for debug purposes.
- 	 */
- 	u32 header_bytes =3D (DW_HDMI_QP_AUDIO_INFOFRAME_HB1 << 8) |
- 			  (DW_HDMI_QP_AUDIO_INFOFRAME_HB2 << 16);
-=20
- 	regmap_bulk_write(hdmi->regm, PKT_AUDI_CONTENTS0, &header_bytes, 1);
- 	regmap_bulk_write(hdmi->regm, PKT_AUDI_CONTENTS1, &buffer[3], 1);
- 	regmap_bulk_write(hdmi->regm, PKT_AUDI_CONTENTS2, &buffer[7], 1);
-=20
- 	/* Enable ACR, AUDI, AMD */
- 	dw_hdmi_qp_mod(hdmi,
- 		       PKTSCHED_ACR_TX_EN | PKTSCHED_AUDI_TX_EN | PKTSCHED_AMD_TX_EN,
- 		       PKTSCHED_ACR_TX_EN | PKTSCHED_AUDI_TX_EN | PKTSCHED_AMD_TX_EN,
- 		       PKTSCHED_PKT_EN);
-=20
- 	/* Enable AUDS */
- 	dw_hdmi_qp_mod(hdmi, PKTSCHED_AUDS_TX_EN, PKTSCHED_AUDS_TX_EN, PKTSCHED_=
PKT_EN);
-=20
- 	return 0;
- }
-=20
  static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
  					    struct drm_atomic_state *state)
  {
@@@ -970,9 -857,9 +857,9 @@@ static int dw_hdmi_qp_bridge_clear_avi_
 =20
  static int dw_hdmi_qp_bridge_clear_hdmi_infoframe(struct drm_bridge *brid=
ge)
  {
- 	/* FIXME: add support for this InfoFrame */
+ 	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
 =20
- 	drm_warn_once(bridge->encoder->dev, "HDMI VSI not supported\n");
+ 	dw_hdmi_qp_mod(hdmi, 0, PKTSCHED_VSI_TX_EN, PKTSCHED_PKT_EN);
 =20
  	return 0;
  }
@@@ -986,6 -873,15 +873,15 @@@ static int dw_hdmi_qp_bridge_clear_hdr_
  	return 0;
  }
 =20
+ static int dw_hdmi_qp_bridge_clear_spd_infoframe(struct drm_bridge *bridg=
e)
+ {
+ 	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
+=20
+ 	dw_hdmi_qp_mod(hdmi, 0, PKTSCHED_SPDI_TX_EN, PKTSCHED_PKT_EN);
+=20
+ 	return 0;
+ }
+=20
  static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bri=
dge)
  {
  	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
@@@ -999,6 -895,32 +895,32 @@@
  	return 0;
  }
 =20
+ static void dw_hdmi_qp_write_pkt(struct dw_hdmi_qp *hdmi, const u8 *buffe=
r,
+ 				 size_t start, size_t len, unsigned int reg)
+ {
+ 	u32 val =3D 0;
+ 	size_t i;
+=20
+ 	for (i =3D start; i < start + len; i++)
+ 		val |=3D buffer[i] << ((i % 4) * BITS_PER_BYTE);
+=20
+ 	dw_hdmi_qp_write(hdmi, val, reg);
+ }
+=20
+ static void dw_hdmi_qp_write_infoframe(struct dw_hdmi_qp *hdmi, const u8 =
*buffer,
+ 				       size_t len, unsigned int reg)
+ {
+ 	size_t i;
+=20
+ 	/* InfoFrame packet header */
+ 	dw_hdmi_qp_write_pkt(hdmi, buffer, 1, 2, reg);
+=20
+ 	/* InfoFrame packet body */
+ 	for (i =3D 0; i < len - 3; i +=3D 4)
+ 		dw_hdmi_qp_write_pkt(hdmi, buffer + 3, i, min(len - i - 3, 4),
+ 				     reg + i + 4);
+ }
+=20
  static int dw_hdmi_qp_bridge_write_avi_infoframe(struct drm_bridge *bridg=
e,
  						 const u8 *buffer, size_t len)
  {
@@@ -1006,15 -928,27 +928,27 @@@
 =20
  	dw_hdmi_qp_bridge_clear_avi_infoframe(bridge);
 =20
- 	return dw_hdmi_qp_config_avi_infoframe(hdmi, buffer, len);
+ 	dw_hdmi_qp_write_infoframe(hdmi, buffer, len, PKT_AVI_CONTENTS0);
+=20
+ 	dw_hdmi_qp_mod(hdmi, 0, PKTSCHED_AVI_FIELDRATE, PKTSCHED_PKT_CONFIG1);
+ 	dw_hdmi_qp_mod(hdmi, PKTSCHED_AVI_TX_EN | PKTSCHED_GCP_TX_EN,
+ 		       PKTSCHED_AVI_TX_EN | PKTSCHED_GCP_TX_EN, PKTSCHED_PKT_EN);
+=20
+ 	return 0;
  }
 =20
  static int dw_hdmi_qp_bridge_write_hdmi_infoframe(struct drm_bridge *brid=
ge,
  						  const u8 *buffer, size_t len)
  {
+ 	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
+=20
  	dw_hdmi_qp_bridge_clear_hdmi_infoframe(bridge);
 =20
- 	/* FIXME: add support for the HDMI VSI */
+ 	dw_hdmi_qp_write_infoframe(hdmi, buffer, len, PKT_VSI_CONTENTS0);
+=20
+ 	dw_hdmi_qp_mod(hdmi, 0, PKTSCHED_VSI_FIELDRATE, PKTSCHED_PKT_CONFIG1);
+ 	dw_hdmi_qp_mod(hdmi, PKTSCHED_VSI_TX_EN, PKTSCHED_VSI_TX_EN,
+ 		       PKTSCHED_PKT_EN);
 =20
  	return 0;
  }
@@@ -1026,7 -960,28 +960,28 @@@ static int dw_hdmi_qp_bridge_write_hdr_
 =20
  	dw_hdmi_qp_bridge_clear_hdr_drm_infoframe(bridge);
 =20
- 	return dw_hdmi_qp_config_drm_infoframe(hdmi, buffer, len);
+ 	dw_hdmi_qp_write_infoframe(hdmi, buffer, len, PKT_DRMI_CONTENTS0);
+=20
+ 	dw_hdmi_qp_mod(hdmi, 0, PKTSCHED_DRMI_FIELDRATE, PKTSCHED_PKT_CONFIG1);
+ 	dw_hdmi_qp_mod(hdmi, PKTSCHED_DRMI_TX_EN, PKTSCHED_DRMI_TX_EN,
+ 		       PKTSCHED_PKT_EN);
+=20
+ 	return 0;
+ }
+=20
+ static int dw_hdmi_qp_bridge_write_spd_infoframe(struct drm_bridge *bridg=
e,
+ 						 const u8 *buffer, size_t len)
+ {
+ 	struct dw_hdmi_qp *hdmi =3D bridge->driver_private;
+=20
+ 	dw_hdmi_qp_bridge_clear_spd_infoframe(bridge);
+=20
+ 	dw_hdmi_qp_write_infoframe(hdmi, buffer, len, PKT_SPDI_CONTENTS0);
+=20
+ 	dw_hdmi_qp_mod(hdmi, PKTSCHED_SPDI_TX_EN, PKTSCHED_SPDI_TX_EN,
+ 		       PKTSCHED_PKT_EN);
+=20
+ 	return 0;
  }
 =20
  static int dw_hdmi_qp_bridge_write_audio_infoframe(struct drm_bridge *bri=
dge,
@@@ -1036,7 -991,31 +991,31 @@@
 =20
  	dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
 =20
- 	return dw_hdmi_qp_config_audio_infoframe(hdmi, buffer, len);
+ 	/*
+ 	 * AUDI_CONTENTS0: { RSV, HB2, HB1, RSV }
+ 	 * AUDI_CONTENTS1: { PB3, PB2, PB1, PB0 }
+ 	 * AUDI_CONTENTS2: { PB7, PB6, PB5, PB4 }
+ 	 *
+ 	 * PB0: CheckSum
+ 	 * PB1: | CT3    | CT2  | CT1  | CT0  | F13  | CC2 | CC1 | CC0 |
+ 	 * PB2: | F27    | F26  | F25  | SF2  | SF1  | SF0 | SS1 | SS0 |
+ 	 * PB3: | F37    | F36  | F35  | F34  | F33  | F32 | F31 | F30 |
+ 	 * PB4: | CA7    | CA6  | CA5  | CA4  | CA3  | CA2 | CA1 | CA0 |
+ 	 * PB5: | DM_INH | LSV3 | LSV2 | LSV1 | LSV0 | F52 | F51 | F50 |
+ 	 * PB6~PB10: Reserved
+ 	 */
+ 	dw_hdmi_qp_write_infoframe(hdmi, buffer, len, PKT_AUDI_CONTENTS0);
+=20
+ 	/* Enable ACR, AUDI, AMD */
+ 	dw_hdmi_qp_mod(hdmi,
+ 		       PKTSCHED_ACR_TX_EN | PKTSCHED_AUDI_TX_EN | PKTSCHED_AMD_TX_EN,
+ 		       PKTSCHED_ACR_TX_EN | PKTSCHED_AUDI_TX_EN | PKTSCHED_AMD_TX_EN,
+ 		       PKTSCHED_PKT_EN);
+=20
+ 	/* Enable AUDS */
+ 	dw_hdmi_qp_mod(hdmi, PKTSCHED_AUDS_TX_EN, PKTSCHED_AUDS_TX_EN, PKTSCHED_=
PKT_EN);
+=20
+ 	return 0;
  }
 =20
  #ifdef CONFIG_DRM_DW_HDMI_QP_CEC
@@@ -1227,6 -1206,8 +1206,8 @@@ static const struct drm_bridge_funcs dw
  	.hdmi_write_hdmi_infoframe =3D dw_hdmi_qp_bridge_write_hdmi_infoframe,
  	.hdmi_clear_hdr_drm_infoframe =3D dw_hdmi_qp_bridge_clear_hdr_drm_infofr=
ame,
  	.hdmi_write_hdr_drm_infoframe =3D dw_hdmi_qp_bridge_write_hdr_drm_infofr=
ame,
+ 	.hdmi_clear_spd_infoframe =3D dw_hdmi_qp_bridge_clear_spd_infoframe,
+ 	.hdmi_write_spd_infoframe =3D dw_hdmi_qp_bridge_write_spd_infoframe,
  	.hdmi_clear_audio_infoframe =3D dw_hdmi_qp_bridge_clear_audio_infoframe,
  	.hdmi_write_audio_infoframe =3D dw_hdmi_qp_bridge_write_audio_infoframe,
  	.hdmi_audio_startup =3D dw_hdmi_qp_audio_enable,
@@@ -1344,7 -1325,8 +1325,8 @@@ struct dw_hdmi_qp *dw_hdmi_qp_bind(stru
  			   DRM_BRIDGE_OP_EDID |
  			   DRM_BRIDGE_OP_HDMI |
  			   DRM_BRIDGE_OP_HDMI_AUDIO |
- 			   DRM_BRIDGE_OP_HDMI_HDR_DRM_INFOFRAME;
+ 			   DRM_BRIDGE_OP_HDMI_HDR_DRM_INFOFRAME |
+ 			   DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME;
  	if (!hdmi->no_hpd)
  		hdmi->bridge.ops |=3D DRM_BRIDGE_OP_HPD;
  	hdmi->bridge.of_node =3D pdev->dev.of_node;

--xbJjccWe39/nGeLS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm6uGAACgkQJNaLcl1U
h9A4Bgf+Ou80IHlwE99ccpMSbaWYyIj5zdrHUint6uiDAfT1xCK0yFumhbb937ik
UuiKPkVz001tAdKYLFD8CnPqdQZIftGMyPwaTjPRf7lWXXfIfZN/QMYKjoxAhZeL
YiKaCLyCAfBjuSxqZj63/tZg9JDR8R+2uYyEr3ylkMi3WNGt/H2uUjST1Z9fyURB
29aPDSWlqelj6VYSeO+i2f7fPc8T8KL/soNnjGSiXstdKDpa7nWpcvGPwGQRjfxk
coR9OhIaRFuX3h8HEzqX5WHdXlmIHBh4BhdXYLUKiRQlJxKbhXcpZddKbGI8h+nu
x0M2bQAbVDj52J5VWsgu9IJJvWD5pg==
=udv0
-----END PGP SIGNATURE-----

--xbJjccWe39/nGeLS--
