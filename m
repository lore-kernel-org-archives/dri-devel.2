Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9861CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C449B10F2BA;
	Mon,  8 Jun 2026 12:13:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RZ+J9veU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A73F10F2BA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 12:13:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D461B6001D;
 Mon,  8 Jun 2026 12:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A4A1F00893;
 Mon,  8 Jun 2026 12:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780920817;
 bh=dVFWP3GNrTJaexAUIBVYQBFb3h/KTDbLem6EUXiGJ/4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RZ+J9veUqF8Fl2PsWnsthwntmy4yB8Vgu3V+te2uXVpDhIeXYFAtVU1PM3ocG7fHA
 tB2T99LU0ZAhbuLnDhuoAqSdBf4My3v6Z+Hea8zwKPb3DS4MpgesiRoT2mrCHVReEi
 5z/WUcWqMGSgjt6VJIIeUEEfcwpluaNtZT63Ab14e5kLP8XFVFbOAN/x7AFd+nxER7
 RM4XF1Ipm5zb8TTwUNuPJanI7QrsGH0ML6R+O4t3BzZRypaFhm6hzH/p+KizKpSYMo
 InjNR6OGSqSpipJcrNOVBqIHpQdvwqY/66tXRR0lP5G7DkkfWS/0O6JAGNHjXY30NT
 nUF0cOxOVkZpw==
Date: Mon, 8 Jun 2026 14:13:35 +0200
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
Subject: Re: [PATCH 26/37] drm: event-notifier: add mechanism to notify about
 hotplug events
Message-ID: <20260608-maize-rooster-of-youth-c0bbde@houat>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-26-45e2bdb3dfb4@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="5ps7hsgvymsq744t"
Content-Disposition: inline
In-Reply-To: <20260519-drm-bridge-hotplug-v1-26-45e2bdb3dfb4@bootlin.com>
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


--5ps7hsgvymsq744t
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 26/37] drm: event-notifier: add mechanism to notify about
 hotplug events
MIME-Version: 1.0

On Tue, May 19, 2026 at 12:37:43PM +0200, Luca Ceresoli wrote:
> In preparation for supporting DRM bridge hotplug, add an event notifier to
> allow interested parties to be notified about events they need to react t=
o.
>=20
> For the initial implementation of bridge hotplug, two events are needed:
> bridge detach (happening in drm_bridge.c) and MIPI device attach to MIPI
> host (happening in drm_mipi_dsi.c).
>=20
> For this reason implement the event notifier in a new common file that
> event producers can easily use to send events.
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

So, you claim in the commit message that it's about a hotplug event, but
the only events are the bridge being attached and detached, so not a
hotplug event?

And why a bridge would want to be notified that itself (or another?)
bridge is being attached or detached?

You need documentation, and a more descriptive commit message.

Maxime

--5ps7hsgvymsq744t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiax7gAKCRAnX84Zoj2+
dqQyAYCvmUaxgNxWxUbIYzxFnnkM5+8MEGlG1BqE/IKDGDWRhZcO0lC7Qi+M/RST
yEaCp/EBf2kfK8jL8dIt4xniVD4PeoFbfO6bwkG7Y26AHxLNSH5XJzzXNAee83dc
h/QaFuJNjg==
=arxN
-----END PGP SIGNATURE-----

--5ps7hsgvymsq744t--
