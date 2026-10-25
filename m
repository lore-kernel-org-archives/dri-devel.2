Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5B606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 10:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D03A10E042;
	Sun, 25 Oct 2026 10:33:21 +0000 (UTC)
X-Greylist: delayed 547 seconds by postgrey-1.36 at gabe;
 Sun, 25 Oct 2026 10:33:20 UTC
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC4510E042
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 10:33:20 +0000 (UTC)
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 5C2C33700F61
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 10:24:08 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 589FAB70226; Sun, 25 Oct 2026 10:24:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 75789B701D6;
 Sun, 25 Oct 2026 10:24:05 +0000 (UTC)
Date: Sun, 25 Oct 2026 11:24:03 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 20/59] drm/logicvc: Switch to
 drm_atomic_helper_connector_create_state
Message-ID: <at3Yw1ygPD7taVwS@collins>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
 <20261022-drm-no-more-connector-reset-v2-20-0b7e4e85b1e8@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3UWLYRbEnPklAOBw"
Content-Disposition: inline
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-20-0b7e4e85b1e8@kernel.org>
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

--3UWLYRbEnPklAOBw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

Le Thu 22 Oct 26, 14:31, Maxime Ripard a =C3=A9crit :
> The logicvc connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
>=20
> Switch to drm_atomic_helper_connector_create_state() instead.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>

All the best,

Paul

> ---
> Cc: Paul Kocialkowski <paulk@sys-base.io>
> ---
>  drivers/gpu/drm/logicvc/logicvc_interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/logicvc/logicvc_interface.c b/drivers/gpu/dr=
m/logicvc/logicvc_interface.c
> index 81f760dc07f8..32c0ee6226c9 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_interface.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_interface.c
> @@ -88,7 +88,7 @@ static const struct drm_connector_helper_funcs logicvc_=
connector_helper_funcs =3D
> =20
>  static const struct drm_connector_funcs logicvc_connector_funcs =3D {
> -	.reset			=3D drm_atomic_helper_connector_reset,
>  	.fill_modes		=3D drm_helper_probe_single_connector_modes,
>  	.destroy		=3D drm_connector_cleanup,
> +	.atomic_create_state	=3D drm_atomic_helper_connector_create_state,
>  	.atomic_duplicate_state	=3D drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state	=3D drm_atomic_helper_connector_destroy_state,
>=20
> --=20
> 2.55.0
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--3UWLYRbEnPklAOBw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmrd2MMACgkQhP3B6o/u
lQwTXg/+L85VqSNuRulknV4grqGjjMVS7VBMjI10//+hnq2ebOWAvX8xBFCFKnLY
ooEvxHsUY9tKbHiiPy+oJK7lsBjYlccz1XLxBaTSpbrCDAqhtIQ7n4idXvLTtpgA
C09hH38TSSENG2Gy+5tWp1S1aotYfU9yoz8VSHHB2ARu7twulhE/z5+xMm7fsI/C
vPlGslWXtOyDTBHhAXk74Zgo1w5HpwV/u+THbxizYvoH285Kmka+gvGyosgo1Tqy
A9zn+BPo3XeaFZUSl1LKCsjGH/sDSWmqT/U267kPf+tqafRrw5wtFIyas+UUz1HV
+xAGISiBD7fZfG61/w5hZzcXfTl+BudHJ9e39m5GvWRQNc4m3Jg3bMSGqmvj9fW+
H2TjrrIEx33keBsPkjHLEyTediUcSCkdPuw2gcb1bMPC1I1wFnCc4dGW0fuD33P6
6AhW0zzQG/0wBiWq1J+/5KD90JBVe9aUu2EX87lRonzlwf/Y64MmaAW7ItZWlGb0
0RqmnCMNvYK2X5azo2AGO8hqIKfEFhT5EMCOtr1rLkgoinf3B3rasT+wsG/nOrot
at8MXQfrs2otsSASs5wdzRjHndnNohjLJiEptgBDtp0yJLN9eBOH+7XEvXPnCRk6
luzXmu2PXZCiLBB3zDbkZmYRi8WpkNf32Teo45TAeCbSL6YVuYE=
=qrYQ
-----END PGP SIGNATURE-----

--3UWLYRbEnPklAOBw--
