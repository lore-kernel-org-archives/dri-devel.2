Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCA9CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 19:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356EA10E211;
	Thu, 21 May 2026 19:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i57ejD7i";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D8910F3FB
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 19:47:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9963842A4F;
 Thu, 21 May 2026 19:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C9D1F000E9;
 Thu, 21 May 2026 19:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779392836;
 bh=iF7iL7b/eRDZExcU9oluR8iOMC8+YXUjPYKBmp/PXRQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=i57ejD7ipwYFQoYWQOyHZ7JiWI6LhNi0bmQ7pOyatQLUHO78lk7wAp/pp7EVRJq1W
 B9Fu2aQRrMb550LkpweJltALl/A7ruzHvdvjGGpnlJXVCQhLpfvpT2VRvcbBZiRGho
 0uDP5ogr6juioZwvu9JzIgvz38yZyg09LRpnAZjzWB4CTKgSSR+vInl5aqbtvuCpI9
 qNJ5d1JN6+e7LWgbZiVwj8xmGmxhTIFywUwDgfzuMAGM57BQfkFUTLuoADKx0OM14j
 HYYscXdi7VS8RtTcZe4Bw0dAMtpU1ipYgyQdv0xuGIDB2xS/lrs4fcvoEJm9Sqxmge
 wpdhHfJNTn4aQ==
Date: Thu, 21 May 2026 20:47:09 +0100
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
Subject: Re: [PATCH v2 2/3] dt-bindings: rockchip: analogix-dp: Add
 data-lanes example
Message-ID: <20260521-powdery-tux-22a7cf4fadc3@spud>
References: <20260521114459.1394264-1-damon.ding@rock-chips.com>
 <20260521114459.1394264-3-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kjL5jhnqIDr4AwIY"
Content-Disposition: inline
In-Reply-To: <20260521114459.1394264-3-damon.ding@rock-chips.com>
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


--kjL5jhnqIDr4AwIY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 07:44:58PM +0800, Damon Ding wrote:
> Add data-lanes setting in endpoint example to show actual lane mapping
> usage.
>=20
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

Squash this with patch 1.
pw-bot: changes-requested

Thanks,
Conor.

> ---
>  .../bindings/display/rockchip/rockchip,analogix-dp.yaml          | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,=
analogix-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockc=
hip,analogix-dp.yaml
> index bb75d898a5c5..cf75c926318b 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogi=
x-dp.yaml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogi=
x-dp.yaml
> @@ -151,6 +151,7 @@ examples:
>            reg =3D <1>;
> =20
>            edp_out_panel: endpoint {
> +            data-lanes =3D <0 1>;
>              remote-endpoint =3D <&panel_in_edp>;
>            };
>          };
> --=20
> 2.34.1
>=20

--kjL5jhnqIDr4AwIY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag9hPQAKCRB4tDGHoIJi
0noXAP9aPT5KoIziqejJtByAcYmbw2ijtjzmEvaq71WErlg8vAD/d5xCbobJ1rmC
s9sTZuiq/HBvQLv/KjXIx0LIEV43OwY=
=PVrf
-----END PGP SIGNATURE-----

--kjL5jhnqIDr4AwIY--
