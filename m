Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CD1CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 08:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A92910F49F;
	Fri, 19 Jun 2026 08:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VX1xqdXy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D3D10F49F
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 08:02:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 579DB601E2;
 Fri, 19 Jun 2026 08:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899AC1F000E9;
 Fri, 19 Jun 2026 08:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781856167;
 bh=xkcshnw1gxjX4tr71f8q+7p4aYdSYkLzih8Gswfa63Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VX1xqdXy5ZgVVUVbhAFKZQD/I2U1ax331wkbCcA0RM4VkCmUOUhDxp0D4rDzgHEhS
 FI5+m0DY4BhpDKAp7brCIepBLs4igHave5wPqTr8JVc41shP92JpBQNKI4AKi4SIVO
 DNGsBcvb2rjPDy4a55ICty5L3Nok9QLAjBaHOjbU2qv4u0+6quSmPhJ7jMuz+TV9qE
 exSWlpQ6lUzfzkPmWNXVvub4rRD/FzEiyRkOpX4Ncq0ztasRLIN+xqnfrBmGOHB+sQ
 gBPqdsUI6I3/xAXNAVxI7MQK3KXEA5OMLqH/ZUPFoiFiUzPO9lKU2BLwW7Chs3S2pr
 QhmhtBUfudI2A==
Date: Fri, 19 Jun 2026 10:02:43 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 07/78] drm/atomic-state-helper: Add
 drm_atomic_helper_bridge_create_state()
Message-ID: <20260619-provocative-mindful-boobook-d7d2c8@houat>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
 <20260608-drm-no-more-bridge-reset-v2-7-0a91018bf886@kernel.org>
 <178171213665.312625.18415471327369488806.b4-review@b4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="gwe363eagz264urn"
Content-Disposition: inline
In-Reply-To: <178171213665.312625.18415471327369488806.b4-review@b4>
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


--gwe363eagz264urn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 07/78] drm/atomic-state-helper: Add
 drm_atomic_helper_bridge_create_state()
MIME-Version: 1.0

On Wed, Jun 17, 2026 at 06:02:16PM +0200, Luca Ceresoli wrote:
> On Mon, 08 Jun 2026 16:35:49 +0200, Maxime Ripard <mripard@kernel.org> wr=
ote:
> > The drm_atomic_helper_bridge_reset() helper is deprecated in favour
> > of the new atomic_create_state callback.
>=20
> I understand this series is eventually removing it, but it does not seem =
to
> deprecated (in the kdoc at least). So maybe the commit message should eb
> reworded as "The drm_atomic_helper_bridge_reset() helper is about to be
> removed..."?

Sorry, I meant to reply but forgot. I guess it really depends on what
you call "deprecated", but it's very much something we want to move away
=66rom when creating a new state only. It might not have been as clearly
documented as one would have hoped, but I don't think it's worth
documenting something we'll remove in this series, or change the commit
message.

Maxime

--gwe363eagz264urn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajT3owAKCRAnX84Zoj2+
dhhpAX9pUTWsgCB8wmh5OItyRV23RFGOoZpesQit7qbR51CEf003374xZzKlVnEH
ZIEICSQBgIlG3mN6pZRPp5roANGbdGDnAA0aVwUBq1UjlTPVJ9H/vSf9RxAZIgAA
qB6bjfvdTg==
=IgnP
-----END PGP SIGNATURE-----

--gwe363eagz264urn--
