Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070BDC4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E7689143;
	Mon, 20 Jul 2026 14:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MB8OeoQO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E0D89143
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:44:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 52CE642A04;
 Mon, 20 Jul 2026 14:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809571F000E9;
 Mon, 20 Jul 2026 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784558668;
 bh=V0Y52CnM1QiWmM65Vk5zYhmO11oRm4Hz903jLrkMwmU=;
 h=Date:From:To:Cc:Subject;
 b=MB8OeoQOJvVWoynVGXKE9/OxeoT/+Kxo0vYM6+MMt3cOMKEijVc5eHjMhMgzNmhNR
 eOwNNY7fmk50eZjmujwyytQdDMmDdu4hvLhTSIbt6mroBa4Hy29pwbTFLuYdwIHhZX
 lCdE+VUAzvYP7191MVcaGgjxRcUvgMOJvQpFNkluDWUPTbLGNtk9bGpNpAOCdZ7TBv
 quhGwHzlVvu8awg2ltCFrezzm2HSxOkegFHkblcoH4zsozzGkJOBj2dSW1QqFWnJoO
 I38hNGQ8h1dRpctaUzeGfBbq2ZDDkaKfvyX4V5+xsM+GDU9IPLAimEBhJdma2vg54c
 0ESvuAGlG54Xw==
Date: Mon, 20 Jul 2026 15:44:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Matt Roper <matthew.d.roper@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <al40RyVlEn28V5dQ@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oNOYsRe8fP3O4ki8"
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


--oNOYsRe8fP3O4ki8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/xe/xe_pci.c

between commit:

  130910bac905a ("drm/xe/pf: Disable display in admin only PF mode")

=66rom the origin tree and commit:

  b623bd790db04 ("drm/xe: Drop 'force_execlist' module parameter")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/xe/xe_pci.c
index 9cd873708136c,91af603e94315..0000000000000
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@@ -26,6 -26,7 +26,7 @@@
  #include "xe_guc.h"
  #include "xe_mmio.h"
  #include "xe_module.h"
+ #include "xe_pci_error.h"
  #include "xe_pci_rebar.h"
  #include "xe_pci_sriov.h"
  #include "xe_pci_types.h"
@@@ -355,6 -356,7 +356,7 @@@ static const __maybe_unused struct xe_d
  	PLATFORM(PVC),
  	.dma_mask_size =3D 52,
  	.has_display =3D false,
+ 	.has_drm_ras =3D true,
  	.has_gsc_nvm =3D 1,
  	.has_heci_gscfi =3D 1,
  	.max_gt_per_tile =3D 1,
@@@ -457,6 -459,7 +459,7 @@@ static const struct xe_device_desc cri_
  	PLATFORM(CRESCENTISLAND),
  	.dma_mask_size =3D 52,
  	.has_display =3D false,
+ 	.has_drm_ras =3D true,
  	.has_flat_ccs =3D false,
  	.has_gsc_nvm =3D 1,
  	.has_i2c =3D true,
@@@ -599,8 -602,6 +602,6 @@@ static int read_gmdid(struct xe_device=20
  	struct xe_reg gmdid_reg =3D GMD_ID;
  	u32 val;
 =20
- 	KUNIT_STATIC_STUB_REDIRECT(read_gmdid, xe, type, ver, revid);
-=20
  	if (IS_SRIOV_VF(xe)) {
  		/*
  		 * To get the value of the GMDID register, VFs must obtain it
@@@ -726,14 -727,30 +727,30 @@@ static int handle_gmdid(struct xe_devic
  	return 0;
  }
 =20
- static void init_devid(struct xe_device *xe)
+ struct xe_probed_info {
+ 	u16 devid;
+ 	u8 revid;
+ 	u8 tile_count;
+ 	struct xe_step_info step;
+ 	const struct xe_ip *graphics_ip;
+ 	const struct xe_ip *media_ip;
+ };
+=20
+ /*
+  * Probe from the hardware the info required by xe_info_init_early().
+  */
+ static int xe_probe_info_early(struct xe_device *xe,
+ 			       const struct xe_device_desc *desc,
+ 			       struct xe_probed_info *probed_info)
  {
  	struct pci_dev *pdev =3D to_pci_dev(xe->drm.dev);
 =20
- 	KUNIT_STATIC_STUB_REDIRECT(init_devid, xe);
+ 	probed_info->devid =3D pdev->device;
+ 	probed_info->revid =3D pdev->revision;
 =20
- 	xe->info.devid =3D pdev->device;
- 	xe->info.revid =3D pdev->revision;
+ 	xe_step_platform_get(desc->platform, probed_info->revid, &probed_info->s=
tep);
+=20
+ 	return 0;
  }
 =20
  /*
@@@ -742,17 -759,20 +759,20 @@@
   */
  static int xe_info_init_early(struct xe_device *xe,
  			      const struct xe_device_desc *desc,
- 			      const struct xe_subplatform_desc *subplatform_desc)
+ 			      const struct xe_subplatform_desc *subplatform_desc,
+ 			      struct xe_probed_info *probed_info)
  {
  	int err;
 =20
+ 	xe->info.devid =3D probed_info->devid;
+ 	xe->info.revid =3D probed_info->revid;
+ 	xe->info.step.platform =3D probed_info->step.platform;
+=20
  	xe->info.platform_name =3D desc->platform_name;
  	xe->info.platform =3D desc->platform;
  	xe->info.subplatform =3D subplatform_desc ?
  		subplatform_desc->subplatform : XE_SUBPLATFORM_NONE;
 =20
- 	init_devid(xe);
-=20
  	xe->info.dma_mask_size =3D desc->dma_mask_size;
  	xe->info.va_bits =3D desc->va_bits;
  	xe->info.vm_max_level =3D desc->vm_max_level;
@@@ -760,6 -780,7 +780,7 @@@
 =20
  	xe->info.is_dgfx =3D desc->is_dgfx;
  	xe->info.has_cached_pt =3D desc->has_cached_pt;
+ 	xe->info.has_drm_ras =3D desc->has_drm_ras;
  	xe->info.has_fan_control =3D desc->has_fan_control;
  	/* runtime fusing may force flat_ccs to disabled later */
  	xe->info.has_flat_ccs =3D desc->has_flat_ccs;
@@@ -788,16 -809,11 +809,11 @@@
 =20
  	xe->info.probe_display =3D IS_ENABLED(CONFIG_DRM_XE_DISPLAY) &&
  				 xe_modparam.probe_display &&
- 				 desc->has_display &&
- 				 !xe_device_is_admin_only(xe);
- 	xe->info.force_execlist =3D xe_modparam.force_execlist;
+ 				 desc->has_display;
 =20
  	xe_assert(xe, desc->max_gt_per_tile > 0);
  	xe_assert(xe, desc->max_gt_per_tile <=3D XE_MAX_GT_PER_TILE);
  	xe->info.max_gt_per_tile =3D desc->max_gt_per_tile;
- 	xe->info.tile_count =3D 1 + desc->max_remote_tiles;
-=20
- 	xe_step_platform_get(xe);
 =20
  	err =3D xe_tile_init_early(xe_device_get_root_tile(xe), xe, 0);
  	if (err)
@@@ -806,22 -822,21 +822,21 @@@
  	return 0;
  }
 =20
- /*
-  * Possibly override number of tile based on configuration register.
-  */
- static void xe_info_probe_tile_count(struct xe_device *xe)
+ static void xe_probe_tile_count(struct xe_device *xe,
+ 				const struct xe_device_desc *desc,
+ 				struct xe_probed_info *probed_info)
  {
  	struct xe_mmio *mmio;
  	u8 tile_count;
  	u32 mtcfg;
 =20
- 	KUNIT_STATIC_STUB_REDIRECT(xe_info_probe_tile_count, xe);
+ 	probed_info->tile_count =3D 1 + desc->max_remote_tiles;
 =20
  	/*
  	 * Probe for tile count only for platforms that support multiple
  	 * tiles.
  	 */
- 	if (xe->info.tile_count =3D=3D 1)
+ 	if (probed_info->tile_count =3D=3D 1)
  		return;
 =20
  	mmio =3D xe_root_tile_mmio(xe);
@@@ -834,10 -849,10 +849,10 @@@
  	mtcfg =3D xe_mmio_read32(mmio, XEHP_MTCFG_ADDR);
  	tile_count =3D REG_FIELD_GET(TILE_COUNT, mtcfg) + 1;
 =20
- 	if (tile_count < xe->info.tile_count) {
+ 	if (tile_count < probed_info->tile_count) {
  		drm_info(&xe->drm, "tile_count: %d, reduced_tile_count %d\n",
- 			 xe->info.tile_count, tile_count);
- 		xe->info.tile_count =3D tile_count;
+ 			 probed_info->tile_count, tile_count);
+ 		probed_info->tile_count =3D tile_count;
  	}
  }
 =20
@@@ -910,25 -925,10 +925,10 @@@ static struct xe_gt *alloc_media_gt(str
  	return gt;
  }
 =20
- /*
-  * Initialize device info content that does require knowledge about
-  * graphics / media IP version.
-  * Make sure that GT / tile structures allocated by the driver match the =
data
-  * present in device info.
-  */
- static int xe_info_init(struct xe_device *xe,
- 			const struct xe_device_desc *desc)
+ static int xe_probe_ips(struct xe_device *xe,
+ 			const struct xe_device_desc *desc,
+ 			struct xe_probed_info *probed_info)
  {
- 	u32 graphics_gmdid_revid =3D 0, media_gmdid_revid =3D 0;
- 	const struct xe_ip *graphics_ip;
- 	const struct xe_ip *media_ip;
- 	const struct xe_graphics_desc *graphics_desc;
- 	const struct xe_media_desc *media_desc;
- 	struct xe_tile *tile;
- 	struct xe_gt *gt;
- 	int ret;
- 	u8 id;
-=20
  	/*
  	 * If this platform supports GMD_ID, we'll detect the proper IP
  	 * descriptor to use from hardware registers.
@@@ -937,17 -937,21 +937,21 @@@
  	 * versions are simply derived from that.
  	 */
  	if (desc->pre_gmdid_graphics_ip) {
- 		graphics_ip =3D desc->pre_gmdid_graphics_ip;
- 		media_ip =3D desc->pre_gmdid_media_ip;
- 		xe_step_pre_gmdid_get(xe);
+ 		probed_info->graphics_ip =3D desc->pre_gmdid_graphics_ip;
+ 		probed_info->media_ip =3D desc->pre_gmdid_media_ip;
+ 		xe_step_pre_gmdid_get(xe, &probed_info->step);
  	} else {
- 		xe_assert(xe, !desc->pre_gmdid_media_ip);
- 		ret =3D handle_gmdid(xe, &graphics_ip, &media_ip,
- 				   &graphics_gmdid_revid, &media_gmdid_revid);
- 		if (ret)
- 			return ret;
+ 		int err;
+ 		u32 graphics_revid, media_revid;
 =20
- 		xe_step_gmdid_get(xe, graphics_gmdid_revid, media_gmdid_revid);
+ 		xe_assert(xe, !desc->pre_gmdid_media_ip);
+=20
+ 		err =3D handle_gmdid(xe, &probed_info->graphics_ip, &probed_info->media=
_ip,
+ 				   &graphics_revid, &media_revid);
+ 		if (err)
+ 			return err;
+=20
+ 		xe_step_gmdid_get(xe, graphics_revid, media_revid, &probed_info->step);
  	}
 =20
  	/*
@@@ -955,9 -959,56 +959,56 @@@
  	 * error and we should abort driver load.  Failing to detect media
  	 * IP is non-fatal; we'll just proceed without enabling media support.
  	 */
- 	if (!graphics_ip)
+ 	if (!probed_info->graphics_ip)
  		return -ENODEV;
 =20
+ 	return 0;
+ }
+=20
+ /*
+  * Probe from the hardware the info required by xe_info_init().
+  */
+ static int xe_probe_info(struct xe_device *xe,
+ 			 const struct xe_device_desc *desc,
+ 			 struct xe_probed_info *probed_info)
+ {
+ 	int err;
+=20
+ 	xe_probe_tile_count(xe, desc, probed_info);
+=20
+ 	err =3D xe_probe_ips(xe, desc, probed_info);
+ 	if (err)
+ 		return err;
+=20
+ 	return 0;
+ }
+=20
+ /*
+  * Initialize device info content that does require knowledge about
+  * graphics / media IP version.
+  * Make sure that GT / tile structures allocated by the driver match the =
data
+  * present in device info.
+  */
+ static int xe_info_init(struct xe_device *xe,
+ 			const struct xe_device_desc *desc,
+ 			struct xe_probed_info *probed_info)
+ {
+ 	const struct xe_ip *graphics_ip;
+ 	const struct xe_ip *media_ip;
+ 	const struct xe_graphics_desc *graphics_desc;
+ 	const struct xe_media_desc *media_desc;
+ 	struct xe_tile *tile;
+ 	struct xe_gt *gt;
+ 	u8 id;
+=20
+ 	graphics_ip =3D probed_info->graphics_ip;
+ 	media_ip =3D probed_info->media_ip;
+=20
+ 	xe->info.tile_count =3D probed_info->tile_count;
+ 	xe->info.step.basedie =3D probed_info->step.basedie;
+ 	xe->info.step.graphics =3D probed_info->step.graphics;
+ 	xe->info.step.media =3D probed_info->step.media;
+=20
  	xe->info.graphics_verx100 =3D graphics_ip->verx100;
  	xe->info.graphics_name =3D graphics_ip->name;
  	graphics_desc =3D graphics_ip->desc;
@@@ -989,8 -1040,6 +1040,6 @@@
  		xe->info.has_soc_remapper_telem =3D 0;
  	}
 =20
- 	xe_info_probe_tile_count(xe);
-=20
  	for_each_remote_tile(tile, xe, id) {
  		int err;
 =20
@@@ -1049,12 -1098,6 +1098,12 @@@ static void xe_pci_remove(struct pci_de
  		return;
 =20
  	xe_device_remove(xe);
 +
 +	/*
 +	 * Preserve remove-time flush after moving destroy work to module
 +	 * lifetime.
 +	 */
 +	xe_destroy_wq_flush();
  	xe_pm_fini(xe);
  }
 =20
@@@ -1079,9 -1122,11 +1128,11 @@@
   */
  static int xe_pci_probe(struct pci_dev *pdev, const struct pci_device_id =
*ent)
  {
+ 	struct xe_probed_info probed_info =3D {};
  	const struct xe_device_desc *desc =3D (const void *)ent->driver_data;
  	const struct xe_subplatform_desc *subplatform_desc;
  	struct xe_device *xe;
+ 	void *group;
  	int err;
 =20
  	subplatform_desc =3D find_subplatform(desc, pdev->device);
@@@ -1109,6 -1154,11 +1160,11 @@@
  	if (xe_display_driver_probe_defer(pdev))
  		return -EPROBE_DEFER;
 =20
+ 	/* Group all devres so xe_pci_error_slot_reset() can release them as a u=
nit. */
+ 	group =3D devres_open_group(&pdev->dev, NULL, GFP_KERNEL);
+ 	if (!group)
+ 		return -ENOMEM;
+=20
  	err =3D pcim_enable_device(pdev);
  	if (err)
  		return err;
@@@ -1117,13 -1167,19 +1173,19 @@@
  	if (IS_ERR(xe))
  		return PTR_ERR(xe);
 =20
+ 	xe->devres_group =3D group;
+=20
  	pci_set_drvdata(pdev, &xe->drm);
 =20
  	xe_pm_assert_unbounded_bridge(xe);
 =20
  	pci_set_master(pdev);
 =20
- 	err =3D xe_info_init_early(xe, desc, subplatform_desc);
+ 	err =3D xe_probe_info_early(xe, desc, &probed_info);
+ 	if (err)
+ 		return err;
+=20
+ 	err =3D xe_info_init_early(xe, desc, subplatform_desc, &probed_info);
  	if (err)
  		return err;
 =20
@@@ -1142,7 -1198,11 +1204,11 @@@
  	if (err)
  		return err;
 =20
- 	err =3D xe_info_init(xe, desc);
+ 	err =3D xe_probe_info(xe, desc, &probed_info);
+ 	if (err)
+ 		return err;
+=20
+ 	err =3D xe_info_init(xe, desc, &probed_info);
  	if (err)
  		return err;
 =20
@@@ -1355,6 -1415,7 +1421,7 @@@ static struct pci_driver xe_pci_driver=20
  	.remove =3D xe_pci_remove,
  	.shutdown =3D xe_pci_shutdown,
  	.sriov_configure =3D xe_pci_sriov_configure,
+ 	.err_handler =3D &xe_pci_error_handlers,
  #ifdef CONFIG_PM_SLEEP
  	.driver.pm =3D &xe_pm_ops,
  #endif

--oNOYsRe8fP3O4ki8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpeNEcACgkQJNaLcl1U
h9Df5Af/VMY+aMX/7QlVwsyEi9Lv9Q+TzupXqdxlHkrxqMf8UnT5JglTD6XoRfIF
FIFjnv3MJC6U3nql8K/9goczfyS9wU867ZM+jBQyYHlHEVkHLq3Q6yvFJ4eQCddm
SAlHE8hHeTVKx98q2QWnM1A1ZyCbxga5SsqAJjSKevgFzzqnJNWWR1vc5I0y0EkA
3O2SLyxUCSF9BLv5766Y8nk8agrIjf6GSSUNOzov+WXqEPrrF5nf12G463LyZKOW
/ZTtrBlkV2MdLLKJJ50rjaAzN4qQ1n1hfuJLUQ6X58SIwYxO4YjvIoBzg/j0d0O5
IUOoBq/1ZoqwpAGDjt9VUgLibbq6kg==
=dfKP
-----END PGP SIGNATURE-----

--oNOYsRe8fP3O4ki8--
