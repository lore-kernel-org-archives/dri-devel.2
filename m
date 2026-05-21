Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CBFCD5BAF
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 16:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CCB010E4A1;
	Thu, 21 May 2026 16:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HHwteedu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9117910E4A1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 16:57:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0163A601F3;
 Thu, 21 May 2026 16:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A9E1F000E9;
 Thu, 21 May 2026 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779382621;
 bh=dDeoWR1l1WxGKgrhYf3AYzpmxpaVT4tb7GV4oK8WvhQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HHwteeduDAZoSQvslO3119EuwkrI8ClRSBHQAq8AUxTkShUoQo9eYvhx+p4JwiK6Z
 KLCpfwBIX28PalxU7zwropr0R3evhxgFA+rpttyKVPtQSd7zUhMevb++3xR+yAqXXq
 3ymaFQvEDEGUorP0Eyd3kRFmqcCz/uhNeUHkhTRpxyJB9k1QODI/B5XAN5xkzeDCQN
 awjwL2q7XOsQFkYHiSCb+Xz/fZEo78bouiVGc5m8KfW4E6g07jZAECABQ01vAGAJKq
 J8SE5q8UTzS17Yaxfzwn+idH9SiJsoqqOCDbYJWffYEPhjnWLJKxsR9yfjJevexSCH
 08gaHDJZh05FA==
Date: Thu, 21 May 2026 17:56:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Vitor Soares <ivitro@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Vitor Soares <vitor.soares@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 01/15] dt-bindings: display: panel: Move Logic
 Technologies LT170410-2WHC to LVDS
Message-ID: <20260521-famished-tug-fc0582ef25ce@spud>
References: <20260521150038.103538-17-ivitro@gmail.com>
 <20260521150038.103538-18-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u32L7E4ABaNcVzrw"
Content-Disposition: inline
In-Reply-To: <20260521150038.103538-18-ivitro@gmail.com>
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


--u32L7E4ABaNcVzrw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 04:00:37PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> The Logic Technologies LT170410-2WHC is an LVDS panel, so move it to
> the correct bindings file.
>=20
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Am I missing a driver change in the series for this?
v7.1-rc1 has:

rg logictechno,lt170410-2whc
Documentation/devicetree/bindings/display/panel/panel-simple.yaml
210:      - logictechno,lt170410-2whc

drivers/gpu/drm/panel/panel-simple.c
5482:		.compatible =3D "logictechno,lt170410-2whc",

Additionally, please add a fixes tag.

Cheers,
Conor.
pw-bot: changes-requested

> ---
>  Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.y=
aml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> index b31c67babaa8..9db96dd724b2 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> @@ -58,6 +58,8 @@ properties:
>            - hydis,hv070wx2-1e0
>            # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color TFT =
LCD LVDS panel
>            - jenson,bl-jt60050-01a
> +          # Logic Technologies LT170410-2WHC 10.1" 1280x800 IPS TFT Cap =
Touch Mod.
> +          - logictechno,lt170410-2whc
>            # Samsung LTN070NL01 7.0" WSVGA (1024x600) TFT LCD LVDS panel
>            - samsung,ltn070nl01
>            # Samsung LTN101AL03 10.1" WXGA (800x1280) TFT LCD LVDS panel
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple=
=2Eyaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 3e41ed0ef5d5..f7e09f5b1b5e 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -206,8 +206,6 @@ properties:
>        - logictechno,lt161010-2nhc
>          # Logic Technologies LT161010-2NHR 7" WVGA TFT Resistive Touch M=
odule
>        - logictechno,lt161010-2nhr
> -        # Logic Technologies LT170410-2WHC 10.1" 1280x800 IPS TFT Cap To=
uch Mod.
> -      - logictechno,lt170410-2whc
>          # Logic Technologies LTTD800x480 L2RT 7" 800x480 TFT Resistive T=
ouch Module
>        - logictechno,lttd800480070-l2rt
>          # Logic Technologies LTTD800480070-L6WH-RT 7=E2=80=9D 800x480 TF=
T Resistive Touch Module
> --=20
> 2.54.0
>=20

--u32L7E4ABaNcVzrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag85VwAKCRB4tDGHoIJi
0sEYAP0cCw3TANbrGEYnHpU5zX+dLskUlcDYy4epUilNBiZk8gEAnEA2RszSf3e3
L8EmofrfI/SXEokuGY+IHPCC1borvQU=
=xbb1
-----END PGP SIGNATURE-----

--u32L7E4ABaNcVzrw--
