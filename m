Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FB5C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE2A10F318;
	Fri, 24 Jul 2026 07:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NRXnnZuJ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9077210F318;
 Fri, 24 Jul 2026 07:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784879405;
 bh=FMXC0Rjkg6zROlYVISHYxyzDi82nrEMYLAKCb3pIasQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=NRXnnZuJM2gxQpmCXEIsg0/UKN6Om+38fQIBsqA5BRH7A+kbKfXx/eBIUFO9aVH1d
 7+qfdfi2iVKkP3rgRFxE5QjrY1NwWny/nJRPu82lSId5MHJId3IVYRoc6+5lLEhsM7
 q6xp41ABCdxJME56axtZN6tKHQEv19EA/GOH5oYJhgK4F9U3YqdVGRWUuPXyHZOO2C
 0iYFqYPHFTF8qQynbk2IS3hPpEHOYNi7Ecm1Zl4qdTZCBrlzBNWVzafAMgj8UNicLa
 3GjgehU3UU/Qwz42jbgWsDL9uqN1S2PcyQmDNDG43UBVB33Jo0Iw0d4EsKJp9LB41y
 ZZCgljI2nS89Q==
Received: from fluorite (unknown [100.64.0.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C2DBD17E00E9;
 Fri, 24 Jul 2026 09:50:04 +0200 (CEST)
Date: Fri, 24 Jul 2026 10:49:51 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 Daniel Stone <daniel@fooishbar.org>, Michel =?UTF-8?B?RMOkbnplcg==?=
 <michel.daenzer@mailbox.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] drm/atomic: introduce PAGE_FLIP_EVENT property
Message-ID: <20260724104951.73a012ac@fluorite>
In-Reply-To: <jfGv54IA2I9_Yz-NT7g1GnFb9ds45-b8I0j9wnP3z6tvZn-0GxizsDWBmfu_eiAKlx7cmnIrb2YPS7svOUULV1_QELnJTFeYW4LEE3PrH8A=@emersion.fr>
References: <20260530171422.4615-1-contact@emersion.fr>
 <20260616141546.653a21b0@fluorite>
 <jfGv54IA2I9_Yz-NT7g1GnFb9ds45-b8I0j9wnP3z6tvZn-0GxizsDWBmfu_eiAKlx7cmnIrb2YPS7svOUULV1_QELnJTFeYW4LEE3PrH8A=@emersion.fr>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v06BFasdTbR5p9TjSUQ7BuS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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

--Sig_/v06BFasdTbR5p9TjSUQ7BuS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jul 2026 16:02:48 +0000
Simon Ser <contact@emersion.fr> wrote:

> On Tuesday, June 16th, 2026 at 13:16, Pekka Paalanen <pekka.paalanen@coll=
abora.com> wrote:
>=20
> > On Sat, 30 May 2026 17:14:44 +0000
> > Simon Ser <contact@emersion.fr> wrote:
> >  =20
> > > Currently user-space can only request page-flip events for all CRTCs =
included
> > > in an atomic commit. This is cumbersome with multi-CRTC commits: when=
 moving a
> > > plane from a different CRTC, or when disabling a plane, user-space ha=
s no way
> > > to opt-out of the page-flip events.
> > >=20
> > > Additionally, page-flip events are invalid for already-disable planes=
, so =20
> >=20
> > Hi Simon,
> >=20
> > do you mean CRTCs? I find "already disabled" to be not really clear
> > that you mean off->off transition. =20
>=20
> Oh, yeah, indeed!
>=20
> > > user-space needs to add special cases [1]. Libraries cannot add plane=
s to the
> > > commit without risking causing unexpected page-flip events for the
> > > compositor [2]. =20
> >=20
> > If a library adds a plane that is currently associated with another
> > CRTC, would it not be a logic error in userspace if it didn't expect
> > that CRTC to be involved? Mostly likely if it succeeds, the plane
> > would disappear from its old CRTC unintended.
> >=20
> > If a CRTC is unexpectedly involved, userspace risks EBUSY when it wants
> > to update that CRTC for real. =20
>=20
> The plane is involved anyways, and the library can figure that out. The
> library is fully managing the plane, and has ensured it's turned off
> before migrating it to a new CRTC. What's unexpected and unavoidable is
> the page-flip event on the old CRTC.

Hi,

do you mean it currently works like this:

0. The plane is active on CRTC A.
1. Submit update 1 with CRTC A, turn the plane off on CRTC A.
2. Update 1 completes, and delivers its pageflip event.
3. Submit update 2 with CRTC B, turn the plane on on CRTC B.
4. Update 2 completes and delivers pageflip events on *both* CRTC B and A?

You want to prevent the pageflip event from CRTC A in step 4?

Or what is the scenario you have in mind?


Thanks,
pq

> > > Figuring out what CRTCs get implicitly included in a commit is
> > > non-trivial [3]. =20
> >=20
> > Yes, but is this actually helpful rather than making the failures more
> > rare and harder to debug? =20
>=20
> I don't believe spurious page-flip events help that much in that regard
> TBH. This only helps if the page-flip flag is on and user-space didn't
> mean to include these other CRTCs. The benefits of the new API outweigh
> the small cost of sometimes finding a bug a bit quicker. If some
> user-space believes otherwise, they can still keep using the old global
> flag.
>=20
> > > diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> > > index 63ead8ba6756..5ad6681bd47c 100644
> > > --- a/drivers/gpu/drm/drm_crtc.c
> > > +++ b/drivers/gpu/drm/drm_crtc.c
> > > @@ -248,6 +248,11 @@ struct dma_fence *drm_crtc_create_fence(struct d=
rm_crtc *crtc)
> > >   *	The sharpness effect takes place post blending on the final compo=
sed output.
> > >   *	If the feature is disabled, the content remains same without any =
sharpening effect
> > >   *	and when this feature is applied, it enhances the clarity of the =
content.
> > > + * PAGE_FLIP_EVENT:
> > > + *	Atomic property for requesting a page-flip event on this CRTC.
> > > + *
> > > + *	The value of this property is an integer value which always reads=
 as
> > > + *	zero and can be written with 1 to request the event. =20
> >=20
> > It took me a while to realise; should probably explain here that if one
> > uses this, then they would not use DRM_MODE_PAGE_FLIP_EVENT at the same
> > time. =20
>=20
> Right.
>=20
> > Does this allow asking for an event for a CRTC off->off
> > transition? =20
>=20
> It does not.


--Sig_/v06BFasdTbR5p9TjSUQ7BuS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmpjGR8ACgkQI1/ltBGq
qqeRWA//e71jZpBWmolp5kqrQ+MdQgBQRnuvXfJ+/WGIAvWLsKIEmXWXya7LD+3r
rUUvkcUV35cE3Y0K0Pn/IFOLa9TEifr1KmDYX9sfiOe508md88edoo6/xDNmdSyW
zxNGOVpVqT+bUcw0pFES93qvhDtn1CIpooCKiNo8kFSIteFKIpeHmTtIcZOx/73r
EVPGBFgxqRk2na9hBxHgqhpJXpDTuZsDyVZbmCWDXgGs2v9Pq1gVlOoZDO2ZV++V
n3Sf7DcQVyk8M/VeN9NydwaQWF/ouaJLEWIfjn+yujc9DXk/7UQ4hmjUj2TvD4I5
L5cRk4whjityz9h7kQT2/bhTUdSThHCaj1IQokAu/WR73Zuy/V14oD2156saJRgo
ms0l7nEnNCVZ5GcCoNY52CVkRNqfhymx7cwNTXonz/Bv7n4zfG8ow3n5FOMbVShb
ba5yNoPnQyFFcKRzSZGbOGpdZShvHCsYEY6X5TEWumGPmnQpg0TVWZBI32/ijGBY
d3SXFhHhWyOVT+hEAldIISQUmIKo77yf2YUghEPNgKxRuNgg2NEeX/HmnFf0Ft5V
weHuL8Ltl029cQGXqJA3u0MR+yC3FjxK9s+gTaMKpFm25vVYEWTXWOfjQfF/LKAa
m0YC0WsLpMtWURZSZUXbhmlDli+6fDxczxIO6xw1PcRQyp4Izbw=
=pzLz
-----END PGP SIGNATURE-----

--Sig_/v06BFasdTbR5p9TjSUQ7BuS--
