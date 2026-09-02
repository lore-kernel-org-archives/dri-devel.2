Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18E9C624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3618E10F2F3;
	Wed,  2 Sep 2026 17:32:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UEafEYVd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3041C10F2F3
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 17:32:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B48CC413FC;
 Wed,  2 Sep 2026 17:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C9E1F000E9;
 Wed,  2 Sep 2026 17:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788370358;
 bh=3NMBMzPrvgzARGDkqkkRUrIwdOjQWvMowK2DeeOcjfo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UEafEYVd1/nuWsqRSGaL6Ym6DYw4xcbcm3nx7vVQr3yGX3U4bOv8N3/0zJemQBiZo
 Jnl8FY9v1VjM+Fhxz5w3IOBnPSA9K3eDxx3ykfG3mvpXPIbwzE2K5l6KgBweNNS9qU
 B3liGmGb4D5oU3lDXHHQtQZJh13lbYb7K5m939Ne06IA93hFKTEFsP7gPZXFEVO8Ja
 FeP4as0D84ujfkTFxoSyPCRYGq8QXi1+TtmiMT2io8VgFh/ohSHNp0OLQsgcywWkWD
 VC2RFBdiS2ahqULNsmSdt5v+Vy01g4ZOyCqQ2OcR7bCUAcQTIzG4I9B3k0oiyvgJQl
 HDPiHPtOmsr0Q==
Date: Wed, 2 Sep 2026 18:32:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: display: synopsys,dw-hdmi: add
 ignore-rxsense
Message-ID: <20260902-relatable-caviar-a82542bcc02a@spud>
References: <20260902130117.2731-1-ian.ray@gehealthcare.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/awlfxXb81px8kJp"
Content-Disposition: inline
In-Reply-To: <20260902130117.2731-1-ian.ray@gehealthcare.com>
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

--/awlfxXb81px8kJp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026 at 04:01:13PM +0300, Ian Ray wrote:
> Add a new property to ignore RXSENSE during hotplug events.
>=20
> Fixes: da09daf88108 ("drm: bridge: dw_hdmi: only trigger hotplug event on=
 link change")
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
> ---
>  .../bindings/display/bridge/synopsys,dw-hdmi.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/synopsys,dw=
-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-h=
dmi.yaml
> index 33481381cccc..0f6e4dabe11d 100644
> --- a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.y=
aml
> +++ b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.y=
aml
> @@ -61,6 +61,14 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  ignore-rxsense:
> +    type: boolean
> +    description:
> +      Determine the connector status from the HPD signal alone and ignor=
e RX
> +      sense. Set this on boards where a downstream device (for example a=
n HDMI
> +      to DP converter) keeps the TMDS lines permanently loaded, so that =
RX
> +      sense is always asserted and can never signal a disconnect.

I'm not very familiar at all with these kinds of devices, but this seems
like something pretty generic that not only this IP would need. Are
there other examples of this?

Additionally, you're missing a vendor prefix in the case that this does
remain limited to this one device.

pw-bot: changes-requested

Thanks,
Conor.

> +
>  additionalProperties: true
> =20
>  ...
> --=20
> 2.47.3
>=20

--/awlfxXb81px8kJp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaphdsAAKCRB4tDGHoIJi
0s61APj5C2V7PJS7E7HhgcEtL8M8i7z+K1Z2DlmYJ71DTSzjAP0a45C2xL/aY4+z
dUYv8IU3c4Qa+BedfjjYp1yUBa1qDQ==
=rI4n
-----END PGP SIGNATURE-----

--/awlfxXb81px8kJp--
