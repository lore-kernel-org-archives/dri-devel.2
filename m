Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851FAC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 09:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCAD910E310;
	Tue, 21 Jul 2026 09:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="XQCtOjen";
	dkim=pass (2048-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="U6xtXsbI";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67BDA10E310
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 09:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784626145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L3nIrtb3ZIx5YQo/Azj3k+CrJf5VH+rRdrIKrJmE4Ec=;
 b=XQCtOjenE3Viu7SxzWINwN8Yn4r5Iw4XmC3yJFkXzJC/Dcx60EJbWb9xsz7MxqgNeXdwED
 pSQ3aEmJiB08a32UAZ8qW7zeVrDbtUPhy4pz8mdzOfa2pCGInTghpcRF0u+ncjzHug9ni8
 kEUB8Qoc0f9GhdDG3jkb0eWctGtfB/4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-AHpRbBu_M36Nmut4wO3axQ-1; Tue, 21 Jul 2026 05:29:01 -0400
X-MC-Unique: AHpRbBu_M36Nmut4wO3axQ-1
X-Mimecast-MFC-AGG-ID: AHpRbBu_M36Nmut4wO3axQ_1784626141
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4629f312a67so10379388f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784626140; x=1785230940; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L3nIrtb3ZIx5YQo/Azj3k+CrJf5VH+rRdrIKrJmE4Ec=;
 b=U6xtXsbI1TVS/8MV44pn1AlsmSlUrb4M/bhBmrf9CHC/QKvuz+YNeLAKN1EhF2MEkm
 nOWSUMUeZZRKQvnjcvICiGpvSmjcemPtPoXwZxvD45KoMxhR0h3PCbKRaAW0RnscjfK2
 P/FcPDd87DAXKqn5RYJallYBhwPA8wc8E+IB2Bdxhmk1NXSyrxRPlCho4W7LKS3902q4
 K5P7BQMjl+MhCg3ILC/hphs6SB7q0IOYEfvuNiHWNzIYWyl3jpOkHT7xFm1uGCMuSUFM
 Hzo+lffQ9dZGmstxPZP0rehYFqXvf8wKtMnFcG/SkLKzczFLg5d3dr6IhDkIfRz5KmON
 Ws0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784626140; x=1785230940;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L3nIrtb3ZIx5YQo/Azj3k+CrJf5VH+rRdrIKrJmE4Ec=;
 b=rYVeWa0QSiOywoB9cTRa4DYtqVxJry8KQuWhc+i9MztqYbxulp1iFnhFP1yJgv+YSH
 DgGtd3KxJVlBBAlGa1mn2z/+oVQ5iSnT/XMBlNn0rNA8+o7RF/zBTcnouoVugQLzx4zs
 wnjt7Ma2KxyxNaeTjUOWDezWS7BznfKlqLFri4tCkbKRek3c0tpaAT53eTilPtoanoS0
 a7DHKP8OEH0hj9ZinsJLOKbK8LKn/Xgs1vyeYAu/8qU7hUu+Ni+ug0DtHMIGeSOx2gTZ
 nWcfU/xKvGdI6hYptNK8EUlJjpxvavcxC4oEnu2ahitG2HrwmQQSIcqzznRBRWEp5TiB
 DB3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqT5awWO3uxnPm5S/38yiJoSzmUGToFO2O+2ia3c3oO1Dl7LJaRCTlDX/j/xPNJz/kqJJuC8A2VsBE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIQn9tkrGVR6ns7GpRRZD7qipoONOJ1SSC892lcbaLvbwQQzFA
 uBiGVQXrwCKCfyFeNyacxD6/ePtkt/cEzRzbyMCw8m6qcLv0M1SFjNjVaeC/1cwVJ0EMMCJ9ojR
 lOBH0fh1ZZwhUPZu8PAvfrnkTH7z/TR2/JVKwwgFS4AtY09DFum+mRYfKn9EiDanJ5itSHQ==
X-Gm-Gg: AR+sD110UOVOzBV89bytHUndBBlpL8SgOMdGU3U4YyWnh3Itmh3UkuXMHeemi9NAA9m
 xWHxlh/ysBha77APClnKiHXCJKIxQJ58TFlrPqnQAifTsRxT9v++TlKd3wPpliF4aLACpJyO4Gx
 QOX8nwsqOiN5zYzRpw/tAF2o64ruB/hw7h05Vf+kCEXKcqbSv6rGIDBgaEU6pA58CymgPdwVwBF
 zd0iQxYGDyC475UvGdAs9oxGKMKpRCiqR9X0hIURCc8At5YtlUsoIIEi4lXhyztamwQ/NlLqbVi
 U0uordapIVf0P5JugZRO+n+YK7wPBQ9FCgfk+BZDVZRswo4RWoofoRhgYKCqQ4Y0sm34UbI/xw=
 =
X-Received: by 2002:a5d:5d0e:0:b0:47d:eedb:ee62 with SMTP id
 ffacd0b85a97d-47f6230389fmr22149601f8f.14.1784626140385; 
 Tue, 21 Jul 2026 02:29:00 -0700 (PDT)
X-Received: by 2002:a5d:5d0e:0:b0:47d:eedb:ee62 with SMTP id
 ffacd0b85a97d-47f6230389fmr22149546f8f.14.1784626139778; 
 Tue, 21 Jul 2026 02:28:59 -0700 (PDT)
Received: from localhost ([2a01:e0a:a99:9822:edbd:5894:eb1d:c2c7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e496afsm39272808f8f.1.2026.07.21.02.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 02:28:58 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:28:57 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ze Huang <ze.huang@oss.qualcomm.com>, sashiko-reviews@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2] drm/imx: replace struct drm_simple_display_pipe with
 regular atomic helpers
Message-ID: <20260721-vagabond-lovely-loon-d126e7@penduick>
References: <20260716-drm-simple-kms-removal-v2-1-7e4a6b8528e6@oss.qualcomm.com>
 <20260716091459.1D8101F000E9@smtp.kernel.org>
 <DK1XPK73QJHC.JWFUMTTLOD1D@oss.qualcomm.com>
 <63cca05a-ec83-430c-abcf-c2f0b508446f@suse.de>
 <20260720-bold-jasmine-goldfish-d979e5@penduick>
 <3749a60a-a8bb-45a0-a06e-a21017990c10@suse.de>
 <20260720-sly-tricky-elephant-c8afa1@penduick>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="svtaodo43k2a7zkz"
Content-Disposition: inline
In-Reply-To: <20260720-sly-tricky-elephant-c8afa1@penduick>
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


--svtaodo43k2a7zkz
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] drm/imx: replace struct drm_simple_display_pipe with
 regular atomic helpers
MIME-Version: 1.0

On Mon, Jul 20, 2026 at 05:06:41PM +0200, Maxime Ripard wrote:
> On Mon, Jul 20, 2026 at 04:38:26PM +0200, Thomas Zimmermann wrote:
> > Am 20.07.26 um 16:08 schrieb Maxime Ripard:
> > > On Mon, Jul 20, 2026 at 02:36:19PM +0200, Thomas Zimmermann wrote:
> > > > Hi
> > > >=20
> > > > Am 18.07.26 um 21:12 schrieb Ze Huang:
> > > > [...]
> > > > > > > -	if (event) {
> > > > > > > -		crtc->state->event =3D NULL;
> > > > > > > +static int imx_lcdc_plane_helper_atomic_check(struct drm_pla=
ne *plane,
> > > > > > > +					      struct drm_atomic_commit *commit)
> > > > > > > +{
> > > > > > > +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_=
plane_state(commit, plane);
> > > > > > > +	struct drm_crtc *crtc =3D plane_state->crtc;
> > > > > > > +	struct drm_crtc_state *crtc_state =3D NULL;
> > > > > > > -		spin_lock_irq(&crtc->dev->event_lock);
> > > > > > > +	if (crtc)
> > > > > > > +		crtc_state =3D drm_atomic_get_new_crtc_state(commit, crtc);
> > > > > > > -		if (crtc->state->active && drm_crtc_vblank_get(crtc) =3D=
=3D 0)
> > > > > > > -			drm_crtc_arm_vblank_event(crtc, event);
> > > > > > > -		else
> > > > > > > -			drm_crtc_send_vblank_event(crtc, event);
> > > > > > > +	return drm_atomic_helper_check_plane_state(plane_state, crt=
c_state,
> > > > > > [Severity: High]
> > > > > > Can fetching the CRTC state this way cause a kernel panic in th=
e core atomic
> > > > > > helpers?
> > > > > >=20
> > > > > > If userspace submits a commit that modifies only plane properti=
es without
> > > > > > affecting the CRTC, the CRTC is not implicitly added to the ato=
mic commit
> > > > > > state.
> > > > > >=20
> > > > > > In this scenario, drm_atomic_get_new_crtc_state() returns NULL.=
 Passing this
> > > > > > NULL pointer directly to drm_atomic_helper_check_plane_state() =
causes a crash
> > > > > > when it dereferences crtc_state->enable.
> > > > > >=20
> > > > > > Could this use drm_atomic_get_crtc_state() instead to ensure th=
e state is
> > > > > > brought into the commit if it is missing?
> > > > > I think it is fine here; I'll just copy the pattern from [1].
> > > > >=20
> > > > > [1] https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/dr=
m/mgag200/mgag200_mode.c#L487
> > > > It could be that there's a long standing problem in the overall log=
ic. Not
> > > > having a CRTC (and hence crtc_state) should also mean !fb, so we'd =
return at
> > > > [1]. If we have a CRTC on the plane but pass a crtc_state of NULL, =
we could
> > > > get a panic at [2], where it does crtc_state->crtc.=A0 I'm not awar=
e of any
> > > > bug reports about this problem, but it's still an issue.
> > > >=20
> > > > A number of drivers get this wrong by using
> > > > drm_atomic_helper_get_new_crtc_state(). The bot suggests to use
> > > > drm_atomic_helper_get_crtc_state() instead.=A0 This helper also ret=
urns the
> > > > new state. But=A0 if there's no new state, it duplicates the CRTC's=
 existing
> > > > state. That's a bit of an overhead, but probably not an issue.=A0 S=
everal
> > > > drivers use this helper, but also get it wrong. They tend to return=
 early in
> > > > the case of !crtc or !fb without calling _check_plane_state(). See =
[3] and
> > > > [4] for examples.
> > > >=20
> > > > I think, going with the bot's suggestion to use
> > > > drm_atomic_helper_get_crtc_state() might be the best resolution for=
 now. It
> > > > still needs a crtc pointer, so the pattern is
> > > >=20
> > > > crtc_state =3D NULL
> > > > if (plane_state->crtc)
> > > >  =A0 =A0 crtc_state =3D drm_atomic_helper_get_crtc_state(plane_stat=
e->crtc)
> > > >=20
> > > > _check_plane_state(plane_state, crtc_state);
> > > >=20
> > > > And in this case, _check_plane_state() should work correctly. But y=
ou can
> > > > only use _get_crtc_state() in the atomic_check helpers! In the
> > > > atomic_update, atomic_enable, etc helpers, it's too late for the he=
lper to
> > > > copy the CRTC state.
> > > >=20
> > > > I think some other DRM dev should look over this as well. It's one =
of the
> > > > trickier things in DRM to get right.
> > > drm_atomic_helper_get_crtc_state is safe in atomic_check. It's
> > > everything after that must use either get_new_crtc_state or
> > > get_old_crtc_state, as the global state cannot be modified anymore.
> >=20
> > Thanks a lot for confirming.
> >=20
> > Wrt. the logic in plane atomic_check, we might have to fix a number of
> > drivers. As I outlined above, some use _get_new_crtc_state(), some use
> > _get_crtc_state() incorrectly. But that's for another series.
>=20
> Sigh... I removed all of them a couple of years ago, I guess some crept
> back in. Maybe we should warn loudly if it happens?

I started to look into it for drm_atomic_helper_get_crtc_state and I
cannot find an occurence of this in drm-misc-next. Do you have a
specific example in mind?

Maxime

--svtaodo43k2a7zkz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCal87zwAKCRAnX84Zoj2+
dpD4AX9mZR8Tsica/YCVr+szvbzpc2I1L6zbnMp7qBJPP5suVRXai0/c6lQELN2s
/orBPSYBfRNMFmYBwJUkOABk0ocUxGax7KlpNoG7ktNzSEMH72f9U3G/1A/5b/ay
jQHqVqGSZQ==
=QgDA
-----END PGP SIGNATURE-----

--svtaodo43k2a7zkz--

