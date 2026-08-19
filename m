Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425CEC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EDF310E4CB;
	Wed, 19 Aug 2026 17:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C7wVQXk2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F9910E4CB
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 17:21:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0980441A26;
 Wed, 19 Aug 2026 17:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857881F01566;
 Wed, 19 Aug 2026 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787160092;
 bh=7hRBHDUn1BDaihXaz0zsKwnj1fCJGun3+O7woq2k+pQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=C7wVQXk2KVOWh8gCvhqWvZMBu+BA7sphxtBr3hnsyZC56Q4+S/6BZexfTYA0fJBuF
 IeBq6PN0vuWsaVdU+WJsWOWc2WmVszZldmSHnhpmjlnz8HQs5jrco9gfcoJk6dHaM3
 LM/VVeJ/0QWBmTEnmtc1vT5cAy3LScGoHiekGS/NYiEcZ4VNVyVoqWemFdSa/YJkHi
 R7XH0GeHJwLIBgdpwSlk61fFaH1QIpBE7cU2sCXp+ZF01Nh/O1u30ZNfkJbHvuzCqo
 oD3fjo3mtNZCs+cADMlfzN9pfKd6aVcIKokYr4gFovYpXUfxbsENPp0TdvzXulzahS
 lrgFKxMaqWSbA==
Date: Wed, 19 Aug 2026 18:21:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3] drm/omap: Report HDMI hotplug events to the ASoC HDMI
 codec
Message-ID: <97c54f93-d929-40dc-9899-0f8a0b09b0e6@sirena.org.uk>
References: <20260819171935.233946-1-ivo.g.dimitrov.75@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5RT14txzp7bhe1x4"
Content-Disposition: inline
In-Reply-To: <20260819171935.233946-1-ivo.g.dimitrov.75@gmail.com>
X-Cookie: Allow 6 to 8 weeks for delivery.
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


--5RT14txzp7bhe1x4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2026 at 08:19:35PM +0300, Ivaylo Dimitrov wrote:
> The OMAP HDMI audio driver currently has no way of reporting HDMI cable
> hotplug events to ASoC. As a result, user space cannot detect HDMI audio
> availability through the standard jack mechanism and audio policy managers
> cannot automatically route audio to or from the HDMI output.

Acked-by: Mark Brown <broonie@kernel.org>

Please carry acks forward if you're not changing something relevant or
substantial :(

--5RT14txzp7bhe1x4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqF5hUACgkQJNaLcl1U
h9CwHwf/RGgFHGWvd5HWbeD/PDdYyw94nLRzChNH7R2DItBYKwxo7L+0TCrCodq9
eoa2eux+THrCOdxTd90A4o8eDlyLtY7NPeP+nQGaB4QqKzx5YzZyT98SPaBOMPPz
V5HHI5EdcJFy6M8A3DPg8oFbFuGvxOnMhLHLlT9luVs3xS80iUWS5vaJWJy+Tl6t
a3IxSljFaHJXB9/Mr6NySGI/qwpaiJR84DOOnA/Eux+1bmk1XkipoONqmU3JZSMS
Dd5q3dA/NzLXZigqdQs42Ykpo84SVEMd0SaP7SMyChx0HoR6EfQcg6P1VqEa5skK
mZUGMBSJKCS0h/as5D7LuEYNArdzlg==
=/+ea
-----END PGP SIGNATURE-----

--5RT14txzp7bhe1x4--
