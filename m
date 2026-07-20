Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46541C4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8271810E1D8;
	Mon, 20 Jul 2026 14:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hH/7RxQm";
	dkim=pass (2048-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="N6fQvR/p";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 068DC10E1D8
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784556533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bYhdFOpmK669qfgd8VOdJ1wWxaKRFhsnw8y+lE3N65U=;
 b=hH/7RxQm3kH2XJ1pZvW7BWLDKNtPG9v0JG5aK5n9G63VjBCG+LoeRHRsV+YF+kQG8p0shM
 dUo4cBK6wNB3C4BaquzVSbEb/q48XkBHBlG8/mQ863ovSpYMKoTqcuUZls6sHsSCnE1YyW
 TXClDniocaka94T4TGnK68fAD+Zhwzw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-7XfmnZruMSSCCUvy5gDwfw-1; Mon, 20 Jul 2026 10:08:51 -0400
X-MC-Unique: 7XfmnZruMSSCCUvy5gDwfw-1
X-Mimecast-MFC-AGG-ID: 7XfmnZruMSSCCUvy5gDwfw_1784556530
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47485fde05aso6009381f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784556530; x=1785161330; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bYhdFOpmK669qfgd8VOdJ1wWxaKRFhsnw8y+lE3N65U=;
 b=N6fQvR/p5Dh//E2tcrEz+B+jA+ETpb00uqlRSZ8fg44qITAfSBAl+zg81O1F77BjWu
 EbMOMX8E7+VdmrbD9FSXAopSi0wQiGTnQL4eFbX1vqySNQrFN7yblsREkxW3vsyB9Plq
 bvX7FfUybB7gUK/5L9BoWeG0C0qbX7xi3ShVEmt/bSx5aGYKQfatvFyeutF8TNfeUb8e
 1ViRtNP6OeT5fabjIbX2mdfwd5yjJrYfpZ40SuHqyrwAzM+RdBgaMLks6+Z5O3JlAvr8
 yTe/SfF/Vdg/MPM53LKQhgbFB+yDeB7YrNFj6alD//pxKrY+K125PzZ7rdQa4z7muR6s
 +S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784556530; x=1785161330;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bYhdFOpmK669qfgd8VOdJ1wWxaKRFhsnw8y+lE3N65U=;
 b=RHMCK082BMxydhKcQCI3Qr99rwKco/TT1W+QMa7uEODL2Ffvajekx7pFeo9tBEJRsk
 C4x2wzyv99+Puly50O0DW6xXU+rmYCBgyiPqdhVF04W8JYqOUsHzemgP90I8K/Gs4ZkN
 wg64ZJ8VIG+CAqwAlcOdzhDCW31zKeX9TN8R4J4lSvI2e4948ePmt0eVvfK2Kc6FNnMP
 fNpTDUxVGI4gRxFAOcV2xNW57XQXRUF8JAz7LVDkZAWApdk6GvRz60R27Ju/w3CMXHgN
 KKSx7nstOj6CU/u6GFD6QiwAUECIm0qj/rBeV3/M2+N4TRZeAcCxUKcrD9ovfeaSmWiu
 uFcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrhfKtsF53DMWNyQzE/kbx4KE8Dnh+u+rrIjhHloJzX/KI0YlKO7w5kYdIp5eb7WhPTJlMZRcuoqkQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyI+arEDmpHuzbloJ9Vl0WZVK9VFuZlKwYQ2Q0tqPVN5pcW+7PA
 Fe9RCBdNqaVlolmL7Lfi8EnFuQdxz2t650uoO6K/cNNTZlRmMlZ77X9QWRRF/ybWwWtjRoYO4TO
 q40omLTopTYpjYiLMZl3rt9WfxWcr6bMn1y0ATcrnDm0N2DecNjO77t6n6IKAPxiypngZZjdSdf
 sYHmM3
X-Gm-Gg: AfdE7ckxCYIu/vUP8QFwEHBY4DQxHnw/m64k6aYWf4/KeggoqLOK0lTjY6zbB0TJVCm
 pfT2bnaxbI9p+6WKTBRIf1GUY/7QPIJpupHSbr5ZEJ8NnThZEQ3uKHYNiTVtUQCvb6FDhSQWR4g
 lgVZN6bNCoLj/NYN1EyDjxOCsjB1F7j3UcvUeGLuCSFfc2/6PnpLkMdv8ELB3dY7ALhmxO37YkR
 Uq5/vN3tfFLK2hvh9rCSSceTP7AB9tVQQgFDqSAse5jh9Zqb9vTOvbM/phhwxdAzRPCQBtf/Y3/
 nYWOPVwD7W1El0mj28CmMvq7lwGyOdgydxFOwlV9FmxSok3eZHf/kY/7wUq811cPNFFID1XbUg=
 =
X-Received: by 2002:a05:600d:8486:20b0:495:6022:5a20 with SMTP id
 5b1f17b1804b1-49560319fe9mr26968535e9.33.1784556529560; 
 Mon, 20 Jul 2026 07:08:49 -0700 (PDT)
X-Received: by 2002:a05:600d:8486:20b0:495:6022:5a20 with SMTP id
 5b1f17b1804b1-49560319fe9mr26967995e9.33.1784556528895; 
 Mon, 20 Jul 2026 07:08:48 -0700 (PDT)
Received: from localhost ([2a01:e0a:a99:9822:edbd:5894:eb1d:c2c7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e499c2sm28394845f8f.4.2026.07.20.07.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:08:48 -0700 (PDT)
Date: Mon, 20 Jul 2026 16:08:47 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ze Huang <ze.huang@oss.qualcomm.com>, sashiko-reviews@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2] drm/imx: replace struct drm_simple_display_pipe with
 regular atomic helpers
Message-ID: <20260720-bold-jasmine-goldfish-d979e5@penduick>
References: <20260716-drm-simple-kms-removal-v2-1-7e4a6b8528e6@oss.qualcomm.com>
 <20260716091459.1D8101F000E9@smtp.kernel.org>
 <DK1XPK73QJHC.JWFUMTTLOD1D@oss.qualcomm.com>
 <63cca05a-ec83-430c-abcf-c2f0b508446f@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="lkbwojfab5zeg2qh"
Content-Disposition: inline
In-Reply-To: <63cca05a-ec83-430c-abcf-c2f0b508446f@suse.de>
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


--lkbwojfab5zeg2qh
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] drm/imx: replace struct drm_simple_display_pipe with
 regular atomic helpers
MIME-Version: 1.0

On Mon, Jul 20, 2026 at 02:36:19PM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 18.07.26 um 21:12 schrieb Ze Huang:
> [...]
> > > > -	if (event) {
> > > > -		crtc->state->event =3D NULL;
> > > > +static int imx_lcdc_plane_helper_atomic_check(struct drm_plane *pl=
ane,
> > > > +					      struct drm_atomic_commit *commit)
> > > > +{
> > > > +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_=
state(commit, plane);
> > > > +	struct drm_crtc *crtc =3D plane_state->crtc;
> > > > +	struct drm_crtc_state *crtc_state =3D NULL;
> > > > -		spin_lock_irq(&crtc->dev->event_lock);
> > > > +	if (crtc)
> > > > +		crtc_state =3D drm_atomic_get_new_crtc_state(commit, crtc);
> > > > -		if (crtc->state->active && drm_crtc_vblank_get(crtc) =3D=3D 0)
> > > > -			drm_crtc_arm_vblank_event(crtc, event);
> > > > -		else
> > > > -			drm_crtc_send_vblank_event(crtc, event);
> > > > +	return drm_atomic_helper_check_plane_state(plane_state, crtc_stat=
e,
> > > [Severity: High]
> > > Can fetching the CRTC state this way cause a kernel panic in the core=
 atomic
> > > helpers?
> > >=20
> > > If userspace submits a commit that modifies only plane properties wit=
hout
> > > affecting the CRTC, the CRTC is not implicitly added to the atomic co=
mmit
> > > state.
> > >=20
> > > In this scenario, drm_atomic_get_new_crtc_state() returns NULL. Passi=
ng this
> > > NULL pointer directly to drm_atomic_helper_check_plane_state() causes=
 a crash
> > > when it dereferences crtc_state->enable.
> > >=20
> > > Could this use drm_atomic_get_crtc_state() instead to ensure the stat=
e is
> > > brought into the commit if it is missing?
> > I think it is fine here; I'll just copy the pattern from [1].
> >=20
> > [1] https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/mgag=
200/mgag200_mode.c#L487
>=20
> It could be that there's a long standing problem in the overall logic. Not
> having a CRTC (and hence crtc_state) should also mean !fb, so we'd return=
 at
> [1]. If we have a CRTC on the plane but pass a crtc_state of NULL, we cou=
ld
> get a panic at [2], where it does crtc_state->crtc.=A0 I'm not aware of a=
ny
> bug reports about this problem, but it's still an issue.
>=20
> A number of drivers get this wrong by using
> drm_atomic_helper_get_new_crtc_state(). The bot suggests to use
> drm_atomic_helper_get_crtc_state() instead.=A0 This helper also returns t=
he
> new state. But=A0 if there's no new state, it duplicates the CRTC's exist=
ing
> state. That's a bit of an overhead, but probably not an issue.=A0 Several
> drivers use this helper, but also get it wrong. They tend to return early=
 in
> the case of !crtc or !fb without calling _check_plane_state(). See [3] and
> [4] for examples.
>=20
> I think, going with the bot's suggestion to use
> drm_atomic_helper_get_crtc_state() might be the best resolution for now. =
It
> still needs a crtc pointer, so the pattern is
>=20
> crtc_state =3D NULL
> if (plane_state->crtc)
> =A0 =A0 crtc_state =3D drm_atomic_helper_get_crtc_state(plane_state->crtc)
>=20
> _check_plane_state(plane_state, crtc_state);
>=20
> And in this case, _check_plane_state() should work correctly. But you can
> only use _get_crtc_state() in the atomic_check helpers! In the
> atomic_update, atomic_enable, etc helpers, it's too late for the helper to
> copy the CRTC state.
>=20
> I think some other DRM dev should look over this as well. It's one of the
> trickier things in DRM to get right.

drm_atomic_helper_get_crtc_state is safe in atomic_check. It's
everything after that must use either get_new_crtc_state or
get_old_crtc_state, as the global state cannot be modified anymore.

Maxime

--lkbwojfab5zeg2qh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCal4r6QAKCRAnX84Zoj2+
djhGAYCtixMssCdv8dqBLhL8AGCbqHVEcB24miO1/lrC21m8xRJjw/XtwiTe9uk3
u4LZbpABgJqkOJIhKLmzGuvYfOvGsyd49cCHHxPbfZ61/iBr5yCbvhnk0bm7yW/6
PWaUe1AQtQ==
=Kjek
-----END PGP SIGNATURE-----

--lkbwojfab5zeg2qh--

