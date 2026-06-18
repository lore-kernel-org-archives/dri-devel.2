Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9B4CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E159D10E542;
	Thu, 18 Jun 2026 11:20:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lDJjZJYJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1432110E542
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 11:20:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 599E74450C;
 Thu, 18 Jun 2026 11:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7D51F000E9;
 Thu, 18 Jun 2026 11:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781781650;
 bh=on2p7v01JMLQEd/mSi9ZWJJJ8bOMuh6PkCqEPxyESE4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lDJjZJYJ44Uudg+UUCLEZ5y/sv+9qsCPzXEK/SlWqYFGHdqWrKYDhJ4GlvtafSPeG
 BkI9mR7gXaoUCd4fEyAkAOCIb6hs7ZVVEZxps+vtBfvMuGWrZ+g8P46pmqYV9yzIX7
 lDScLN3sjh5PcMVWfKktO2MLuQTjps9HxV3GWvOMA69qTMUNK+3zZ6+0hv4oo/XNzL
 DYxycW66o0SD0Q/+o9gPry+0FHF0e5kJQCNDSyN1ihKq5/tmrs+qsvdpnHSogWO5sP
 2rL8P9jMCTf9/vdXIynUS0O3GRdllKsChiOnpuT+MC4LBV5F17k1ryXsmIVt8EmV58
 ERuEDJonnxdFw==
Date: Thu, 18 Jun 2026 13:20:47 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, 
 Andy Yan <andy.yan@rock-chips.com>, Phong LE <ple@baylibre.com>, 
 Douglas Anderson <dianders@chromium.org>, Inki Dae <inki.dae@samsung.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
 Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>, 
 linux-rockchip@lists.infradead.org, Yannick Fertre <yannick.fertre@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2 00/78] drm/bridge: Convert all reset users to
 create_state
Message-ID: <20260618-terrestrial-abiding-tamarin-01befc@houat>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ozjpmz32viqzzrdv"
Content-Disposition: inline
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
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


--ozjpmz32viqzzrdv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 00/78] drm/bridge: Convert all reset users to
 create_state
MIME-Version: 1.0

Hi,

On Mon, Jun 08, 2026 at 04:35:42PM +0200, Maxime Ripard wrote:
> Hi,=20
>=20
> All the bridges use reset to create a blank state only and don't use it
> to reset the hardware at all. This is what the new atomic_create_state
> is exactly supposed to be doing, so we can convert all existing bridge
> users to it, and remove the reset hook and helpers.
>=20
> Let me know what you think,
> Maxime=20
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

FTR, Thomas on IRC yesterday[1] added
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Unless another review shows up, I intend to merge this tomorrow

Maxime

1: https://oftc.catirclogs.org/dri-devel/2026-06-17#35422999;

--ozjpmz32viqzzrdv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajPUigAKCRAnX84Zoj2+
dk0JAX0RbkGWPGoPi2IhEx+Ot7RE2mv5pF2NW5NdvgyvbZjvKNkWJ3WWtN4N+yZb
Ll4R1c0BgNqzNQmnFhM4Nh5uf+0aPC7FMvJmkSeQcUNUGNIKHOukmjyX3PgrtUcT
RE+nxMSDvw==
=eAVV
-----END PGP SIGNATURE-----

--ozjpmz32viqzzrdv--
