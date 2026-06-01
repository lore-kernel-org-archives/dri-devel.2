Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9F0CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 16:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0B0D113525;
	Mon,  1 Jun 2026 16:01:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="iuSBSZc4";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4227E113525
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 16:01:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780329703; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ReGZ2+w/6rVGF4ptDmgxem3NFj2/B4PHeRL/GXmhTAmzV8YWf1bqgc+13PLae8NUTarqclTYkQIe1FWAwZHxG2InnURsKYQsx16oFfScPcFjvUCXapjbFwvsa502XgrS5xN92dvn/NMjEw90i4VlqTHBOtlRvypYT2fgK3SMUs4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780329703;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=WyEoraDje0I2OZzy1qJWT3gAyZs3HUp0lwO3eVqnttM=; 
 b=cS0K/I4YH3UdGvQtnOyQA5HNIqyZy8zkZUI3IaDt+vME/qGyDoorNHWZrNyjzpQN4+3xTWzBZ6gvg7yd5bH2/+bgflQ2fNlScv5KWXAOO5bt7mEp/zFWffz6nrlaPDidZ09Jj6YBBp4OG5p+IGVfDQIVoCYLYADzUONma0iEj7o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780329703; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=WyEoraDje0I2OZzy1qJWT3gAyZs3HUp0lwO3eVqnttM=;
 b=iuSBSZc4SbnQd66DFCiqdyz0EzRywtpduR0VijfvmTSYkLIABMYGHn275BBTYqx1
 Di19bWzo25yIZcUtI8yfaJso6Vq3HWVuHgy6pP97acP6fIUgaxsPNcDy5+PFH6xuj2/
 pUjmMF7Py/qsfy0OWjpXOpjignhkZrJMxiA8/Xp0=
Received: by mx.zohomail.com with SMTPS id 1780329699986357.9685849675391;
 Mon, 1 Jun 2026 09:01:39 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 6329E181D80; Mon, 01 Jun 2026 18:01:35 +0200 (CEST)
Date: Mon, 1 Jun 2026 18:01:35 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Sam Ravnborg <sam@ravnborg.org>, Yongxing Mou <yongxing.mou@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drm/bridge: display-connector: don't autoenable
 HPD IRQ
Message-ID: <ah2syd6p8vm5JPTl@venus>
References: <20260528-dp-connector-hpd-v3-0-d656eb1079b7@oss.qualcomm.com>
 <20260528-dp-connector-hpd-v3-2-d656eb1079b7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3b2l7fwjrnvp345q"
Content-Disposition: inline
In-Reply-To: <20260528-dp-connector-hpd-v3-2-d656eb1079b7@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.1.0.1.4.3/280.300.36
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


--3b2l7fwjrnvp345q
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/3] drm/bridge: display-connector: don't autoenable
 HPD IRQ
MIME-Version: 1.0

Hi,

On Thu, May 28, 2026 at 10:10:49AM +0300, Dmitry Baryshkov wrote:
> If HPD IRQ is enabled in the display_connector's probe, it can be
> triggered too early, before the DRM connector is completely setup. Use
> the enable_hpd / disable_hpd callbacks to control enablement of the HPD
> IRQ.
>=20
> Fixes: 0c275c30176b ("drm/bridge: Add bridge driver for display connector=
s")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/gpu/drm/bridge/display-connector.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm=
/bridge/display-connector.c
> index 16c0631adeb1..6bb1134f75c3 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
> @@ -87,6 +87,20 @@ display_connector_bridge_detect(struct drm_bridge *bri=
dge, struct drm_connector
>  	return display_connector_detect(bridge);
>  }
> =20
> +static void display_connector_hpd_enable(struct drm_bridge *bridge)
> +{
> +	struct display_connector *conn =3D to_display_connector(bridge);
> +
> +	enable_irq(conn->hpd_irq);
> +}
> +
> +static void display_connector_hpd_disable(struct drm_bridge *bridge)
> +{
> +	struct display_connector *conn =3D to_display_connector(bridge);
> +
> +	disable_irq(conn->hpd_irq);
> +}
> +
>  static const struct drm_edid *display_connector_edid_read(struct drm_bri=
dge *bridge,
>  							  struct drm_connector *connector)
>  {
> @@ -178,6 +192,8 @@ static u32 *display_connector_get_input_bus_fmts(stru=
ct drm_bridge *bridge,
>  static const struct drm_bridge_funcs display_connector_bridge_funcs =3D {
>  	.attach =3D display_connector_attach,
>  	.detect =3D display_connector_bridge_detect,
> +	.hpd_enable =3D display_connector_hpd_enable,
> +	.hpd_disable =3D display_connector_hpd_disable,
>  	.edid_read =3D display_connector_edid_read,
>  	.atomic_get_output_bus_fmts =3D display_connector_get_output_bus_fmts,
>  	.atomic_get_input_bus_fmts =3D display_connector_get_input_bus_fmts,
> @@ -307,6 +323,7 @@ static int display_connector_probe(struct platform_de=
vice *pdev)
>  						NULL, display_connector_hpd_irq,
>  						IRQF_TRIGGER_RISING |
>  						IRQF_TRIGGER_FALLING |
> +						IRQF_NO_AUTOEN |
>  						IRQF_ONESHOT,
>  						"HPD", conn);
>  		if (ret) {
>=20
> --=20
> 2.47.3
>=20

--3b2l7fwjrnvp345q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmodrN8ACgkQ2O7X88g7
+prFgA/+PR3aPakzRMu7QeopUMf4nmsO/L9pBC94cZa8jcsAOS8J56JtYZD9mD91
cDm3QigE3jRg9eDrLTj8oFnNyArDFxPnsnfofE7neO6YCMbdxGXdhHRyrSMlPnnG
5sNNy2fxlVLtLuGUVLEqm19TDFcIvHpmAAm+RExknfyWtjpIRbYOe1w/pnsmKhlN
Trtj5klcyo9D+Imtzt6eIDgipkRLLu33m2kqON9LWX4b3dd4sCsQ4nESsklD1DK8
G0TaSzDrgXDJvhhMjEcPJk2hlC99q6qeybkP6NAk8q1xTqVVglHuriJ9fRHS5oBw
Ao5fR8HO0vrG1sXTD9+oyJlwd8yLKkK0Jg+z0C60E5MK6sju+XqtO5n2Am7jpWux
XSzFSRehUW16hKYGUTk2/R9tZAsNE9M+JmxXLwxYUrgMnLfYquB1jDcKJNaf/sHM
xNeCfSYRjOY/CeReQij5U/jaJMxs8SV7gML4DiVGEKyuzjrtcUFY1VU6PpHceR1t
RNkvelfzQOdwBVQFno/909OM0+Hm8Vu+SETz4Lwt4Up5QBKULz6ufPROaJFSOmf/
KnecGrRNUinBJUBgBvMyrNIFmr3RaBepVxzaelXa+m/LFlwoDPhNLpUuq/GBCMKE
LNNOyNLBs5Yz/iA3hTSlTrbfSQ1Qeo9afB402NCE8RZZ9YHQv78=
=igXL
-----END PGP SIGNATURE-----

--3b2l7fwjrnvp345q--
