Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1133606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfMTwKmf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B1210E1FC;
	Thu, 22 Oct 2026 07:21:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C2010E1FC
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 07:21:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 785D443503;
 Thu, 22 Oct 2026 07:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70301F000C1;
 Thu, 22 Oct 2026 07:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792653707;
 bh=mWIE+eMawt7H2VKpXgqqnxcVGLEc58EkBryNQMthWYM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NfMTwKmf9qNFoW4trMtBzaYHuZ8WvjJoi7Q7R+QtgcZ0MHO+L4VW5stXP62cKioBn
 8n0SwlltxRdl5uUd6vlsZzNWvEEHEFSl65gOwxk2A+LpDy1c/Iq/LhaelE/zMFwDUX
 0PyWVTUK+hnSwrORRRBwFUS2CYkoGg9O5rWESpfmvUGXexRm6ui/ZJSWesJ4sjXKLh
 IqpLT9eU4jSJqpSV3Vf8DJt46UEbbalqsQG0aH5jLXKAf660/oElZzBxfbr/KLapTU
 5YZfjMmy5UqXU6WN4qSbeshkd8/2Fd2W7IywLeyMcEEoVoqxt7657fJGTjPKY4jB7+
 OxIlzeh2IdtGQ==
Date: Thu, 22 Oct 2026 09:21:43 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH 39/75] drm/sysfb: Switch to
 drm_atomic_helper_connector_create_state
Message-ID: <atm5NgjC-B1DETr6@houat>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-39-586c9c026823@kernel.org>
 <45af481c-6445-48a7-8372-a5a486ea0eca@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ybe5ixt5jorngdpr"
Content-Disposition: inline
In-Reply-To: <45af481c-6445-48a7-8372-a5a486ea0eca@suse.de>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--ybe5ixt5jorngdpr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 39/75] drm/sysfb: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0

Hi Thomas,

Thanks for your review

On Tue, Oct 20, 2026 at 03:49:56PM +0200, Thomas Zimmermann wrote:
> Am 14.10.26 um 19:27 schrieb Maxime Ripard:
> > The sysfb connector implementation uses the deprecated
> > drm_atomic_helper_connector_reset() as its reset hook.
> >=20
> > Switch to drm_atomic_helper_connector_create_state() instead.
> >=20
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> > Cc: Javier Martinez Canillas <javierm@redhat.com>
> > ---
> >   drivers/gpu/drm/sysfb/drm_sysfb_helper.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h b/drivers/gpu/drm=
/sysfb/drm_sysfb_helper.h
> > index c043428e02fd..6dab27b41c08 100644
> > --- a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
> > +++ b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
> > @@ -192,11 +192,11 @@ int drm_sysfb_connector_helper_get_modes(struct d=
rm_connector *connector);
> >   #define DRM_SYSFB_CONNECTOR_HELPER_FUNCS \
> >   	.get_modes =3D drm_sysfb_connector_helper_get_modes
> >   #define DRM_SYSFB_CONNECTOR_FUNCS \
> > -	.reset =3D drm_atomic_helper_connector_reset, \
> > +	.atomic_create_state =3D drm_atomic_helper_connector_create_state, \
>=20
> I'm sort of pedantic about this: I think fields should be initialized in =
the
> order they appear in the declaration. atomic_create_state should therefore
> go before atomic_duplicate state. Here and everywhere else. Apart from th=
at

This patch is particular is now merged, but I've updated all the other
patches to reflect that.

Maxime

--ybe5ixt5jorngdpr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCatm5hgAKCRAnX84Zoj2+
dhCKAX9ESjf+VS8BCCbshA5Y0RR4xOgtQC3lIheZMVoat3rDIc/UeusQjR8PZ+7t
OQYjP74BfRKrBT+PIooDqHDgzS8OWeLIylPinuTHAn+PbmSnQd08hpl1oxTyODbI
xfZgDHS7AQ==
=xODZ
-----END PGP SIGNATURE-----

--ybe5ixt5jorngdpr--
