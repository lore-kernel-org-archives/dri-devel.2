Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5DACD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 876DD10F26F;
	Mon,  8 Jun 2026 11:49:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dpOG3U1W";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4FEC10F26F
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 11:49:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14ADE600AE;
 Mon,  8 Jun 2026 11:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCBF1F00893;
 Mon,  8 Jun 2026 11:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780919394;
 bh=nFdNtghavPkO49U4EcRxEbi9WYJN1ii+kE+KtT1KUDE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dpOG3U1WrRJeiBEqaBoJK36je8mdnnCEPNYgNwsk3ypzR9d118Pg52By0kVReAsKJ
 SP6rM97MN12Tg2sbwATld2g51LadlEl5OJimZoNA22UIN46Mnf08ZIXDbfpVnoCm4c
 gDpzP//WSERMh2R2LVBD8H2MsXJU6hdP08xn3sbV4GRL3ySjwTZ57FlXK99gO5DVvp
 T6RQyBInrDQFcN9C2l6gDlSZkvqiiC/nbWmwl5APuCro4mczMRECEpLlNBHu2lZsNu
 ByVJWycrq+jWp331wJcUcGCdEEIcbtkutwlHR/TwXEy4BubbNCOklDlrwKfTkj47LV
 vGpIKAPhO/Zbw==
Date: Mon, 8 Jun 2026 13:49:52 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 17/37] drm/display: bridge-connector: protect dynconn
 creation and destruction with a mutex
Message-ID: <20260608-garrulous-silver-junglefowl-ea4dbe@houat>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-17-45e2bdb3dfb4@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="kb6asce5vlt2wt5a"
Content-Disposition: inline
In-Reply-To: <20260519-drm-bridge-hotplug-v1-17-45e2bdb3dfb4@bootlin.com>
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


--kb6asce5vlt2wt5a
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 17/37] drm/display: bridge-connector: protect dynconn
 creation and destruction with a mutex
MIME-Version: 1.0

On Tue, May 19, 2026 at 12:37:34PM +0200, Luca Ceresoli wrote:
> Bridge hotplug will make the connector dynamically created and destroyed
> based on hotplug events.
>=20
> In preparation for that, add a mutex to mutually exclude connector creati=
on
> and destruction.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

What is the source of concurrency, and what are you protecting against
exactly with that lock?

Maxime

--kb6asce5vlt2wt5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiasYAAKCRAnX84Zoj2+
di0AAX94uaZTqhbNpAYeTc4Vd1ntkbdCQHqbZYJkthn3BeRq3wcJvTCqGg1cc9Po
0g1ku/wBgK/hpwhwYSxughYVr0Z1+OHBXDZmkL5Tj1C4A/UfnJ+5h2aBwHPGNxUV
LU1oJ0q/FQ==
=ZsK8
-----END PGP SIGNATURE-----

--kb6asce5vlt2wt5a--
