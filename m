Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB34AF436B9
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0AF10EA6D;
	Fri, 17 Apr 2026 16:19:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="px7y7IT2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1108B10EA6D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:19:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BB43A43E60;
 Fri, 17 Apr 2026 16:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4EDC19425;
 Fri, 17 Apr 2026 16:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776442749;
 bh=Gqz700Nrcu8eh6o0BJ1G6B6osDYiQo7TSTlizR1FQ0c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=px7y7IT2ZKgpKpl8/wMgrPzXILbU0LnWNA4L1I+MFVYgow91EBciFGR3J4xGfSi0r
 l6zL7+qRJQQBTrd7QMXuLoC/O0WLNeNzMe3b61LNyepyU7e34ZSYPWIx7iM+IIkhpj
 IqlkP9Fh6zlJmMTbv16dJiHPfs4Tvtk13nm0R6+wWcRllszIXQfv6lzjj8k3+n9QA/
 Iikjm3y2W+mCLXZ5f+EidM+kH2/wFSI3vx7mx1V6/7zlLMmZ6agq/u/CTwlWsxAa4H
 wFL/O+6CuQWucWUXodJlw+NOvK60pG4gkmfxxn2JHPnEUe/2r7CKnoxwFTuCzhTzxM
 4ui4D7XPko7Ew==
Date: Fri, 17 Apr 2026 17:19:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Jagan Teki <jagan@edgeble.ai>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Marek Vasut <marex@nabladev.com>, Kael D'Alcamo <dev@kael-k.io>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add compatibles for
 Zhunyi Z40046
Message-ID: <20260417-wisplike-seismic-380c96863444@spud>
References: <20260417104740.259689-1-l.scorcia@gmail.com>
 <20260417104740.259689-2-l.scorcia@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4RQNWT+XJzTeXJqp"
Content-Disposition: inline
In-Reply-To: <20260417104740.259689-2-l.scorcia@gmail.com>
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


--4RQNWT+XJzTeXJqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 11:46:30AM +0100, Luca Leonardo Scorcia wrote:
> The Zhunyi Z40046 is a 480x800 24-bit WVGA DSI panel based on the
> Fitipower JD9161Z DSI controller found in the Xiaomi Mi Smart Clock
> x04g, apparently in two different variants.
>=20
> The Fitipower JD9161Z LCD driver IC is very similar to the Jadard
> JD9365DA-H3, it just uses a different initialization sequence.
>=20
> Since this is the first supported device from this vendor, document its
> name to the vendor-prefixes.yaml file as well.
>=20
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> ---
>  .../devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml   | 2 ++
>  Documentation/devicetree/bindings/vendor-prefixes.yaml          | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/jadard,jd936=
5da-h3.yaml b/Documentation/devicetree/bindings/display/panel/jadard,jd9365=
da-h3.yaml
> index e39efb44ed42..158388a284d9 100644
> --- a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.=
yaml
> +++ b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.=
yaml
> @@ -24,6 +24,8 @@ properties:
>            - radxa,display-10hd-ad001
>            - radxa,display-8hd-ad002
>            - taiguanck,xti05101-01a
> +          - zhunyikeji,z40046-ctc
> +          - zhunyikeji,z40046-boe
>        - const: jadard,jd9365da-h3
> =20
>    reg:
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 6339988e3805..debaec59e9a0 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1923,6 +1923,8 @@ patternProperties:
>      description: Zealz
>    "^zeitec,.*":
>      description: ZEITEC Semiconductor Co., LTD.
> +  "^zhunyikeji,.*":
> +    description: Shenzhen Zhunyi Technology Co., Ltd.
>    "^zidoo,.*":
>      description: Shenzhen Zidoo Technology Co., Ltd.
>    "^zii,.*":
> --=20
> 2.43.0
>=20

--4RQNWT+XJzTeXJqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeJddwAKCRB4tDGHoIJi
0uPcAQDiiUwHwEaOFL6lZjiJi7xuyBZVyTp5yaXHmyRpUpuuyQEAnK3zwourBQ0E
Ha9E1aiEpbrTHZIQvv9OEnFcBhwDGAw=
=by6q
-----END PGP SIGNATURE-----

--4RQNWT+XJzTeXJqp--
