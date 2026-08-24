Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B91EC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 870F610E75A;
	Mon, 24 Aug 2026 11:46:17 +0000 (UTC)
X-Greylist: delayed 372 seconds by postgrey-1.36 at gabe;
 Mon, 24 Aug 2026 11:46:15 UTC
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E74D10E75A
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:46:15 +0000 (UTC)
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 75D293700ED2
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:39:54 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 9CC6EB541E5; Mon, 24 Aug 2026 11:39:52 +0000 (UTC)
Received: from shepard (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id D113BB541DB;
 Mon, 24 Aug 2026 11:39:51 +0000 (UTC)
Date: Mon, 24 Aug 2026 13:39:49 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 15/70] drm/logicvc: Switch to
 drm_atomic_helper_crtc_create_state
Message-ID: <aowthb5VAeG4JSEi@shepard>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-15-fb793475c05a@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5YYUaZEtaLjuFCEs"
Content-Disposition: inline
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-15-fb793475c05a@kernel.org>
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

--5YYUaZEtaLjuFCEs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Fri 21 Aug 26, 16:38, Maxime Ripard wrote:
> The logicvc crtc implementation uses the deprecated
> drm_atomic_helper_crtc_reset() as its reset hook.
>=20
> Switch to drm_atomic_helper_crtc_create_state() instead.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Paul Kocialkowski <paulk@sys-base.io>
> ---
>  drivers/gpu/drm/logicvc/logicvc_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/logicvc/logicvc_crtc.c b/drivers/gpu/drm/log=
icvc/logicvc_crtc.c
> index 81e5b80736fa..3fcebd6af6f4 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_crtc.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_crtc.c
> @@ -211,11 +211,11 @@ static void logicvc_crtc_disable_vblank(struct drm_=
crtc *drm_crtc)
>  	regmap_write_bits(logicvc->regmap, LOGICVC_INT_MASK_REG,
>  			  LOGICVC_INT_MASK_V_SYNC, LOGICVC_INT_MASK_V_SYNC);
>  }
> =20
>  static const struct drm_crtc_funcs logicvc_crtc_funcs =3D {
> -	.reset			=3D drm_atomic_helper_crtc_reset,
> +	.atomic_create_state =3D drm_atomic_helper_crtc_create_state,

It looks like you are breaking the tab indent and replacing it with a single
space here. Could you keep the tab alignment instead?

Thanks,

Paul

>  	.destroy		=3D drm_crtc_cleanup,
>  	.set_config		=3D drm_atomic_helper_set_config,
>  	.page_flip		=3D drm_atomic_helper_page_flip,
>  	.atomic_duplicate_state	=3D drm_atomic_helper_crtc_duplicate_state,
>  	.atomic_destroy_state	=3D drm_atomic_helper_crtc_destroy_state,
>=20
> --=20
> 2.55.0
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--5YYUaZEtaLjuFCEs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmqMLYUACgkQhP3B6o/u
lQxyTw//YnO+3ASOhDB6khIeDNoeTeMoK818XoI1aTARu2Kfej3EWfIDXm3GsiqM
TBUQdfOR3iWDJK5tbPY6UeFCW/btv17LPRctVN3e8Or+R7WLiA5g/sP563ci+pMw
7/qGqgO2J9UQC56iK9BcUJAnCbOAo/mptg1Wblk70PXNCRU3iPXz/mQAOukJyQ8f
qUlyJWLDUL9Ux7avyp81D0roBl/3BqCVo3kdO8VRDXqOQA2c3fwAKS5ZQWTmQMFP
ht8YsEKRvaR2M82jr0oRM+A1VQfRIKIYm1/pXyJpVHthzbYeykAq4i10EQqGqVg/
K5VlSvUIeUlBIcv1nf9ca/HCXg2qdS4mbpn32SutUGqcVO0UBjLvQAvEQDU60Lhj
OjUOEk6MtX/upB4rqB8TvCOcRsyKfq/zyjU5Dyou+PjUvA29fjlFdKDw7oEUo/Rg
uM2u7/pbnlnVAEPa2uCVgbco033dH8swDdedJh6xdEeDqRentTzpVQo83BWL6kSj
t8smGSVL0ZPHDjno4LMwsFNP4CuvZOs3EILz7TM4RZeWsYsmVz2xJlFon1TGF4mt
MuBVRSucgppOSKFu2crR541xpT7DWLt11tDNZ+qFbJgKHM6MmYO4JVtk3hzmzo4M
NFvae2ulomIHk0TBjrvfuy8HgPm5GXPE4vuzXkBQcUHZ3BAKa5s=
=RSJM
-----END PGP SIGNATURE-----

--5YYUaZEtaLjuFCEs--
