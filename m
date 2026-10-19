Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3640FCCF2E5
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 839EB10ED8E;
	Mon, 19 Oct 2026 14:26:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2BD610EDDE
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:26:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C74341ABC;
 Mon, 19 Oct 2026 14:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB301F000C8;
 Mon, 19 Oct 2026 14:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792419972;
 bh=DaSM4M9tttPQz83r2q9i9D3CTwdtlsu+SwUsFN6pCCE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=G4yIvsjVmphgJHjlfUfE/6GYYeJx1kXsyQlJW5HuvU2CtXQl2wBMaVfXXAwJh7vwn
 keNWffRbKPQt4B7W/kR9vcrB1BlHZe+y8+lnTTqM5TrUPcCAC8fx3bYqolFyam8l8S
 2vH/EDK7jYsgGek+QtOlynq06slOd79NxoyuOCPt6Uj+EZYQT7NsWGpiasPp1M1uip
 27jDdVVKVhV/9lRqslOPBO9M6gKIF99fOeAEvQBVfY9Kjt2y6Ib4EA4uT2VBHJMELA
 4NgAK1xemzmiM36Y1cs6URb0Y+2GGyZ0wZfGs8ZcPbEa3uo9Dh1yTlbBNDSLhZGUbU
 8C5WCkb2PDpGw==
Date: Mon, 19 Oct 2026 16:26:08 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: Helen Koike <helen.fornazier@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v2] drm/ci: Add CI pipeline for drm-misc branches
Message-ID: <atYoMnjtOhDLJwza@houat>
References: <20260911-drm-drm-misc-ci-v2-1-1847f89585cb@kernel.org>
 <9e1fc5c6-53ff-4a4d-9744-77bcf6a0325e@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="p6yas62h76l2tfcz"
Content-Disposition: inline
In-Reply-To: <9e1fc5c6-53ff-4a4d-9744-77bcf6a0325e@collabora.com>
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


--p6yas62h76l2tfcz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] drm/ci: Add CI pipeline for drm-misc branches
MIME-Version: 1.0

Hi Vignesh,

On Mon, Oct 19, 2026 at 03:30:54PM +0530, Vignesh Raman wrote:
> Hi,
>=20
> On 11/09/26 17:48, Maxime Ripard wrote:
> > The DRM CI infrastructure builds upon Mesa's CI to run IGT tests on
> > hardware. Its focus is on functional testing on a selected number of
> > targets.
> >=20
> > The concern for drm-misc is different: it merges a large number of
> > patches across many platforms, and build or unit test breakages happen
> > on a regular basis. Adding build and unit testing for drm-misc has been
> > on the back of our minds, and a first attempt was made last year. The
> > feedback was to rely more on the existing infrastructure.
> >=20
> > Introduce a CI entry point that runs on pushes to drm-misc-next,
> > drm-misc-fixes, and drm-misc-next-fixes. It reuses kunit.yml,
> > check-devicetrees.yml, and the freedesktop ci-templates, while defining
> > build templates inline to avoid pulling in the Mesa pipeline.
> >=20
> > A single Debian container with LLVM handles cross-compilation to all
> > three architectures. The pipeline compiles the kernel using defconfigs
> > from the drm/tip rerere-cache branch, runs the DRM KUnit tests, and
> > checks device tree bindings.
> >=20
> > Link: https://lore.kernel.org/all/20250319-greedy-sturgeon-from-avalon-=
ac758f@houat/
> > Acked-by: Vignesh Raman <vignesh.raman@collabora.com>
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> > Changes in v2:
> > - Run dt_bindings_check
> > - Run on push instead of MR after some discussions with Dave and Sima
> > - Test run here: https://gitlab.freedesktop.org/mripard/kernel/-/pipeli=
nes/1744733
> > - Link to v1: https://lore.kernel.org/r/20260902-drm-drm-misc-ci-v1-1-4=
9d05e228eab@kernel.org
>=20
> Acked-by: Vignesh Raman <vignesh.raman@collabora.com>

Thanks for the review, see below

> > ---
> >   drivers/gpu/drm/ci/drm-misc-ci.yml | 147 ++++++++++++++++++++++++++++=
+++++++++
> >   1 file changed, 147 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/ci/drm-misc-ci.yml b/drivers/gpu/drm/ci/dr=
m-misc-ci.yml
> > new file mode 100644
> > index 000000000000..4ab87547794e
> > --- /dev/null
> > +++ b/drivers/gpu/drm/ci/drm-misc-ci.yml
> > @@ -0,0 +1,147 @@
> > +# CI pipeline for drm-misc-next, drm-misc-fixes, and drm-misc-next-fix=
es.
> > +#
> > +# Runs on pushes to drm-misc-next, drm-misc-fixes, and
> > +# drm-misc-next-fixes. Compiles the kernel for arm, arm64, and
> > +# x86_64, runs the DRM KUnit tests, and checks device tree bindings.
> > +#
> > +# A single container image is built using freedesktop ci-templates with
> > +# the packages needed for kernel compilation and LLVM for
> > +# cross-compilation. QEMU is installed at runtime by the KUnit jobs.
> > +#
> > +# check-devicetrees.yml and kunit.yml are included directly. build.yml
> > +# and the Mesa container/build pipelines are not:
> > +# they pull in hundreds of Mesa-specific jobs and templates that would
> > +# each need to be individually stubbed or disabled. The build templates
> > +# (.build:arm32, .build:arm64, .build:x86_64) are defined inline.
> > +
> > +variables:
> > +  CI_TEMPLATES_COMMIT: &ci-templates-commit aec7a6ce7bb38902c70641526f=
6611e27141784a
> > +  # Project whose container registry stores the built images
> > +  FDO_UPSTREAM_REPO: mripard/kernel
> > +  KERNEL_BUILD_CONTAINER_TAG: "2026-09-11-01"
> > +  LLVM_VERSION: "19"

I just realised there's still my personal repo being used as the
container registry. Are you ok if I change it to drm/misc/kernel when
applying?

Thanks again,
Maxime

--p6yas62h76l2tfcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCatYoegAKCRAnX84Zoj2+
dnkIAYD9emTICkJ8mFFLwtNMnDVkVgaKoJFQXbZOQYfIfJl1SupzOJcfDQCPRIYz
tnmc9UUBgMsaFLuNBpEovo1gqNoIN982LvHJwBdGMrTqRLSksr/yt68nv12PFWIR
O33X37wBtA==
=r0xP
-----END PGP SIGNATURE-----

--p6yas62h76l2tfcz--
