Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A26C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B6A10E1D7;
	Mon, 20 Jul 2026 15:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UgVA8sC3";
	dkim=pass (2048-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ex698Wny";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D8610E1D7
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784560005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=raPd+j2sNnja6yObFkLuI3fBBY7t0sFpL6aJ3ppEwEQ=;
 b=UgVA8sC3bAHuUWH3XtUA5TxyXGFuoVXWQANJR7FBF+8/K7Qm82z9Wo9USpeYubfVt2eugY
 5pilK6JQOvMv7HT4B8UOlX4jQIWWqy4YjSl/GareuFO37VC2XgOS+8YTRJ3+WQkOzeDuOf
 i5PWeTEvDfdH3hgJ2vpBgohI4/2vVKA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-eNpWzbxUOa-4m9nPYonT0g-1; Mon, 20 Jul 2026 11:06:43 -0400
X-MC-Unique: eNpWzbxUOa-4m9nPYonT0g-1
X-Mimecast-MFC-AGG-ID: eNpWzbxUOa-4m9nPYonT0g_1784560002
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495517d39fbso11006255e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784560002; x=1785164802; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=raPd+j2sNnja6yObFkLuI3fBBY7t0sFpL6aJ3ppEwEQ=;
 b=ex698WnywGN7cMLUhVNN/coACxqi6ygVcCBFY8zYXXtgTh4bUWuW7wt5Tu93qDP82q
 uPKVBnLl8qbHqmlm1NPJGVYD2RlgqzzTHggTKjoJZyvwtW/o5nWc0OZEQ53r+b8K84cn
 qMgOzxZoWGpAW1LjmCfIEu81Ke6Vkct89XFTsQQ84h7HSaX7aI2YZSj8b/rvGI8a278k
 nUBsHi3cHk4dvkG46VQedVI94QSstZS9fEuOiY3+52g0HjQVnKA274HjpOCmiTKNL2Lg
 yNs7qfi7HtqhW26SNCo1oG6KHhzFhW3jmcDd95SVdfkDewDIVzt0fWSjC1IzgAeggeOt
 f5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784560002; x=1785164802;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=raPd+j2sNnja6yObFkLuI3fBBY7t0sFpL6aJ3ppEwEQ=;
 b=U2EboQZjRqbUs14F2Mco4OjZFVgtQQz1AXAny1+9K5W7kc60gFxZdO9qqyLqL/JMmr
 DCQhx5W0OhpZYYGiWaJM1+/pZsbLD0xwwek2NHwCn1ZfJA5Jzm9GOkF9gNsB3YWkyEsp
 TBNn9PBd7ZwQxdRECh5542IytEpRO7GmuYrKYHCP9t/ZLziSSMfMBD4Rgp8K81bTRhPw
 JM8/ZhPMnFHV/gQqXlkjyrs+1V0Uu5d4tPQzS6wS4fVoTgAbLDe/vPkc8wcedlgM3zaJ
 T45z5dCExK4AmtKOWyzyS0y6a8jaS0F2HQVem1t1eZr1HAJL/clKeoG7fwkhmpIWW0eq
 jOjA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqz0MOhbpoN4bSvS3j4iKYOWtMiT4RwHPn8KKMOStWjDCADA0cit/xpVnWryKkMC8iyhfQP7yG+4CA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyievZelIKWD0OqXAo2Yad+G+9sQ+xjXwJvG+nYeD5oI5sDnsEP
 PlV2D+fijF2Uj3D7C2ZTTTP3KKis7GkdO6zialivSh3gdaA0wV78AoC277OO6oWv1fZKK7kdApt
 SQbdwcKGaJU7FQmORScWbqmLJ17UG1pNiyUE66+ePhC8IblMofy8i+Yuvsr2rN66SkV0I8A==
X-Gm-Gg: AfdE7cnIsMPfYSFVZuOsZqxNCn1cLTda3QrHxQ/rltutDblzv4ZrZTe7ATUYo+AdsM2
 A3DQuvQAuo2el77WbU9DGPPQGLnoF6/PGmPemoscZQy/BYLuCXEq78O4wNr6JK6/2xZX8fYhQn1
 mSgYEQOoN0181Yv0noBxFKDqrMwLqhJK8vTGTdH7vsGEH92LbFAPRSQTN/zUaf2+qqze80Ffpu2
 6XMTwYXwAsK6DaNgvJuevqgyREnAS0ussyJ77/km1w0Cs03uxpGyLzY8rvtisj0Psg6nFyFv8JM
 a7SCijo9UEBNXthK1CXoAX7Ne5tMPdpR2HEIfjOyxY3VlPXDAUTxqBoy6T4kDj1R1tsLA+8t2A=
 =
X-Received: by 2002:a05:600c:4685:b0:495:4a77:1327 with SMTP id
 5b1f17b1804b1-4954a771521mr171385305e9.33.1784560002014; 
 Mon, 20 Jul 2026 08:06:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:495:4a77:1327 with SMTP id
 5b1f17b1804b1-4954a771521mr171384685e9.33.1784560001343; 
 Mon, 20 Jul 2026 08:06:41 -0700 (PDT)
Received: from localhost ([2a01:e0a:a99:9822:edbd:5894:eb1d:c2c7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49562709500sm57729825e9.14.2026.07.20.08.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 08:06:39 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:06:38 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ze Huang <ze.huang@oss.qualcomm.com>, sashiko-reviews@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2] drm/imx: replace struct drm_simple_display_pipe with
 regular atomic helpers
Message-ID: <20260720-sly-tricky-elephant-c8afa1@penduick>
References: <20260716-drm-simple-kms-removal-v2-1-7e4a6b8528e6@oss.qualcomm.com>
 <20260716091459.1D8101F000E9@smtp.kernel.org>
 <DK1XPK73QJHC.JWFUMTTLOD1D@oss.qualcomm.com>
 <63cca05a-ec83-430c-abcf-c2f0b508446f@suse.de>
 <20260720-bold-jasmine-goldfish-d979e5@penduick>
 <3749a60a-a8bb-45a0-a06e-a21017990c10@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="7vkstdocennjbk5t"
Content-Disposition: inline
In-Reply-To: <3749a60a-a8bb-45a0-a06e-a21017990c10@suse.de>
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


--7vkstdocennjbk5t
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] drm/imx: replace struct drm_simple_display_pipe with
 regular atomic helpers
MIME-Version: 1.0

On Mon, Jul 20, 2026 at 04:38:26PM +0200, Thomas Zimmermann wrote:
> Am 20.07.26 um 16:08 schrieb Maxime Ripard:
> > On Mon, Jul 20, 2026 at 02:36:19PM +0200, Thomas Zimmermann wrote:
> > > Hi
> > >=20
> > > Am 18.07.26 um 21:12 schrieb Ze Huang:
> > > [...]
> > > > > > -	if (event) {
> > > > > > -		crtc->state->event =3D NULL;
> > > > > > +static int imx_lcdc_plane_helper_atomic_check(struct drm_plane=
 *plane,
> > > > > > +					      struct drm_atomic_commit *commit)
> > > > > > +{
> > > > > > +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_pl=
ane_state(commit, plane);
> > > > > > +	struct drm_crtc *crtc =3D plane_state->crtc;
> > > > > > +	struct drm_crtc_state *crtc_state =3D NULL;
> > > > > > -		spin_lock_irq(&crtc->dev->event_lock);
> > > > > > +	if (crtc)
> > > > > > +		crtc_state =3D drm_atomic_get_new_crtc_state(commit, crtc);
> > > > > > -		if (crtc->state->active && drm_crtc_vblank_get(crtc) =3D=3D =
0)
> > > > > > -			drm_crtc_arm_vblank_event(crtc, event);
> > > > > > -		else
> > > > > > -			drm_crtc_send_vblank_event(crtc, event);
> > > > > > +	return drm_atomic_helper_check_plane_state(plane_state, crtc_=
state,
> > > > > [Severity: High]
> > > > > Can fetching the CRTC state this way cause a kernel panic in the =
core atomic
> > > > > helpers?
> > > > >=20
> > > > > If userspace submits a commit that modifies only plane properties=
 without
> > > > > affecting the CRTC, the CRTC is not implicitly added to the atomi=
c commit
> > > > > state.
> > > > >=20
> > > > > In this scenario, drm_atomic_get_new_crtc_state() returns NULL. P=
assing this
> > > > > NULL pointer directly to drm_atomic_helper_check_plane_state() ca=
uses a crash
> > > > > when it dereferences crtc_state->enable.
> > > > >=20
> > > > > Could this use drm_atomic_get_crtc_state() instead to ensure the =
state is
> > > > > brought into the commit if it is missing?
> > > > I think it is fine here; I'll just copy the pattern from [1].
> > > >=20
> > > > [1] https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/=
mgag200/mgag200_mode.c#L487
> > > It could be that there's a long standing problem in the overall logic=
=2E Not
> > > having a CRTC (and hence crtc_state) should also mean !fb, so we'd re=
turn at
> > > [1]. If we have a CRTC on the plane but pass a crtc_state of NULL, we=
 could
> > > get a panic at [2], where it does crtc_state->crtc.=A0 I'm not aware =
of any
> > > bug reports about this problem, but it's still an issue.
> > >=20
> > > A number of drivers get this wrong by using
> > > drm_atomic_helper_get_new_crtc_state(). The bot suggests to use
> > > drm_atomic_helper_get_crtc_state() instead.=A0 This helper also retur=
ns the
> > > new state. But=A0 if there's no new state, it duplicates the CRTC's e=
xisting
> > > state. That's a bit of an overhead, but probably not an issue.=A0 Sev=
eral
> > > drivers use this helper, but also get it wrong. They tend to return e=
arly in
> > > the case of !crtc or !fb without calling _check_plane_state(). See [3=
] and
> > > [4] for examples.
> > >=20
> > > I think, going with the bot's suggestion to use
> > > drm_atomic_helper_get_crtc_state() might be the best resolution for n=
ow. It
> > > still needs a crtc pointer, so the pattern is
> > >=20
> > > crtc_state =3D NULL
> > > if (plane_state->crtc)
> > >  =A0 =A0 crtc_state =3D drm_atomic_helper_get_crtc_state(plane_state-=
>crtc)
> > >=20
> > > _check_plane_state(plane_state, crtc_state);
> > >=20
> > > And in this case, _check_plane_state() should work correctly. But you=
 can
> > > only use _get_crtc_state() in the atomic_check helpers! In the
> > > atomic_update, atomic_enable, etc helpers, it's too late for the help=
er to
> > > copy the CRTC state.
> > >=20
> > > I think some other DRM dev should look over this as well. It's one of=
 the
> > > trickier things in DRM to get right.
> > drm_atomic_helper_get_crtc_state is safe in atomic_check. It's
> > everything after that must use either get_new_crtc_state or
> > get_old_crtc_state, as the global state cannot be modified anymore.
>=20
> Thanks a lot for confirming.
>=20
> Wrt. the logic in plane atomic_check, we might have to fix a number of
> drivers. As I outlined above, some use _get_new_crtc_state(), some use
> _get_crtc_state() incorrectly. But that's for another series.

Sigh... I removed all of them a couple of years ago, I guess some crept
back in. Maybe we should warn loudly if it happens?

Maxime

--7vkstdocennjbk5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCal45eQAKCRAnX84Zoj2+
dg/AAYDTsrf3Fkgk1ZRklRK6roAOsuZiFoREp5NdX6u03Jpi4+thGFxdq0lEKyS0
6K/TZMcBgL6ZYUXFbXvt4bZJ6BknrGbVMlzCNEfV2lYGsQdJWBLqDAfrlypdfYay
4ZjNz+WlxA==
=nM5m
-----END PGP SIGNATURE-----

--7vkstdocennjbk5t--

