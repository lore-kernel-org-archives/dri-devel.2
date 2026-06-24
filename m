Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4907CDE001
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B9410E4FE;
	Wed, 24 Jun 2026 15:28:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MWwciLsG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6519A10E4FE
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 15:28:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 67525601FC;
 Wed, 24 Jun 2026 15:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24961F000E9;
 Wed, 24 Jun 2026 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782314894;
 bh=omFTQIQRVhlWvznBGjtYR1dIn7Th/fXo3gPll9BtF0s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MWwciLsG63euJF5Y1+vJRO+66DXAp0XTKvJYM+C7wkaGE3E0xG5imDkRZdjCCW3/S
 TEwVtdQBED1NWKWMe5ofm4xRAQ1F4E2aZBtF4a6jlB+qwB1WmzPWCJuIT+Q7a11h/7
 d4E/w+g1DCxDpmlVvNm163x6FACUIdDEegjNLeE5qTytE84KVx7L4DzdDFwingmwq3
 QThsF0JzoygSvyxOiBZaF+Eij72Ei75qyJ/GYQvqm1fyfGHN8TASB5xAYx6pBxxhdQ
 RphSsUKsa3nH/c6iv+852gIDr1yaQyOxp+rIH2Lc4sg1lMRL6zjnLWMBA4cYOC6NYX
 KTW+qvKmM13RQ==
Date: Wed, 24 Jun 2026 17:28:11 +0200
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
Subject: Re: [PATCH 19/37] drm/bridge: samsung-dsim: move drm_bridge_add()
 call to probe
Message-ID: <20260624-courageous-accomplished-sambar-0e3cf8@houat>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-19-45e2bdb3dfb4@bootlin.com>
 <20260608-mellow-weasel-of-politeness-a56172@houat>
 <DJ63DNXUOW46.1DI6982PGPFRR@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="6lai7mk4murtip2q"
Content-Disposition: inline
In-Reply-To: <DJ63DNXUOW46.1DI6982PGPFRR@bootlin.com>
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


--6lai7mk4murtip2q
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 19/37] drm/bridge: samsung-dsim: move drm_bridge_add()
 call to probe
MIME-Version: 1.0

On Thu, Jun 11, 2026 at 10:54:14AM +0200, Luca Ceresoli wrote:
> On Mon Jun 8, 2026 at 1:58 PM CEST, Maxime Ripard wrote:
> > On Tue, May 19, 2026 at 12:37:36PM +0200, Luca Ceresoli wrote:
> >> This bridge driver calls drm_bridge_add() in the DSI host .attach call=
back
> >> instead of in the probe function.
> >>
> >> This works for current use cases but is problematic for supporting hot=
plug
> >> of DRM bridges. The problematic case is when this DSI host is always
> >> present while its DSI device is hot-pluggable. In such case with the
> >> current code the DRM card will not be populated until after the DSI de=
vice
> >> attaches to the host, which could happen a very long time after bootin=
g, or
> >> even not happen at all.
> >>
> >> The reason is that the previous pipeline component (the encoder in this
> >> case) when probing cannot find the samsung-dsim bridge. What happens i=
s:
> >>
> >>  [1 and 2 can happen in any order, same result]
> >>  1) samsung-dsim probes (does not drm_bridge_add() itself)
> >>  2) The lcdif starts probing multiple times, but
> >>     lcdif_probe
> >>     -> lcdif_load
> >>        -> lcdif_attach_bridge
> >>           -> devm_drm_of_get_bridge() returns -EPROBE_DEFER because
> >>              the samsung-dsim is not in the global bridge_list
> >>              (deferred probe pending: imx-lcdif: Cannot connect bridge)
> >>
> >> The samsung-dsim will not drm_bridge_add() itself until a DSI device w=
ill
> >> try to mipi_dsi_attach() to the DSI Host, which can happen arbitratily=
 late
> >> on hot-pluggable hardware.
> >>
> >> As a preliminary step to supporting hotplug move drm_bridge_add() at p=
robe
> >> time, so that the samsung-dsim DSI host bridge is available during boo=
t,
> >> even without a connected DSI device. This results in:
> >>
> >>  1) samsung-dsim probes (and adds to drm_bridge_add() itself)
> >>  2) The lcdif starts probing multiple times, but
> >>     lcdif_probe
> >>     -> lcdif_load
> >>        -> lcdif_attach_bridge
> >>           -> devm_drm_of_get_bridge() --> OK, returns samsung-dsim ptr
> >>
> >> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> >
> > We should probably amend
> > https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html#special=
-care-with-mipi-dsi-bridges
> >
> > To mention this use case here
>=20
> Right. I haven't updated the docs for this v1 because I was not sure the
> overall approach would be acked. Now Dmitry acked it overall, and I kind =
of
> infer you are not against, so I'll look into updating the docs in v2.
>=20
> However I find that section of the docs a bit hard to read especially from
> a newcomer perspective.

It's a complex problem, so I don't think we should expect the target
audience to be newcomers. But maybe we can indeed improve it.

> A better understanding on my side would help in doing the right change as
> far as this patch is concerned, and as a bonus in improving the section
> overall (that would probably be a separate series).
>=20
> So I have a couple questions to start from:
>=20
>  * Do I understand correctly that using the component framework is legacy,
>    not recommended for new DRM development, and that converting existing
>    code to stop using it is welcome?

No. It's not legacy or deprecated. And about the conversion, I guess
it's on a case-by-case basis? It's not encouraged or discouraged anyway.

>  * The first bullet quotes "The upstream driver [...] isn=E2=80=99t a MIP=
I-DSI
>    host". If the upstream driver of a MIPI DSI link isn't a MIPI DSI host,
>    what else could it be? What are the use cases here?

Nowhere is it said that we're considering a MIPI-DSI link here, so the
use case is any bridge that isn't using MIPI-DSI at all.

>  * If read literally, none of the 4 bullets after "Indeed, there=E2=80=99=
s multiple
>    cases that needs to be considered" covers this driver (it does not use
>    the component framework, it does not use DCS, and the upstream device =
is
>    a DSI host). However the 3 bullets after "The ideal pattern to cover t=
he
>    last item" appear to cover what this driver does.  Do we need a fifth
>    bullet for drivers like this one? Or...?

You tell me :)

How does hotplugging, say, a MIPI-DSI device bridge controlled over I2C,
or a MIPI-DSI host bridge, affect the probing sequence, and can we end
up in endless probe deferrals?

>  * To me it looks like the "bridge" word in this section is always used to
>    refer to the DSI device. Would it make sense to replace "bridge" ->
>    "[DSI ]device" in this section?

Not necessarily, and from a KMS point of view, MIPI-DSI doesn't exist,
only bridge do.

> (especially as the DSI host is also a DRM bridge)

It doesn't have to be.

Maxime

--6lai7mk4murtip2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajv3iwAKCRAnX84Zoj2+
duzoAXwNLrlwbdRVOYJst2aEhp0uYJGAm5tIpEDFk6nna1bvwjexNutjjip1PsuX
Q5nRIp8BfjUUZUv5AvWGCN66UaMIQLhHvpEc90SzFlp6unG3JHRbNagYQSqgYtJ7
G/DYfRqPEw==
=edwN
-----END PGP SIGNATURE-----

--6lai7mk4murtip2q--
