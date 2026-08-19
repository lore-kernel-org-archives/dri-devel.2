Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69256C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACFC310EE41;
	Wed, 19 Aug 2026 16:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aCPKWdW/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB4310EE41
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:02:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA8AC40DDD;
 Wed, 19 Aug 2026 16:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A241F000E9;
 Wed, 19 Aug 2026 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787155375;
 bh=mBP9dO6Q/bvbXIl75vBb536XRgmUvlYwCnveiX5a954=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aCPKWdW/+OYHGAA/d+P75uuFWP2Nh6Kiitq/2V86zurtN7ipwLB/kuoR7zF6m8c4G
 ccd9Ce0YerNgy08NXG+7DJgxM2Fm11Za5uqx3smWj8BQSGt6/15VtEVOkxPhxvKQWM
 dGHlYSsmu0cQEQ4CKq++EvmAurF6CpCmtAwXNlKCjf+ZZcMvW0RCBlOhPv4Hyv62ck
 bX+DI7AKK6lKknQ3zW5PPBOGDhGyih1ALFjNX51HSsGiMVsk4PJw0oLWpEbqJHUB2a
 uaNy69dYlS7/9nMtoPlo1m9C5JOVy8ZxTVawYyNFjS/D5OALMcTLUsTi77Gn6Ty51v
 yePycMa54gy6A==
Date: Wed, 19 Aug 2026 17:02:49 +0100
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
Subject: Re: [PATCH v2] drm/omap: Report HDMI hotplug events to the ASoC HDMI
 codec
Message-ID: <5681ef2c-b839-40c0-8e6b-65fff0f45af1@sirena.org.uk>
References: <20260819152755.231754-1-ivo.g.dimitrov.75@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MQ01EvtHPHipj7q0"
Content-Disposition: inline
In-Reply-To: <20260819152755.231754-1-ivo.g.dimitrov.75@gmail.com>
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


--MQ01EvtHPHipj7q0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2026 at 06:27:55PM +0300, Ivaylo Dimitrov wrote:
> The OMAP HDMI audio driver currently has no way of reporting HDMI cable
> hotplug events to ASoC. As a result, user space cannot detect HDMI audio
> availability through the standard jack mechanism and audio policy managers
> cannot automatically route audio to or from the HDMI output.

Acked-by: Mark Brown <broonie@kernel.org>

--MQ01EvtHPHipj7q0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqF06kACgkQJNaLcl1U
h9DpdAf/S3p8MPqnz9KwPNCp+UwvEKPcDvaRSrCOAn+pwyWuM38JSGKf5e8YDppb
NipzSeRdVpTTqBH+jpHeEfGL/lUIymIp78WQ+n0duIJan/+nGh7PFvHGUkg9DgeN
OZH9s67Qb2jTX7Qpg1Zi6dFsQtYZaeb0yqUdyAlXQG8OzgNlYOObVNAEMRkv4fIw
0uNxOvImEsa6ou+1iAt68UWrjLqmvgp5SoLAP4DXDbdQpNkToL6HrFcT/Tz0lUqU
qSJ0p9T1F195FBe7V/19F6mVDFUWMVyg9sZUkGadwY/OKRO1OrbCDrGFURiVo0wn
nHhEpZ1rTabiMUix6PZrkVoTpzd8aQ==
=SgaR
-----END PGP SIGNATURE-----

--MQ01EvtHPHipj7q0--
