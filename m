Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2A1C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC0E10F5D5;
	Fri, 14 Aug 2026 13:56:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fq/01pGL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D6B10F5D5
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:56:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC50760120;
 Fri, 14 Aug 2026 13:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1111F00A3A;
 Fri, 14 Aug 2026 13:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786715786;
 bh=uPAC/fQbCUTc8adZQ/QRyIZuuHGkNYE/wuUzv2iB+PQ=;
 h=Date:From:To:Cc:Subject;
 b=Fq/01pGLwTrNOxYfXAsop/mkoqZ0gH3GnVuqIh0sjFujwQHvkQ+hI7LUEyKiyY4+W
 JD27snz34s3NqGFUJSREzeFpstKayenLoVl0LtGMypW9pfeuFbis/sayuWksAhWJhX
 WfqqBmgilAmV2MLwzs9RqPD3EFBdePOFLc5K006E4RMJ0zv0YF6Q9RfOUo3Saa6jhq
 2ivBnBt3QW4UGC+2Rcg94OsLXHitTMvaF1QIldb0bZR/J8LwXQ1BIbACZke2kzyNxl
 6hu+0dld/efbdDW7zGWFXo1J03XpcO+1rp/RizGUOGw/ussjzQYxrEyFYojivU6SFJ
 QwUeE4colM4gQ==
Date: Fri, 14 Aug 2026 14:56:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Laura Nao <laura.nao@collabora.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Matt Roper <matthew.d.roper@intel.com>, Raag Jadav <raag.jadav@intel.com>,
 Riana Tauro <riana.tauro@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: linux-next: manual merge of the drm tree with the mm-unstable, origin
 tree
Message-ID: <an8ehRJI1gtVIu-J@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DNBiV+EyaCYJkO7b"
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


--DNBiV+EyaCYJkO7b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/xe/xe_device.c

between commits:

  130910bac905a ("drm/xe/pf: Disable display in admin only PF mode")
  ef526d122b62a ("drm/xe: Fix xe_device_probe() failure")

=66rom the mm-unstable,origin tree and commits:

  21fcb222f0d1e ("drm: Remove DRIVER_GEM_GPUVA feature flag")
  3799dc5d77855 ("drm/xe/ras: Fix boot-time ras error processing")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/xe/xe_device.c
index 3e70f2d39df29,71ce153737abe..0000000000000
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
@@@ -330,7 -331,7 +331,7 @@@ static int xe_pci_barrier_mmap(struct f
  	if (vma->vm_end - vma->vm_start > SZ_4K)
  		return -EINVAL;
 =20
 -	if (is_cow_mapping(vma->vm_flags))
 +	if (vma_is_cow_mapping(vma))
  		return -EINVAL;
 =20
  	if (vma->vm_flags & (VM_READ | VM_EXEC))
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
@@@ -1102,6 -1141,13 +1141,13 @@@
  	if (err)
  		goto err_unregister_display;
 =20
+ 	/*
+ 	 * Process and log any errors detected by hardware. Possible results can
+ 	 * include declaring the device as wedged, which must be done only after
+ 	 * xe_device_wedged_fini() is registered.
+ 	 */
+ 	xe_ras_process_errors(xe);
+=20
  	err =3D devm_add_action_or_reset(xe->drm.dev, xe_device_sanitize, xe);
  	if (err)
  		goto err_unregister_display;
@@@ -1131,14 -1177,14 +1177,14 @@@ void xe_device_shutdown(struct xe_devic
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

--DNBiV+EyaCYJkO7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp/HoQACgkQJNaLcl1U
h9D6Fgf/YLRwr85KKi/ROjy4ZerTn7BMEWVjd8luCk53d1n03PsLri9894qQImVB
2RwOF3+c6ZbHSWEewemGt+Y8H8Aswi8QIydmQgVRgcDShFEe11oanXuq3/P1S0s/
141seUoN7i0LeoJNvCRWIEGKNmqkRBlUFdLoK/pccB3cEFBG0mRPMTlAAy/aALK6
23QQWCeLGYaVIRmNYIuYIM0V3Rj/WBpV6cYYkvmd5h0EvWywXxqHINjj9IBDGkgl
dKRF+vm6xpg/6WAVFlxQ5A1IABoraHG6Ke/XNNN604BsQL7wOzKKAk9KmIrBF3ji
3K59M59hFyereGZusCA1W+i8xGuIwQ==
=A6Sz
-----END PGP SIGNATURE-----

--DNBiV+EyaCYJkO7b--
