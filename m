Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD52C531F8
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE7010E1E5;
	Thu, 23 Jul 2026 16:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="VlHWFXy8";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D34E10E1E5
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1784822573; x=1785081773;
 bh=YBlrn9LSU6RohwwPap8BAU2aHQ6Vopgg+AeM1TtIJZI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=VlHWFXy8pGidD90RZWG2r105bumMfuFzQWV/De7i/TLRE5NxWdZv/M6fJV+3lBFU9
 F2JwwaZZHBLq7LiLg7hdKsA0YQhNnmOg0C93GkPiKrolDI/Bjp66MXFeuNaOcv20vj
 PVJqkmsByZfZ7q4MxH0sGEvsm1/186THzTprjkywhzz2EZgsnyggkPC6P3smx24TBN
 f3y6mr1GMpHQfp25+KTCEQv54tsEIRQdtzFJ/8jy/6PD/gvPF760o3QB3XRc5xYEmI
 6ODFiha+9p0k9wocSu3r3Ic9ihZhkORBqk9LtDGyMgrh234KnO/SzdXTjU2Qe0PEIM
 XRhmbj0eTnKqA==
Date: Thu, 23 Jul 2026 16:02:48 +0000
To: Pekka Paalanen <pekka.paalanen@collabora.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 Daniel Stone <daniel@fooishbar.org>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] drm/atomic: introduce PAGE_FLIP_EVENT property
Message-ID: <jfGv54IA2I9_Yz-NT7g1GnFb9ds45-b8I0j9wnP3z6tvZn-0GxizsDWBmfu_eiAKlx7cmnIrb2YPS7svOUULV1_QELnJTFeYW4LEE3PrH8A=@emersion.fr>
In-Reply-To: <20260616141546.653a21b0@fluorite>
References: <20260530171422.4615-1-contact@emersion.fr>
 <20260616141546.653a21b0@fluorite>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 8a8f426bb2d3ee4a239341219549041aacafcf37
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Tuesday, June 16th, 2026 at 13:16, Pekka Paalanen <pekka.paalanen@collab=
ora.com> wrote:

> On Sat, 30 May 2026 17:14:44 +0000
> Simon Ser <contact@emersion.fr> wrote:
>=20
> > Currently user-space can only request page-flip events for all CRTCs in=
cluded
> > in an atomic commit. This is cumbersome with multi-CRTC commits: when m=
oving a
> > plane from a different CRTC, or when disabling a plane, user-space has =
no way
> > to opt-out of the page-flip events.
> >=20
> > Additionally, page-flip events are invalid for already-disable planes, =
so
>=20
> Hi Simon,
>=20
> do you mean CRTCs? I find "already disabled" to be not really clear
> that you mean off->off transition.

Oh, yeah, indeed!

> > user-space needs to add special cases [1]. Libraries cannot add planes =
to the
> > commit without risking causing unexpected page-flip events for the
> > compositor [2].
>=20
> If a library adds a plane that is currently associated with another
> CRTC, would it not be a logic error in userspace if it didn't expect
> that CRTC to be involved? Mostly likely if it succeeds, the plane
> would disappear from its old CRTC unintended.
>=20
> If a CRTC is unexpectedly involved, userspace risks EBUSY when it wants
> to update that CRTC for real.

The plane is involved anyways, and the library can figure that out. The
library is fully managing the plane, and has ensured it's turned off
before migrating it to a new CRTC. What's unexpected and unavoidable is
the page-flip event on the old CRTC.

> > Figuring out what CRTCs get implicitly included in a commit is
> > non-trivial [3].
>=20
> Yes, but is this actually helpful rather than making the failures more
> rare and harder to debug?

I don't believe spurious page-flip events help that much in that regard
TBH. This only helps if the page-flip flag is on and user-space didn't
mean to include these other CRTCs. The benefits of the new API outweigh
the small cost of sometimes finding a bug a bit quicker. If some
user-space believes otherwise, they can still keep using the old global
flag.

> > diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> > index 63ead8ba6756..5ad6681bd47c 100644
> > --- a/drivers/gpu/drm/drm_crtc.c
> > +++ b/drivers/gpu/drm/drm_crtc.c
> > @@ -248,6 +248,11 @@ struct dma_fence *drm_crtc_create_fence(struct drm=
_crtc *crtc)
> >   *=09The sharpness effect takes place post blending on the final compo=
sed output.
> >   *=09If the feature is disabled, the content remains same without any =
sharpening effect
> >   *=09and when this feature is applied, it enhances the clarity of the =
content.
> > + * PAGE_FLIP_EVENT:
> > + *=09Atomic property for requesting a page-flip event on this CRTC.
> > + *
> > + *=09The value of this property is an integer value which always reads=
 as
> > + *=09zero and can be written with 1 to request the event.
>=20
> It took me a while to realise; should probably explain here that if one
> uses this, then they would not use DRM_MODE_PAGE_FLIP_EVENT at the same
> time.

Right.

> Does this allow asking for an event for a CRTC off->off
> transition?

It does not.
