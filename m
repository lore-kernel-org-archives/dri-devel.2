Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2BCCD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 19:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E5310E220;
	Thu, 21 May 2026 19:50:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bAhS+w6l";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D3CA10E220
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 19:50:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07E0A403C2;
 Thu, 21 May 2026 19:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D171F000E9;
 Thu, 21 May 2026 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779393044;
 bh=dn3sgOxqZHZf8yzceVyMsv54yRYqdXLBvxdFtyj03W8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bAhS+w6lgcqm0H+AEoz+Qsn+RaXM/lDrCjOiKmA4bvKfi9Kri2PsEEqEhJ6wvdR8O
 +5BaPbIFa+XrDVKG/5WbB2o6fl+t17NnDyS0uTlXa/ZOmuHp/8nluuUhJxo8zwvICQ
 gbS1prxW6OYt1Z04qgbU+cenGXNozVwKFmN8fobukF/n7QnlmYEvstIfhIy2VpGvRv
 Tb3WVp/123Ku9QXdYOrZT+7Rvd36mwj+scRtETpSl/w7zFkFL7ncyCIiUb5g07HP73
 VzYAhN/heoJG9hlOrYuLM4YIVxX/+GcKK2hF++dhXm45BBLds3bRnEMcFwrK5+YHt9
 qqyPrF8DWTRbg==
Date: Thu, 21 May 2026 20:50:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com,
 nicolas.frattaroli@collabora.com, cristian.ciocaltea@collabora.com,
 sebastian.reichel@collabora.com, dmitry.baryshkov@oss.qualcomm.com,
 luca.ceresoli@bootlin.com, dianders@chromium.org,
 m.szyprowski@samsung.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: display: bridge: analogix-dp: Add
 data-lanes support for endpoint
Message-ID: <20260521-modify-quadrant-8d6a2e36727c@spud>
References: <20260521114459.1394264-1-damon.ding@rock-chips.com>
 <20260521114459.1394264-2-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LVpox1pmuItVJEtf"
Content-Disposition: inline
In-Reply-To: <20260521114459.1394264-2-damon.ding@rock-chips.com>
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


--LVpox1pmuItVJEtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 07:44:57PM +0800, Damon Ding wrote:
> Add data-lanes property support to the port@1 endpoint for physical
> lane mapping configuration.
>=20
> Lane mapping is mainly used for below scenarios:
> 1. Correct PCB lane swap and differential line routing crossover
>    without hardware changes;
> 2. Adapt mismatched lane pin definitions between SoC and eDP panel;
> 3. Support multiple panel hardware variants on the same board
>    by configuring data-lanes in device tree only.
>=20
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

Sashiko complaint here looks valid.
pw-bot: changes-requested

Thanks,
Conor.

>=20
> ---
>=20
> Changes in v2:
> - Add lane mapping application scenarios in commit message.
> - Remove redundant deprecated property 'data-lanes' for eDP node.
> - Update port@1 $ref to /schemas/graph.yaml#/$defs/port-base.
> ---
>  .../bindings/display/bridge/analogix,dp.yaml    | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,dp=
=2Eyaml b/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
> index 62f0521b0924..e34fdb21adb4 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
> @@ -42,13 +42,20 @@ properties:
>      properties:
>        port@0:
>          $ref: /schemas/graph.yaml#/properties/port
> -        description:
> -          Input node to receive pixel data.
> +        description: Input node to receive pixel data.
> =20
>        port@1:
> -        $ref: /schemas/graph.yaml#/properties/port
> -        description:
> -          Port node with one endpoint connected to a dp-connector node.
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        description: Port node with one endpoint connected to sink devic=
e node.
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            properties:
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +                items:
> +                  enum: [ 0, 1, 2, 3 ]
> =20
>      required:
>        - port@0
> --=20
> 2.34.1
>=20

--LVpox1pmuItVJEtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag9iDQAKCRB4tDGHoIJi
0rqyAP9Sq0vCFT1hGgyTBDOwHWDj+664+G63dq1drVGMRVcgdQEAlrqXjzT6RyJh
m5BSYAeHI+sdDhoKFM9u+qt9jBo0Tw4=
=w+pp
-----END PGP SIGNATURE-----

--LVpox1pmuItVJEtf--
