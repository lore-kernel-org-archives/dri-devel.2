Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32346C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6829E10E831;
	Mon,  6 Jul 2026 08:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RLOO8DoQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7032610E831
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:52:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D1C4140B4F;
 Mon,  6 Jul 2026 08:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412BA1F000E9;
 Mon,  6 Jul 2026 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783327956;
 bh=wIgTYuQ7l0g07yaHqfXyOdwj4xENzmwI7JEobCJI7VA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RLOO8DoQdzaIda/SCOUZkb7TZDmZU8+VEb2miT3ha6NG/chlSw9oPS5iFZs+3FN+H
 ss1CRc7OnMp9UOKGS1o9kuNv8H+1WnAXgfMZL1xmi1//PS62mRhyUFxFEYFJL+D/1o
 xiYwfpJZZ+NfzcyQ7+yCE7NEbf16+AkAWuqVa/gUXNnPiqb/davqw58D/0MpB6YD/0
 CHy4FCrsaWs1rBgkqGiUqyGyo9FDZsOA8tjdAzLb1LyGVP9El/x+zSrRRkPx1xFibX
 fCA0bNZfLZn3cl19Fz14Q9+v2TA+kMfm8TTDKAVHZzs6mB9OCeZO3REbsT1q+LPdHr
 1UWcRfCM06mdg==
Date: Mon, 6 Jul 2026 10:52:32 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: vga-connector: Allow
 hardcoding EDID
Message-ID: <20260706-capable-beaver-of-excellence-a3cf10@houat>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-2-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="jpva27qzwjiuqi3k"
Content-Disposition: inline
In-Reply-To: <20260705213542.28987-2-laurent.pinchart+renesas@ideasonboard.com>
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


--jpva27qzwjiuqi3k
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] dt-bindings: display: vga-connector: Allow
 hardcoding EDID
MIME-Version: 1.0

Hi,

On Mon, Jul 06, 2026 at 12:35:39AM +0300, Laurent Pinchart wrote:
> Since DDC version 2, introduced in 1996, VGA monitors have exposed EDID
> data over an I2C bus. The bus is also used to detect the presence of a
> connected monitor by trying to read the EDID data.
>=20
> Some devices where the VGA display is integrated in the device and
> always connected do not connect the DDC pins. Some development boards,
> such as the Renesas M3N Salvator-XS, also do not connect the DDC pins.
>=20
> To support those, add the ability to provide hardcoded EDID data in the
> device tree. This is mutually exclusive with specifying a DDC bus, and
> can only be done when the VGA display is guaranteed to be always
> connected.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>

This feels redundant with the EDID firmware loading mechanism we have in
KMS already. It should at least be mentioned why we would need to set it
in the device tree at all.

Maxime

--jpva27qzwjiuqi3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaktsxAAKCRAnX84Zoj2+
duZWAX43C0adUSkYo2BCyUyrRlzje+lQ2rlOLgawSEEJ4RdYIn1llvkxQUUxz95n
cjgoCQcBgKZkLYlZB8XX1RTuVKcL/FZXQVybRx4SAV+4U5ftuAUjRItDGm9NzAfO
rM0iCuQS6A==
=EqG+
-----END PGP SIGNATURE-----

--jpva27qzwjiuqi3k--
