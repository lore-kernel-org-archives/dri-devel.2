Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C42C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3A210E329;
	Tue, 21 Jul 2026 12:26:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="jIR98PAe";
	dkim=pass (2048-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="cYJiT7pz";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3993D10E329
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784636809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYiSTjiQJg3Dpk7/cgf2i739PzEJaW+kPWpHMN0AIl8=;
 b=jIR98PAeGwIcZhqd30tN0Jul337343PtGR1RJT8RMUxqcXH27qibUZ+/tsR4CVA7aVmXHO
 GnHa8bx0Vf9npERl+JFkWinS9KTea0dktgqwI6GG157LQvKVnVSeah4rd/j8SzQ35cW5O1
 KnKOoTdATA97x/op7aFj/q7T30RjnjM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-huVQbS-XNh6XpaUi_F0zwQ-1; Tue, 21 Jul 2026 08:26:47 -0400
X-MC-Unique: huVQbS-XNh6XpaUi_F0zwQ-1
X-Mimecast-MFC-AGG-ID: huVQbS-XNh6XpaUi_F0zwQ_1784636807
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49561facb1dso13927575e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784636806; x=1785241606; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WYiSTjiQJg3Dpk7/cgf2i739PzEJaW+kPWpHMN0AIl8=;
 b=cYJiT7pzFVJT/nd0xvlHulyyaUviHmPnvXWYCLJW4TKzbEMfwss6yvRTui7xQDz+AR
 sj2GpQL113jjknUUHMWLohxaM17t8nXzXRn7KX7s1FXqxm9HWca+9ZF4tzw4YM8TnztQ
 aA9be0YWR2IPW9CA1v9f6rGYMIFu8R2YvGN2ubbRosgfLp49e3qcXBdvEFJrXsUnTgpU
 oWUiRsQMmMjJWaLhK+cQq+YdKN2NRSasZAR61axYUWJ9F4dKUOe5aqq9ARXLxkCNn1WC
 ZXKMwOZXLeACtk7Gwer/hXAAIH/FsMSnjPZ4+x8IorSi2NuNjE3iZRu5rAeKrNDQEboD
 v1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784636806; x=1785241606;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WYiSTjiQJg3Dpk7/cgf2i739PzEJaW+kPWpHMN0AIl8=;
 b=G139LExe9EhE5FMi/cLUx8lbZuWOhypCwnHGUjUKQnjnsu1t2XTLggMCMkirqNHt6n
 K6mLlslo56eq0hJWPbUiDDFMaV4f53EVU5T86PncU04zVPv7LWwpNxflyOy9X5Bk8Ctt
 kWLzul1aB6SiuBfO7SE+qXZC2wLgSde58LNmEb4cZz/zXzA8WTEBg4Z9aPNwSktUFFog
 iU/pdoD2mfGnJn+Zpc/pWTJDbHr+6OnWv2Q0iyiOr/EgHOaJ0JVIA8qZbmXytaknDVLo
 yFGmMrL45gk1OQgr0l8C6s5gAIr/cqkVkUtdg3i9hMUkT9QSPDjt5AIxaiSKeJCyOrxY
 bCzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdX7vG86x5JnHP/3xACe7hEXY5WJ2rqVy2MGlFFijz8Av4BzbMyV9eBPjQ2A3Wo5/Q0lNVq6HBqgE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4yO7tIK8+0ann6SYW4BN5lqsBWu7SPKAVrTCkkBQDosmTB3LZ
 eiPw1eMe5XG+3uWWqOyvsEB8LCE5SMVxafIEGdLmrEPnPqcnxlkyhKwJ7xzFWRIGkJc3YnbhTdi
 3CIbqrbgI/J0FB3B+ijzkGQQ0d8hyXOeqvCUn+0w5mJeI1wixDsSONtXm+BvpLwzSG/+PQQ==
X-Gm-Gg: AfdE7cnPOJs98ykn6eZo+tgIPOJSRh5KuJT3jg/pUQZylrKGb/0OuSREDcFYVE+M8Vz
 Igk6Th+qDOPbWQLAvWgug0b4QvpKuZdE8/Ng7qNxrFqBtITQHcQccRCBgIl80kFItYOBECX4vKn
 XNPWmLLwV1bXmgtGI2F56gIrYwwgeuOlqrWjwQrIGWxoynKXq7ydS9nYSIyK2bcfJ6QFRsSzoq2
 Qzl3TzgXjfnO5nWKpHf7mypUs6vqC9ztq+NAjW61GELbcv82xyfN6sWvgem0ecWcbyqq6I61a9H
 dKW/ff6DfKXYQnzGkmIgG3S9VjuYuwmqDduJNO2M61Ervq+hrUoF5l755FJD0j7JNi7qLZ0=
X-Received: by 2002:a05:600c:3512:b0:493:cfe8:5b36 with SMTP id
 5b1f17b1804b1-4954a3eec4bmr208323895e9.8.1784636806487; 
 Tue, 21 Jul 2026 05:26:46 -0700 (PDT)
X-Received: by 2002:a05:600c:3512:b0:493:cfe8:5b36 with SMTP id
 5b1f17b1804b1-4954a3eec4bmr208323085e9.8.1784636805839; 
 Tue, 21 Jul 2026 05:26:45 -0700 (PDT)
Received: from localhost ([45.134.79.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955a9e5f26sm156358265e9.0.2026.07.21.05.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 05:26:45 -0700 (PDT)
Date: Tue, 21 Jul 2026 14:26:43 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ze Huang <ze.huang@oss.qualcomm.com>, sashiko-reviews@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2] drm/imx: replace struct drm_simple_display_pipe with
 regular atomic helpers
Message-ID: <20260721-curious-pelican-of-performance-89bd76@houat>
References: <20260716-drm-simple-kms-removal-v2-1-7e4a6b8528e6@oss.qualcomm.com>
 <20260716091459.1D8101F000E9@smtp.kernel.org>
 <DK1XPK73QJHC.JWFUMTTLOD1D@oss.qualcomm.com>
 <63cca05a-ec83-430c-abcf-c2f0b508446f@suse.de>
 <20260720-bold-jasmine-goldfish-d979e5@penduick>
 <3749a60a-a8bb-45a0-a06e-a21017990c10@suse.de>
 <20260720-sly-tricky-elephant-c8afa1@penduick>
 <20260721-vagabond-lovely-loon-d126e7@penduick>
 <b2896811-a784-41d9-a717-59e86d04b629@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="qaxdp2o4alh4kctf"
Content-Disposition: inline
In-Reply-To: <b2896811-a784-41d9-a717-59e86d04b629@suse.de>
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


--qaxdp2o4alh4kctf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] drm/imx: replace struct drm_simple_display_pipe with
 regular atomic helpers
MIME-Version: 1.0

On Tue, Jul 21, 2026 at 11:37:32AM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 21.07.26 um 11:28 schrieb Maxime Ripard:
> > On Mon, Jul 20, 2026 at 05:06:41PM +0200, Maxime Ripard wrote:
> > > On Mon, Jul 20, 2026 at 04:38:26PM +0200, Thomas Zimmermann wrote:
> > > > Am 20.07.26 um 16:08 schrieb Maxime Ripard:
> > > > > On Mon, Jul 20, 2026 at 02:36:19PM +0200, Thomas Zimmermann wrote:
> > > > > > Hi
> > > > > >=20
> > > > > > Am 18.07.26 um 21:12 schrieb Ze Huang:
> > > > > > [...]
> > > > > > > > > -	if (event) {
> > > > > > > > > -		crtc->state->event =3D NULL;
> > > > > > > > > +static int imx_lcdc_plane_helper_atomic_check(struct drm=
_plane *plane,
> > > > > > > > > +					      struct drm_atomic_commit *commit)
> > > > > > > > > +{
> > > > > > > > > +	struct drm_plane_state *plane_state =3D drm_atomic_get_=
new_plane_state(commit, plane);
> > > > > > > > > +	struct drm_crtc *crtc =3D plane_state->crtc;
> > > > > > > > > +	struct drm_crtc_state *crtc_state =3D NULL;
> > > > > > > > > -		spin_lock_irq(&crtc->dev->event_lock);
> > > > > > > > > +	if (crtc)
> > > > > > > > > +		crtc_state =3D drm_atomic_get_new_crtc_state(commit, c=
rtc);
> > > > > > > > > -		if (crtc->state->active && drm_crtc_vblank_get(crtc) =
=3D=3D 0)
> > > > > > > > > -			drm_crtc_arm_vblank_event(crtc, event);
> > > > > > > > > -		else
> > > > > > > > > -			drm_crtc_send_vblank_event(crtc, event);
> > > > > > > > > +	return drm_atomic_helper_check_plane_state(plane_state,=
 crtc_state,
> > > > > > > > [Severity: High]
> > > > > > > > Can fetching the CRTC state this way cause a kernel panic i=
n the core atomic
> > > > > > > > helpers?
> > > > > > > >=20
> > > > > > > > If userspace submits a commit that modifies only plane prop=
erties without
> > > > > > > > affecting the CRTC, the CRTC is not implicitly added to the=
 atomic commit
> > > > > > > > state.
> > > > > > > >=20
> > > > > > > > In this scenario, drm_atomic_get_new_crtc_state() returns N=
ULL. Passing this
> > > > > > > > NULL pointer directly to drm_atomic_helper_check_plane_stat=
e() causes a crash
> > > > > > > > when it dereferences crtc_state->enable.
> > > > > > > >=20
> > > > > > > > Could this use drm_atomic_get_crtc_state() instead to ensur=
e the state is
> > > > > > > > brought into the commit if it is missing?
> > > > > > > I think it is fine here; I'll just copy the pattern from [1].
> > > > > > >=20
> > > > > > > [1] https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gp=
u/drm/mgag200/mgag200_mode.c#L487
> > > > > > It could be that there's a long standing problem in the overall=
 logic. Not
> > > > > > having a CRTC (and hence crtc_state) should also mean !fb, so w=
e'd return at
> > > > > > [1]. If we have a CRTC on the plane but pass a crtc_state of NU=
LL, we could
> > > > > > get a panic at [2], where it does crtc_state->crtc.=A0 I'm not =
aware of any
> > > > > > bug reports about this problem, but it's still an issue.
> > > > > >=20
> > > > > > A number of drivers get this wrong by using
> > > > > > drm_atomic_helper_get_new_crtc_state(). The bot suggests to use
> > > > > > drm_atomic_helper_get_crtc_state() instead.=A0 This helper also=
 returns the
> > > > > > new state. But=A0 if there's no new state, it duplicates the CR=
TC's existing
> > > > > > state. That's a bit of an overhead, but probably not an issue.=
=A0 Several
> > > > > > drivers use this helper, but also get it wrong. They tend to re=
turn early in
> > > > > > the case of !crtc or !fb without calling _check_plane_state(). =
See [3] and
> > > > > > [4] for examples.
> > > > > >=20
> > > > > > I think, going with the bot's suggestion to use
> > > > > > drm_atomic_helper_get_crtc_state() might be the best resolution=
 for now. It
> > > > > > still needs a crtc pointer, so the pattern is
> > > > > >=20
> > > > > > crtc_state =3D NULL
> > > > > > if (plane_state->crtc)
> > > > > >   =A0 =A0 crtc_state =3D drm_atomic_helper_get_crtc_state(plane=
_state->crtc)
> > > > > >=20
> > > > > > _check_plane_state(plane_state, crtc_state);
> > > > > >=20
> > > > > > And in this case, _check_plane_state() should work correctly. B=
ut you can
> > > > > > only use _get_crtc_state() in the atomic_check helpers! In the
> > > > > > atomic_update, atomic_enable, etc helpers, it's too late for th=
e helper to
> > > > > > copy the CRTC state.
> > > > > >=20
> > > > > > I think some other DRM dev should look over this as well. It's =
one of the
> > > > > > trickier things in DRM to get right.
> > > > > drm_atomic_helper_get_crtc_state is safe in atomic_check. It's
> > > > > everything after that must use either get_new_crtc_state or
> > > > > get_old_crtc_state, as the global state cannot be modified anymor=
e.
> > > > Thanks a lot for confirming.
> > > >=20
> > > > Wrt. the logic in plane atomic_check, we might have to fix a number=
 of
> > > > drivers. As I outlined above, some use _get_new_crtc_state(), some =
use
> > > > _get_crtc_state() incorrectly. But that's for another series.
> > > Sigh... I removed all of them a couple of years ago, I guess some cre=
pt
> > > back in. Maybe we should warn loudly if it happens?
> > I started to look into it for drm_atomic_helper_get_crtc_state and I
> > cannot find an occurence of this in drm-misc-next. Do you have a
> > specific example in mind?
>=20
> It's called drm_atomic_get_crtc_state(). [1] :)

Yeah, sorry :)

> I've not evaluated all calls, but there are cases like [2], which
> returns early from !fb before running the whole
> drm_atomic_helper_check_plane_state() machinery. It should have at
> least set plane_state->visible to false.=A0 Better would be to call
> drm_atomic_helper_check_plane_state() in any case.

Oh right, I misunderstood what you were saying then. I thought you were
saying that there's drm_atomic_get_crtc_state() calls in !atomic_check,
which doesn't seem to be the case.

Maxime

--qaxdp2o4alh4kctf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCal9lfAAKCRAnX84Zoj2+
dskTAX463ABUm4ItZ2NMWH8AWvpT2+kPnn5f2giRv1bvymTXF6T6nwLsM2bi2ASx
Ojh8lPYBgMqfkU2yTtq1Yp+sy/i3y6r39pzsu7sRWHn6jkUSWtTDNQHYmUf9zZ80
LixJ8a/h3g==
=KMEv
-----END PGP SIGNATURE-----

--qaxdp2o4alh4kctf--

