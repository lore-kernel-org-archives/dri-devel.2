Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7BBCC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E335F10F5F8;
	Tue, 13 Oct 2026 08:37:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 047B610F5E7
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:37:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2792B60261;
 Tue, 13 Oct 2026 08:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A7A1F000FF;
 Tue, 13 Oct 2026 08:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791880642;
 bh=WRpmvYv+ZNHPv0I7UH9P9Kj0D4/Ue1p27eqvcGdqnKE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=eiJ5VlVDu+UtR3o0UbErr8NQLnWfLuLzU18bppw7mY67CzJ62MegODL0S3vyVE40l
 ARmcEUb6vjfKBQOwsfAeO7UdzKmQ1aekbTlT/PnDMQ0u4x7UxKU5A8RCALumAJnGFI
 ff965vRfHrBzwkmDRdCmRahdAbvgn4L8Hi9S2mKMHGDDHBs5Bz6vIKoX+9gZJUTQl5
 rjtsvys512F+XvenGtUjLF5bitxr13v8ekaQOiWV2/fnx240C0pdbMFBfeo831900P
 0ZIdGGAy6pwI6EdlGGSf8Iirx320lLfxd4fYGQBnbBwFrQ7ko2ow3H9g/UeIiyXG3T
 QNFXH9uNGc3fQ==
Date: Tue, 13 Oct 2026 10:37:19 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Val Packett <val@packett.cool>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/9] drm/panel: add atomic state
Message-ID: <as3sI-N3VeG_pL0U@houat>
References: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
 <asyAObcpbFy3OeE2@houat>
 <7pptulwzceqg7xozps5boncgcpd5fpw2pdabcslp4den34ixjn@rzgkoe36itwm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="krwoug773liv5dfc"
Content-Disposition: inline
In-Reply-To: <7pptulwzceqg7xozps5boncgcpd5fpw2pdabcslp4den34ixjn@rzgkoe36itwm>
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


--krwoug773liv5dfc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 0/9] drm/panel: add atomic state
MIME-Version: 1.0

On Tue, Oct 13, 2026 at 10:51:38AM +0300, Dmitry Baryshkov wrote:
> On Mon, Oct 12, 2026 at 08:40:33AM +0200, Maxime Ripard wrote:
> > On Thu, Oct 08, 2026 at 04:14:22PM +0300, Dmitry Baryshkov wrote:
> > > Panel drivers don't have an atomic state and so they can't handle
> > > additional data to be stored at the atomic_check time or to be retrie=
ved
> > > at the enable/disable time. For example, it prevents panel drivers fr=
om
> > > supporting multiple display modes or making DSC being optional in a
> > > clean way. Drivers like panel-novatek-nt35950, save the connector
> > > pointer in get_modes() and later dereference
> > > connector->state->crtc->state from prepare() without holding any lock=
s.
> > > The panels also have no way to reject the configuration they cann't
> > > handle, as it doesn't take part in the atomic check.
> > >=20
> > > The panel already embeds a drm_bridge, and the bridge has an atomic
> > > state which is property handled. Subclass it to provide atomic state =
for
> > > the panels. The callbacks can find the state of the other related
> > > objects (e.g. CRTC state to get the display mode).
> > >=20
> > > The atomic state is opt-in. A panel that doesn't implement the state
> > > callbacks keeps working exactly as before, with the plain bridge stat=
e,
> > > so there is no need to touch the existing drivers. The panels which do
> > > implement them can only be driven through the embedded bridge, since
> > > there is no commit to hand over when the host calls drm_panel_prepare=
()
> > > and friends directly. Those entry points warn and refuse to handle su=
ch
> > > panels. There are still a dozen of display drivers calling these
> > > functions, and the panels used with them can not be converted until t=
he
> > > hosts are switched to the panel bridge.
> >=20
> > I really don't think we should extend the panel API. All panels are
> > bridges now, consumers only care about bridges as well, and the bridges
> > API provides what you want already.
> >=20
> > Why not simply turn the panel drivers we want into bridges, possibly
> > with a bunch of specialized helpers to manage a panel state, and call it
> > a day?
>=20
> I think that panels provide good abstraction on top of the drm_bridge.
> For example, bridges don't have orientation, panels do.

That's easy to add.

> Also panels have followers, while bridges do not.

Ditto

> I don't think that either of those APIs make sense for bridge.

Why not? In a world where we have bridge hotplug for example, it would
make total sense to me to have bridge followers. I think Luca even had
that at some point in his series (and still might?).

> Last, but not least, we have drivers that were not converted to the
> bridged approach (*).

I'm not disputing that, but it's a matter of months at this point, Luca
already did a significant part of it.

> As such I think we should evolve the drm_panel, extending it to
> support atomic state.

I still think that drm_panel is on the way out with bridges taking over
for years now, and we should accept it. Otherwise we'll just end up with
two concepts with the same purpose which isn't great.

Maxime

--krwoug773liv5dfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCas3tvgAKCRAnX84Zoj2+
dqdUAYDG1uETAxbovMuzj2lX6QLl8c6ZN+NPH2rJwTfXhWLIgRv253UOgKpAcO4g
kuNDHrEBgIoCWY+u4UcbXTezQO7PslGrfeFXHodgFWdP4xUUu88iHQd0XVVIOoMs
vvVCAFGAwg==
=FeOJ
-----END PGP SIGNATURE-----

--krwoug773liv5dfc--
