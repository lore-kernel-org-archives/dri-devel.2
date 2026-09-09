Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57163C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0CD310EFBB;
	Wed,  9 Sep 2026 08:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jsr3OMp0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 574F810EFBB
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 08:22:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 20EE440631;
 Wed,  9 Sep 2026 08:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EA41F00A3A;
 Wed,  9 Sep 2026 08:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788942146;
 bh=IZJZkwuzP9bCUn9cbZ6GATDpFjjOakgDLWy9LKF4FFo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Jsr3OMp0oPWmNLnLn97/cGca4WY6c+Jjl9PmreoUPwVfel7+lDFyQeNDlUsRZekrr
 fGWCJBQhK2gpTSuyGOM07sEyQAH9OBcqYB95BmC2AW+0dFvPE7lHjq7qlCcObRCN5g
 3UhTgDRpWLIdAQ8V1HftQs4ArLScLNEyj80ve7DOf8jkL3H5RJfbsDic1ftdutnmP5
 1nl8DFX3nDyRB6k+AXXsmbYETHKroST7TjEhcNxU6+mdcPQd7cbWvc8aySZSGTqjd7
 hZDIEuukZumncGfsPGPveSs9GX+F445AeYYsg0dHelq8nomo5J7+1+n/CoVbipdNFt
 xC0RBivZ2KWMw==
Date: Wed, 9 Sep 2026 10:22:22 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Stone <daniels@collabora.com>, Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>,
 Jonas =?utf-8?B?w4VkYWhs?= <jadahl@redhat.com>, 
 Michel =?utf-8?Q?D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, Xaver Hugl <xaver.hugl@kde.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/11] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
Message-ID: <aqEMMpTN26hCs2dB@houat>
References: <20260908-drm-reset-state-flag-v3-0-905570f387a4@kernel.org>
 <20260908-drm-reset-state-flag-v3-9-905570f387a4@kernel.org>
 <3c77a62c-13e2-44bd-a7e8-c2ea29dcf352@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="mop3s4wzh3xzpd4v"
Content-Disposition: inline
In-Reply-To: <3c77a62c-13e2-44bd-a7e8-c2ea29dcf352@suse.de>
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


--mop3s4wzh3xzpd4v
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 09/11] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
MIME-Version: 1.0

Hi Thomas,

Thanks for the review

On Wed, Sep 09, 2026 at 09:24:41AM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 08.09.26 um 16:35 schrieb Maxime Ripard:
> [...]
> > diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> > index 0dbf04d4aa9e..f13bb7c490c4 100644
> > --- a/drivers/gpu/drm/drm_ioctl.c
> > +++ b/drivers/gpu/drm/drm_ioctl.c
> > @@ -303,10 +303,13 @@ static int drm_getcap(struct drm_device *dev, voi=
d *data, struct drm_file *file_
> >   		break;
> >   	case DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP:
> >   		req->value =3D drm_core_check_feature(dev, DRIVER_ATOMIC) &&
> >   			     dev->mode_config.async_page_flip;
> >   		break;
> > +	case DRM_CAP_ATOMIC_RESET:
> > +		req->value =3D drm_atomic_can_create_state(dev);
> > +		break;
>=20
> Looking at this and the other places where _can_create_state is being use=
d,
> I'd like to present a different design.
>=20
> Scratch the helper entirely and introduce a dedicated callback in
> drm_mode_config_funcs that sets up the default state.=A0 Your current hel=
per
> drm_atomic_commit_fill_with_defaults would be the common implementation. =
The
> DRM core could test for the existence of this callback to see if
> default-reset is available. Sure, we'd have to modify all drivers, but it
> would be architecturally cleaner IMHO and give full control to the driver=
s.

There's also an interaction with the other big series relying on
atomic_create_state: state read-out.

If you're doing state read-out, you want to if possible create a blank
state, and make the hardware fill it. If not possible, then reset the
hardware and allocate a blank state. Either way, all objects are
affected, and that's what drm_mode_config_create_state() will do there.

In the DRM_MODE_ATOMIC_RESET case, we don't want to create a blank state
for *everything* but only to what's exposed to userspace (ie, everything
but drm_private_obj). In a way, it's more akin to
drm_mode_config_reset(), but without the hardware reset part.

I still feel like two functions are easier to reason about for this, and
I don't think a helper would help: we haven't needed it so far for
drm_mode_config_reset() / drm_atomic_commit_alloc(), so it's not clear
to me what the extra modularity would bring to the table.

Maxime

--mop3s4wzh3xzpd4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaqEXOQAKCRAnX84Zoj2+
djkXAX4keCkaWpWy7OcyT8B3SL9jGkEc4NEWQdchk+KxSflN4+7nuX9AGeKKvGJh
JHrpRyIBgJGvkzzhqFrt/VaOEk0kLyYR+spIfMLF5BWoHIjCTZk/XFLd73oHnONo
sgzTzKJBSQ==
=bT3e
-----END PGP SIGNATURE-----

--mop3s4wzh3xzpd4v--
