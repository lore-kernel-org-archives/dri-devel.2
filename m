Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756B8606D81E
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N06Vdasx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D30CD112DD8;
	Fri,  6 Nov 2026 14:00:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A8F112DD8
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:59:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B8FC4416AA;
 Fri,  6 Nov 2026 13:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4D01F008A3;
 Fri,  6 Nov 2026 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793973594;
 bh=R4E1+vz4FblZBo/5QbNVEIrD5R268ML/UsN7zYmG208=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=N06Vdasxp60o2sucIJ/Cn2IXVlrQ+/Nm35yRR42Sfylg68m9RnkRK/cPAhxB/pCp9
 IBWzaZ+PiBJw7XAQ2KpQlUaaNRfbaMa5QUJWYkXoDVB0+IPooVGCybH7UJNjKEJ6+O
 k0gC3CIRJ1MxMVae8CpAVPU/X/+awKY0N2UIk7acrBe4XG6b/YnTXPleG7bQ/G+Sa7
 ByQtOmsiiVhaYLo1pyAwWRInmoaFSGTL2YNvHrol/e0ikjWtXQ7XQnn1V/IjJlwH9A
 n0MQDGyKRlDpc4OoieCULjc1TZvl1Zprr9P1X5ZKBqin4Qw5ITokjQcBkGMG7srFdK
 Gjc4MKX7o2z9A==
Date: Fri, 6 Nov 2026 14:59:50 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 dri-devel@lists.freedesktop.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v8 01/39] drm/ingenic: Convert to devm_drm_bridge_alloc()
Message-ID: <au3dIHknXtTCcMwN@houat>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-1-cbe78624e1bc@kernel.org>
 <DMO6H6FTHD1T.36AXZ14RLKCXB@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="tr7vvpmccml25k6n"
Content-Disposition: inline
In-Reply-To: <DMO6H6FTHD1T.36AXZ14RLKCXB@bootlin.com>
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


--tr7vvpmccml25k6n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 01/39] drm/ingenic: Convert to devm_drm_bridge_alloc()
MIME-Version: 1.0

On Fri, Nov 06, 2026 at 02:55:47PM +0100, Luca Ceresoli wrote:
> Hi Maxime,
>=20
> On Fri Nov 6, 2026 at 2:14 PM CET, Maxime Ripard wrote:
> > The ingenic driver allocates a structure holding both the DPI encoder
> > and the source bridge of its pipeline, and allocates it as a whole
> > through drmm_encoder_alloc(). The bridge is thus not known to
> > devm_drm_bridge_alloc(), which drm_bridge_attach() already warns
> > about.
> >
> > The bridge private object also gets its name from the devm bridge
> > allocation, and drm_bridge_attach() will soon report a failure of
> > that initialization instead of ignoring it, so a bridge allocated any
> > other way would prevent the driver from probing.
> >
> > Allocate the structure through devm_drm_bridge_alloc(), making the
> > bridge the primary object of the allocation, and initialise the
> > embedded encoder in place with drmm_encoder_init(). Both objects
> > stay in the same structure, so the container_of() conversions keep
> > working, and the bridge funcs assignment moves into the allocator
> > call.
> >
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
>=20
> Seems there are now 3 competing patches to fix the same issue! :)
> This, [0] and [1].
>=20
> [0] https://lore.kernel.org/all/4f30341735d77c77a9a4952abd91879007bc00fd.=
1787604223.git.hns@goldelico.com/
> [1] https://lore.kernel.org/r/20261105203517.2293404-1-f.fainelli@gmail.c=
om

ouch, I completely missed those ptaches somehow, sorry.

> However yours does not add a call to [devm_]drm_bridge_add(), so I'd rath=
er
> prefer applying [1]. Also [1] removes the encoder pointer as it is not
> really necessary.

Yeah, that makes total sense to me

Maxime

--tr7vvpmccml25k6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCau3dTAAKCRAnX84Zoj2+
duAFAYDgaRiEX8PdXl7JOdWmQx2emylJV/tYxPcs5gu13Pc/OfHk29bqrusqaAa6
21OAMqgBf0IHjXhPpM6EhZoLEysYioQpXLCkoD5I7W+E32F+P7UQv+G6APIjRz9p
RTkqU65RYA==
=PZT6
-----END PGP SIGNATURE-----

--tr7vvpmccml25k6n--
