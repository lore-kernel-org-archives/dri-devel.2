Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4968C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB9EA10E061;
	Mon,  3 Aug 2026 14:31:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LQmrHyHU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7F0B10E061
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:31:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F06E660A7F;
 Mon,  3 Aug 2026 14:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18AA1F00A3D;
 Mon,  3 Aug 2026 14:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785767480;
 bh=UrNRsvkq3mRq9rnhVFpNzGn9hA5dWUxfYCBYBKp8OXA=;
 h=Date:From:To:Cc:Subject;
 b=LQmrHyHUdiSIxAHst772BpJZkeznqd3RmMzB1aEDDpbmCg+zvpGMpRu1kqNtlp09g
 VWjaV2b8GbPXUBkY1cucqSeffCLjwXDayr/wUTkfCGudAR5O1aapz5IffXZaVctMxf
 BaM3mu0IkjpLV/8LAA6iOF8wtdSM1mU2eL5QYPYlcCZvjahPBvSlko7T1bjmGLqfya
 nF66KJYAH2W9JCa1iqEtPhSU0DCkHgaMYH5r37U+ERVBi+VrGJ4+h8XZZoFWZ8xXBq
 mWNzKNSZ6B9VN/N/CMg9p2fhJ9ju7KXLdDmAiHVlQpe4FnT12unOgEO0Xq77mJaPCw
 3ML2bysk571XQ==
Date: Mon, 3 Aug 2026 15:31:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Laura Nao <laura.nao@collabora.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <anCmM4lBkA_d6vcW@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0RQ1E4DKTet8pR8b"
Content-Disposition: inline
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


--0RQ1E4DKTet8pR8b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/xe/xe_device.c

between commit:

  130910bac905a ("drm/xe/pf: Disable display in admin only PF mode")

=66rom the origin tree and commits:

  7ef55ae582eba ("drm/xe/pf: Disable display in admin only PF mode")
  21fcb222f0d1e ("drm: Remove DRIVER_GEM_GPUVA feature flag")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

*Please* consider using merges rather than cherry picking.

diff --combined drivers/gpu/drm/xe/xe_device.c
index 9d119c95a569a,7007b6113760a..0000000000000
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@@ -61,6 -61,7 +61,7 @@@
  #include "xe_psmi.h"
  #include "xe_pxp.h"
  #include "xe_query.h"
+ #include "xe_ras.h"
  #include "xe_shrinker.h"
  #include "xe_soc_remapper.h"
  #include "xe_survivability_mode.h"
@@@ -281,7 -282,7 +282,7 @@@ static vm_fault_t barrier_fault(struct=20
  	pgprot_t prot;
  	int idx;
 =20
 -	prot =3D vm_get_page_prot(vma->vm_flags);
 +	prot =3D vma_get_page_prot(vma);
 =20
  	if (drm_dev_enter(dev, &idx)) {
  		unsigned long pfn;
@@@ -396,7 -397,7 +397,7 @@@ static const struct drm_driver regular_
  	    XE_DISPLAY_DRIVER_FEATURES |
  	    DRIVER_GEM |
  	    DRIVER_RENDER | DRIVER_SYNCOBJ |
- 	    DRIVER_SYNCOBJ_TIMELINE | DRIVER_GEM_GPUVA,
+ 	    DRIVER_SYNCOBJ_TIMELINE,
  	.open =3D xe_file_open,
  	.postclose =3D xe_file_close,
 =20
@@@ -426,7 -427,7 +427,7 @@@ static const struct drm_ioctl_desc xe_i
 =20
  static const struct drm_driver admin_only_driver =3D {
  	.driver_features =3D
- 	    DRIVER_GEM | DRIVER_RENDER | DRIVER_GEM_GPUVA,
+ 	    DRIVER_GEM | DRIVER_RENDER,
  	.open =3D xe_file_open,
  	.postclose =3D xe_file_close,
  	.ioctls =3D xe_ioctls_admin_only,
@@@ -736,9 -737,11 +737,11 @@@ static void vf_update_device_info(struc
  	xe->info.probe_display =3D 0;
  	xe->info.has_heci_cscfi =3D 0;
  	xe->info.has_heci_gscfi =3D 0;
+ 	xe->info.has_i2c =3D 0;
  	xe->info.has_late_bind =3D 0;
  	xe->info.skip_guc_pc =3D 1;
  	xe->info.skip_pcode =3D 1;
+ 	xe->info.has_drm_ras =3D false;
  }
 =20
  static int xe_device_vram_alloc(struct xe_device *xe)
@@@ -918,6 -921,27 +921,27 @@@ static void xe_device_wedged_fini(struc
  		xe_pm_runtime_put(xe);
  }
 =20
+ #ifdef CONFIG_DRM_XE_DEBUG_PAGE_SIZE
+ static int xe_debug_page_size_alloc_ctrl_init(struct xe_device *xe)
+ {
+ 	int err;
+=20
+ 	err =3D drmm_mutex_init(&xe->drm, &xe->page_size_alloc_ctrl.lock);
+ 	if (err)
+ 		return err;
+=20
+ 	xe->page_size_alloc_ctrl.mode =3D XE_PAGE_SIZE_ALLOC_CTRL_MODE_NONE;
+ 	xe->page_size_alloc_ctrl.cur_index =3D 0;
+=20
+ 	return 0;
+ }
+ #else
+ static int xe_debug_page_size_alloc_ctrl_init(struct xe_device *xe)
+ {
+ 	return 0;
+ }
+ #endif
+=20
  int xe_device_probe(struct xe_device *xe)
  {
  	struct xe_tile *tile;
@@@ -947,6 -971,15 +971,15 @@@
  			return err;
  	}
 =20
+ 	/*
+ 	 * Wa_16029380221: The affected GT will always use non-coherent
+ 	 * access to page tables, so we must do uncached writes from the
+ 	 * CPU.
+ 	 */
+ 	for_each_gt(gt, xe, id)
+ 		if (XE_GT_WA(gt, 16029380221))
+ 			xe->info.has_cached_pt =3D false;
+=20
  	for_each_tile(tile, xe, id) {
  		err =3D xe_ggtt_init_early(tile->mem.ggtt);
  		if (err)
@@@ -987,6 -1020,16 +1020,16 @@@
  	if (err)
  		return err;
 =20
+ 	err =3D xe_soc_remapper_init(xe);
+ 	if (err)
+ 		return err;
+=20
+ 	err =3D xe_sysctrl_init(xe);
+ 	if (err)
+ 		return err;
+=20
+ 	xe_ras_init(xe);
+=20
  	/*
  	 * Now that GT is initialized (TTM in particular),
  	 * we can try to init display, and inherit the initial fb.
@@@ -1027,10 -1070,6 +1070,6 @@@
 =20
  	xe_nvm_init(xe);
 =20
- 	err =3D xe_soc_remapper_init(xe);
- 	if (err)
- 		return err;
-=20
  	err =3D xe_heci_gsc_init(xe);
  	if (err)
  		return err;
@@@ -1055,6 -1094,10 +1094,10 @@@
  	if (err)
  		return err;
 =20
+ 	err =3D xe_debug_page_size_alloc_ctrl_init(xe);
+ 	if (err)
+ 		return err;
+=20
  	err =3D drm_dev_register(&xe->drm, 0);
  	if (err)
  		return err;
@@@ -1069,10 -1112,6 +1112,6 @@@
  	if (err)
  		goto err_unregister_display;
 =20
- 	err =3D xe_sysctrl_init(xe);
- 	if (err)
- 		goto err_unregister_display;
-=20
  	err =3D xe_device_sysfs_init(xe);
  	if (err)
  		goto err_unregister_display;
@@@ -1127,14 -1166,14 +1166,14 @@@ void xe_device_shutdown(struct xe_devic
 =20
  	drm_dbg(&xe->drm, "Shutting down device\n");
 =20
- 	xe_display_pm_shutdown(xe);
+ 	xe_display_shutdown(xe);
 =20
  	xe_irq_suspend(xe);
 =20
  	for_each_gt(gt, xe, id)
  		xe_gt_shutdown(gt);
 =20
- 	xe_display_pm_shutdown_late(xe);
+ 	xe_display_shutdown_late(xe);
 =20
  	if (!xe_driver_flr_disabled(xe)) {
  		/* BOOM! */

--0RQ1E4DKTet8pR8b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpwpjMACgkQJNaLcl1U
h9Aiagf+Od6B4wfFaCmAMwE7fVd4W24Za1tYlkAbmAALmuI7PgdG2UbuQpF3S1Bb
oN3if3nkbRDIHVD94bGUtbIvu0Wn3WZmya0OwQUCPaaHPF1z5jpFh8chAzZnlMA3
nIl1/OvDRtCcJzJzY7+3aX6rD+PNq5ansEqyQ6y7neGYeR5GdZBDKEvWYO6FBmWu
ND/x5++XDXkDzEoCEB1uF6JaHROjr1Rbsm2BVoktH8f/UvhSfoDsNChnJXSBQG8P
JdEkvIe2bO5zXINpd9Dl/7LhzvnlO0QfvZ2brd5S3P3UiAt9+S3w3aimERm74IiO
29W+gCMTu0tZPb5x/HnmlTEkV2H8bQ==
=agZI
-----END PGP SIGNATURE-----

--0RQ1E4DKTet8pR8b--
