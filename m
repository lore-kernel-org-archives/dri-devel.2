Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C009FCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F27DE10E5B9;
	Mon, 22 Jun 2026 09:38:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UivVNvOI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06EBD10E5B9
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:38:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2248460051;
 Mon, 22 Jun 2026 09:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE1E1F000E9;
 Mon, 22 Jun 2026 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782121101;
 bh=Id1aDwPwK65QrmbSsCVlm+KO6gNxO+F+f3OzjJRBAxo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UivVNvOI86fO3Vaefe/GUWz88xuXnRdNYaaWQLdEsoNSFypwCKYXuNJVcagOuDOx9
 TSV6S3lGifHWeD0qo9ZmWqPwQSmjcQxg7qqd6NLdWFjY5b/0WY0XbkCuwC0UyKKp/q
 KoAIaHbIR66kyUVpbt6nEcZaGjpUrfjALA2lB8pbW/QfSh8RnXlqXJsasmbB238gso
 Zs5bMkElZKP8UrdYZzKIhFDXxBrks5EiLX81hgtSFpbHRrXe6Pr5LVmh5rxc1X3StG
 pWiXgpm+/xRigUqHnic1l3JxDJMkUQUs4oTL3SkBZBOA4hrL6tP3ad1EF1kZAvKu4Z
 TwF8kY1u/Ac6g==
Date: Mon, 22 Jun 2026 11:38:19 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/bridge: imx93-mipi-dsi: Fix mode validation
Message-ID: <20260622-strong-messy-hare-2372cd@houat>
References: <20260515-imx93-mipi-dsi-fix-mode-validation-v3-1-91f7d22b2fe4@nxp.com>
 <DJD6I8NMLN3W.3LVT4L17HT5TU@bootlin.com> <ajjpuroFPI_U2Fw6@raspi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="4lki2wyprf2do7cs"
Content-Disposition: inline
In-Reply-To: <ajjpuroFPI_U2Fw6@raspi>
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


--4lki2wyprf2do7cs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] drm/bridge: imx93-mipi-dsi: Fix mode validation
MIME-Version: 1.0

On Mon, Jun 22, 2026 at 03:52:26PM +0800, Liu Ying wrote:
> > Finally, out of my utter ignorance on the subject, is the VESA +/-0.5%
> > margin generic enough that this driver can always rely on it?
>=20
> I see several upstream drivers rely on it, see "git grep '0.5%' drivers/g=
pu/"
> output.  And every display mode allows -/+ 0.5% pixel clock rate deviation
> according to VESA Display Monitor Timing Standard [1], though [1] is a fo=
und
> by a random Google search.

Yes, it's what we've been using for some time now. Is there any
particular concern about it?

Maxime

--4lki2wyprf2do7cs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajkCiwAKCRAnX84Zoj2+
dn2NAYCjusnaBSXQclXmwY3AEMzqqxTj1CmUJL+6wWsRE+k9k0v5r5ASO8HI/G/s
MkWnjsQBf0BXjCandzhPC/6y7PGfq8bZ3ikevTtkM3UEjBFpirFQ9TqRTn+EDC0T
FJqJLbn8zg==
=h4Vk
-----END PGP SIGNATURE-----

--4lki2wyprf2do7cs--
