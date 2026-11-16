Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B1E606A881
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f+xOLJta
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3D810F2F1;
	Mon, 16 Nov 2026 16:59:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2971C10F30E
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:59:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0FF3E41F20;
 Mon, 16 Nov 2026 16:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684801F000C4;
 Mon, 16 Nov 2026 16:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794848357;
 bh=ffOKEOU+c1efPY0a7/5sofWUhU7nKRfTUK4+Ozkrz44=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=f+xOLJtaXXu80ICU4ezzUIy/C2ivB/ytpmw0UpRzNg4cfB4FkOYMa6BOwIuAAKg4G
 rHmQqpdbH+qSdVHag8Agx6t+IA+wG2es74VOC0PlXmwpVhxntnO8vb8hsAZQXMnAx3
 KxGI57FY+Hxbm3FVwww+7ap00XJYL985/0KK9M8PY9aoD9ST49GKyoLIcUlafgt+8h
 dWrXT8/3ut6F/RJnyeXBn9X27V923pLHsBZDICyw8HZC0OtBy/qwan793h37gWjrCH
 yLg6LI8XyqPilBN23oWD3GGYPsBVp7nfJzGbB79Nhwyhs7x9SFE+6htme6M0F5tq7F
 CwSHzfQZ5jbPA==
Date: Mon, 16 Nov 2026 17:59:15 +0100
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] drm/panel: Implement state readout in the panel
 bridge
Message-ID: <avs2UlrgIbytzjXP@houat>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-3-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="agnuzcvatz5y3bqy"
Content-Disposition: inline
In-Reply-To: <20261116142707.1299360-3-maximpedraza@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--agnuzcvatz5y3bqy
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 2/4] drm/panel: Implement state readout in the panel
 bridge
MIME-Version: 1.0

On Mon, Nov 16, 2026 at 03:27:05PM +0100, M=E0xim Pedraza Padilla wrote:
> The state readout core gives up if a private object doesn't implement
> readout, so a driver using a panel bridge can't adopt the firmware state,
> even if it implements readout itself.
>=20
> A panel has no state to read back: it's part of the pipeline if the CRTC
> feeding its encoder is active. Implement the connector and bridge readout
> on that assumption, relying on the encoder's
> atomic_sro_get_current_crtc hook, and fill the bus configuration with what
> the commit negotiation would give.
>=20
> When the state is installed, prepare and enable the panel, since nothing
> else would until the first modeset.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: M=E0xim Pedraza Padilla <maximpedraza@gmail.com>

That one looks super similar to
https://lore.kernel.org/all/20261106-drm-state-readout-v8-38-cbe78624e1bc@k=
ernel.org/

Maxime

--agnuzcvatz5y3bqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCavs2YgAKCRAnX84Zoj2+
dk+iAYC1Y1Lea7UEPsWD/Lcd5hBam/6rLDGIEeDjZ9Wa5gElwq+2V9lXOR+BG+ZT
yqgKhoUBf20Zl9Of2WPiTvXmZE7VDzhNeaV2MM/qrkPOx7qZkDeKy3tCO+d54zoO
FJa4EvkEiA==
=iF77
-----END PGP SIGNATURE-----

--agnuzcvatz5y3bqy--
