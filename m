Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F45606A882
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfUOhyLS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 072BE10F2EC;
	Mon, 16 Nov 2026 16:58:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F5FA10F304
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:58:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E653419D8;
 Mon, 16 Nov 2026 16:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0191F000C9;
 Mon, 16 Nov 2026 16:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794848299;
 bh=28901cIX8LutJN7iZwzr6+fi6Xac3bfXQpXleCz5pdM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cfUOhyLSHRjMvjLHeSt15CliGgMSiECm6zJkQDimqe383k/1idg2mmt69qKn35HaQ
 kMoqpSLNffIMFE1l65I6kTxKkV9IFa6fttBYIRk0EzZBRlpU5JDqdHuHRdX8SMREU6
 gAhLf/P6dTN6oa4ItRWka+OLSJ0gW6nNywdgFhCOCH10QdCPymIVgJPaa5IL11+0HN
 454nIqqhIaXDkXuf8YEP986jVpSdRYgEbAB3Ba7zVDG6mNjD8Y2DmN95Mox/fYiY8a
 Cqthn3L2bNBt1zcUpMR1Cfw6Ea2leS0CI2gV/q1yqsQ6jKd5WdmYF3z8twxeyBu3o/
 SiWDsi1Q4cWXg==
Date: Mon, 16 Nov 2026 17:58:17 +0100
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
Subject: Re: [RFC PATCH 1/4] drm/bridge: Add atomic_sro_install_state hook
Message-ID: <avs0ZoVZz2GomddQ@houat>
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-2-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="lmzupt35sow6obci"
Content-Disposition: inline
In-Reply-To: <20261116142707.1299360-2-maximpedraza@gmail.com>
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


--lmzupt35sow6obci
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 1/4] drm/bridge: Add atomic_sro_install_state hook
MIME-Version: 1.0

On Mon, Nov 16, 2026 at 03:27:04PM +0100, M=E0xim Pedraza Padilla wrote:
> The state readout core lets private objects take the resources needed to
> keep the hardware running when the state read out becomes current, but
> bridges have no way to use it. A panel left on by the firmware, for one,
> would stay marked as disabled.
>=20
> Add a bridge hook and call it from the bridge private object.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: M=E0xim Pedraza Padilla <maximpedraza@gmail.com>

It's something that was pointed out by sashiko here:
https://lore.kernel.org/all/sashiko-outbox-201494@kernel.org/

I've fixed it locally and I'm also passing the connector and CRTC state
to have the same prototype than readout_state and remove some boiler
plate.

It should be equivalent though.

Maxime

--lmzupt35sow6obci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCavs2KAAKCRAnX84Zoj2+
dmS7AX45DAEpHflpF7ISMe5Yuwcx9t/yXPjRSnjPLNwKxJOg1NdMNz50taAEU1nE
Ap6ZvM0BfR9bEhZjkDg6IrfjHAfxOG28DibKKQzO4rhkTxOznzzIZ3f2NRVoC5pH
ustIijD/Bg==
=BjAo
-----END PGP SIGNATURE-----

--lmzupt35sow6obci--
