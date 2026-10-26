Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7166B606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGPri5U2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFFDD10E209;
	Mon, 26 Oct 2026 10:13:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3461E10E209
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:13:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E1B1C43715;
 Mon, 26 Oct 2026 10:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3AD1F01825;
 Mon, 26 Oct 2026 10:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793009613;
 bh=Wwm0RA616uK3DZBeNZnX3WAfh5hAfqzhZnzn43J/vds=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QGPri5U2a/AS8dwL1nFg9YlzA0Fi2GcF7+5wFBg0Z6u99iq/3h4ECvQ4XAKcEzxBT
 WHxKstg/IpgtfSk2uPMCnbgYlnr3Cz1JEpQq8i1WzJArsI6nIJL4xTYz/Bp5DC3vQm
 JBTbKrs+fdOKuryNN9LLuf2eU00v8q8WDAschLfQAL8dTmuwMkHJt1DxeIRo/CDhld
 ekBe2XrkOPZOpNlt1i2r0TBySLzcQv4P2X59SFspvFGQ4r2dmWFhgxoC9dVXIURxQC
 CB2IrFlPwfIEdVJAd96oH+NXFT+VlhiYD/1LnS3DCiDfz/NhOc9Ufi5KIF3GC7fkEk
 jRm6ZrA6pyZDA==
Date: Mon, 26 Oct 2026 11:13:30 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 22/28] drm/bridge_connector: Implement hw readout for
 connector
Message-ID: <at8nYEYsWh55jlzt@houat>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-22-6cc02cd10998@kernel.org>
 <2bb8d768-c8f2-4b2a-9a71-1194e1cbcbae@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="wtkju5eouja7vmj4"
Content-Disposition: inline
In-Reply-To: <2bb8d768-c8f2-4b2a-9a71-1194e1cbcbae@linux.intel.com>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--wtkju5eouja7vmj4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 22/28] drm/bridge_connector: Implement hw readout for
 connector
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 08:06:11PM +0200, Maarten Lankhorst wrote:
> Hey,
>=20
> For the series:
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

Thanks for reviewing it

> Would really love it if atomic_sro.[ch] is renamed to atomic_state_readou=
t.[ch], so
> we have a better idea what it's about. :-)

ACK

> 2 things to note:
> - Hardware readout may be succesful, but the resulting state may not be v=
alid.
>   Think for example a crtc with a DP-MST connector, but the DP-MST connec=
tor
>   is not yet detected at time of readout. crtc_state is invalid because c=
onnector_mask =3D 0.
>=20
> It would be awesome if DP-MST would be detected before this point. I'm no=
t sure this is
> actually possible but it would make fastboot work on DP-MST as well.
>=20
> - Alternatively some hardware may be connected to the wrong plane. Older =
i915 cards had a
>   flexible mapping of plane 1 being connected to crtc 1 or 2, but for opt=
imal performance you'd
>   want it to be plane 1 to crtc 2. BIOS chose plane 1 to crtc 1.

In both cases, I think it should be up to drivers to report that the
configuration doesn't make sense to them, and to fall back on a reset.
I'll add it to the documentation.

Thanks!
Maxime

--wtkju5eouja7vmj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCat8nyQAKCRAnX84Zoj2+
dn9+AYCIN0uWIKx6e9GHeAdoCIUbKcp4rLebOexxjW+N4C6eMrZXLPeFSCuH1hRW
poL3fz4BfREECMqOm7UKE8u+i2yG+w1SqkL8chwscQt5hjoC+juMPsI9oJ9AJ4wV
813ZH8VNiQ==
=82VD
-----END PGP SIGNATURE-----

--wtkju5eouja7vmj4--
