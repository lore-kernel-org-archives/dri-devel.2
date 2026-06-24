Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEECDCDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19DB210E081;
	Wed, 24 Jun 2026 11:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q4d4gG0x";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC7C910EED0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 11:41:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E7EC260018;
 Wed, 24 Jun 2026 11:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBAE1F000E9;
 Wed, 24 Jun 2026 11:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782301317;
 bh=ShjfYmyMNme2ZizdbgTF3XrR13Mrtlb7YIX/iZpb3NM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Q4d4gG0xlLhiN/laQaD2KxgfY6UFlil4u8XQNprH7J2MSCUUdd8qV/+cDhwB3QtZK
 A3JA6NCXYZdoq9VYSQ5GCWV/NHqR9EYFUxUmaqU/q6UjqLnHFxWX+rx++I86gG54Hj
 8ux3dka1wQcydp24WchfAPwsThjr8kdq9Y1ZbtZ3ZyE4dkb/yClBQFX4D6A431eh/I
 wn/+j/we6znBedCsjX1akjh7ufk5ww4Jf9Tsk9ZGqGf1eXNF577wsIFd3ZMFhCk2sh
 KZ0/fBzt6PZoCIu5CU1t3Fv1x2jjqrq07R5xiiNFO5uR+hcKvZeGMbP2wF1/JIRDch
 OcxLRr6EnqkmQ==
Date: Wed, 24 Jun 2026 13:41:55 +0200
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
Subject: Re: [PATCH 05/37] drm/display: bridge-connector: split code creating
 the connector to a subfunction
Message-ID: <20260624-proud-unbiased-pony-ecc3c3@houat>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-5-45e2bdb3dfb4@bootlin.com>
 <20260608-mindful-heavy-frigatebird-be9faf@houat>
 <DJ735MTNMYD1.3LPNV404V8PIU@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ggct6afei637l4eq"
Content-Disposition: inline
In-Reply-To: <DJ735MTNMYD1.3LPNV404V8PIU@bootlin.com>
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


--ggct6afei637l4eq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 05/37] drm/display: bridge-connector: split code creating
 the connector to a subfunction
MIME-Version: 1.0

Hi,x

On Fri, Jun 12, 2026 at 02:56:24PM +0200, Luca Ceresoli wrote:
> On Mon Jun 8, 2026 at 1:40 PM CEST, Maxime Ripard wrote:
> > On Tue, May 19, 2026 at 12:37:22PM +0200, Luca Ceresoli wrote:
> >> In preparation to introduce bridge hotplug, split out from
> >> drm_bridge_connector_init() the code adding the drm_connector into a
> >> dedicated function. This will be needed to be able to add (and re-add)=
 the
> >> connector from different code paths.
> >
> > Same story here, explaining what you need later on that calls for that
> > change would be nice.
>=20
> Here's a more verbose version:
>=20
>     Currently drm_bridge_connector_init() does two things:
>=20
>      * allocate and initialize the drm_bridge_connector
>        (which embeds a drm_connector)
>      * initialize and register the embedded drm_connector
>=20
>     For bridge hotplug we need to separate these two actions:
>=20
>      * the drm_connector needs to be added and removed at any time based =
on
>        hotplug events
>      * the drm_bridge_connector is designated to create and remove the
>        drm_connector, so it must be persistent for the card lifetime
>=20
>     As the lifetimes of drm_bridge_connector and drm_connector become
>     different, we need to create them in different moments.
>=20
>     In preparation to support that, split out from
>     drm_bridge_connector_init() the code adding the drm_connector into a
>     dedicated function. No functional changes, just moving code around for
>     now. A future commit will make the drm_connector be created based on
>     hotplug events.
>=20
> Looks good?

The message itself, yes, thanks.

However, I have questions now :)

Do we really expect drm_bridge_connector to stick around when a bridge
gets unplugged? If so, how does it cope with having, say, an HDMI
connector, and then swapping out the hotplugged part for an LVDS one?
Does the HDMI connector sticks around indefinitely?

*Especially* if we're using overlays for this, I'd expect everything
 after the first hotplugged bridge to be destroyed, no?

Maxime

--ggct6afei637l4eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajvCeAAKCRAnX84Zoj2+
dhuUAYDFJqooNqUx588XAwTFLaml7a7KW4JruaolEF1p9BhcIvYFBDvNrKfeFNmP
g/vAax4BfRNosW1vwCuAixIjSRCuI4sKHQdfzCecAWgVrpSjTSYU7afdO4ghM4Js
DadrDa7/6Q==
=c8Y7
-----END PGP SIGNATURE-----

--ggct6afei637l4eq--
