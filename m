Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBEE606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oh3LENTk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3D4310E7F6;
	Mon, 23 Nov 2026 15:35:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E06310E7F6
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:35:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 49FBF43970;
 Mon, 23 Nov 2026 15:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB52B1F000CA;
 Mon, 23 Nov 2026 15:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795448129;
 bh=nNx2wMYFn1fQ1MN7GWGKuoLGT6ZcJIV1J46wSVAHg6A=;
 h=Date:From:To:Cc:Subject;
 b=Oh3LENTkkw4QTUgN6ICbXaviTOYjkjS4rZzoh/v88KO2LunrjSQ0WBOFrF6zraopa
 F6Pu03exztce1Np6YKLL8OiEZFH51BUcq0ZbHr5YfrJtRUC1Dk3W0lsSiqbjJ/d7h6
 4sW8V6L9OwO/KhNyn+422PKgc2UdUzQBinMhBAuECGMkvQ+Onm5MGCfdZ3u30Hrcn1
 B8dinZqx6MLCAOc8hGQYebCPtSGUGSyYwFbS3DUYrrGEkXzGlV7HhuShrHZNaDmDAM
 e2WMqOt+kF4jouY6/E77eN0JODb7UTNszLY7QfivKv+5Oabva5Oid5W7oXEWXgFr4k
 8Amnvz/3T296g==
Date: Mon, 23 Nov 2026 15:35:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Badal Nilawar <badal.nilawar@intel.com>,
 Daniel Charles <daniel.charles@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>, Raag Jadav <raag.jadav@intel.com>,
 Riana Tauro <riana.tauro@intel.com>,
 Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <awRdPKox0-8OAIG4@sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LPbiKUmi7y/CYtNZ"
Content-Disposition: inline
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--LPbiKUmi7y/CYtNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got conflicts in:

  drivers/gpu/drm/xe/xe_hw_error.c
  drivers/gpu/drm/xe/xe_pm.c

between commits:

  a890a885b982f ("drm/xe/hw_error: Guard csc_hw_error_work() with runtime P=
M")
  fc0ba46fd8278 ("drm/xe: Access GT MMIO after pcode init")
  a17c5ed0dc715 ("drm/xe/pm: Apply tile workarounds after PCODE initializat=
ion")

=66rom the origin tree and commits:

  323047eeee980 ("drm/xe: Separate drm-ras netlink data from device and fir=
mware RAS state")
  fc8d229d76102 ("drm/xe/hw_error: Guard csc_hw_error_work() with runtime P=
M")
  638d116d755ed ("drm/xe: Access GT MMIO after pcode init")
  1f6ac7c86aa52 ("drm/xe: Memset g2g buffer on resume")
  6569aa6628799 ("drm/xe/xe_late_bind_fw: Refactor pm flow")
  641ffb2132839 ("drm/xe/pm: Apply tile workarounds after PCODE initializat=
ion")
  be082ef8157b7 ("drm/xe/pm: skip BO eviction on iGPU for non-hibernation s=
leep")
  3541c71284fa8 ("drm/xe/hw_error: Reuse CSC worker for generic error handl=
ing")
  14bbd417a6e0f ("drm/xe/hw_error: Initialize hw_error_work per tile")
  b6bd6c613fd5e ("drm/xe: Add support for wa_14028434957")
  ff03d9510426e ("drm/xe/pm: Introduce xe_device_suspend/resume()")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/xe/xe_hw_error.c
index f726179c22e38,86b29f2828374..0000000000000
--- a/drivers/gpu/drm/xe/xe_hw_error.c
+++ b/drivers/gpu/drm/xe/xe_hw_error.c
@@@ -5,6 -5,8 +5,8 @@@
 =20
  #include <linux/bitmap.h>
 =20
+ #include <generated/xe_device_wa_oob.h>
+=20
  #include "regs/xe_gsc_regs.h"
  #include "regs/xe_hw_error_regs.h"
  #include "regs/xe_irq_regs.h"
@@@ -15,7 -17,11 +17,11 @@@
  #include "xe_hw_error.h"
  #include "xe_mmio.h"
  #include "xe_pm.h"
+ #include "xe_ras.h"
  #include "xe_survivability_mode.h"
+ #include "xe_wa.h"
+ #include "xe_wedge.h"
+=20
 =20
  #define GT_HW_ERROR_MAX_ERR_BITS		16
  #define HEC_UNCORR_FW_ERR_BITS			4
@@@ -166,12 -172,29 +172,29 @@@ static_assert(ARRAY_SIZE(pvc_master_loc
  						 pvc_master_local_fatal_err_reg : \
  						 pvc_master_local_nonfatal_err_reg)
 =20
- static void csc_hw_error_work(struct work_struct *work)
+ static void hw_error_work(struct work_struct *work)
  {
- 	struct xe_tile *tile =3D container_of(work, typeof(*tile), csc_hw_error_=
work);
+ 	struct xe_tile *tile =3D container_of(work, typeof(*tile), hw_error_work=
);
  	struct xe_device *xe =3D tile_to_xe(tile);
 =20
+ 	/* Skip hw error processing if device is already wedged */
+ 	if (xe_wedged(xe))
+ 		return;
+=20
  	guard(xe_pm_runtime)(xe);
+=20
+ 	if (xe->info.has_sysctrl && XE_DEVICE_WA(xe, 14028434957)) {
+ 		/*
+ 		 * Skip handling if an uncorrectable internal error is reported as
+ 		 * reset is imminent
+ 		 */
+ 		if (xe_ras_is_aer_internal_error(xe))
+ 			return;
+=20
+ 		xe_ras_process_errors(xe);
+ 		return;
+ 	}
+=20
  	xe_survivability_mode_runtime_enable(xe);
  }
 =20
@@@ -204,7 -227,7 +227,7 @@@ static void csc_hw_error_handler(struc
  					     hec_uncorrected_fw_errors[err_bit], severity_str,
  					     err_bit);
 =20
- 			schedule_work(&tile->csc_hw_error_work);
+ 			schedule_work(&tile->hw_error_work);
  		}
  	}
 =20
@@@ -242,7 -265,7 +265,7 @@@ static void log_soc_error(struct xe_til
  {
  	const char *severity_str =3D error_severity[severity];
  	struct xe_device *xe =3D tile_to_xe(tile);
- 	struct xe_drm_ras *ras =3D &xe->ras;
+ 	struct xe_drm_ras *ras =3D &xe->ras.nl_data;
  	struct xe_drm_ras_counter *info =3D ras->info[severity];
  	const char *name;
 =20
@@@ -262,7 -285,7 +285,7 @@@ static void gt_hw_error_handler(struct=20
  {
  	const enum drm_xe_ras_error_severity severity =3D hw_err_to_severity(hw_=
err);
  	struct xe_device *xe =3D tile_to_xe(tile);
- 	struct xe_drm_ras *ras =3D &xe->ras;
+ 	struct xe_drm_ras *ras =3D &xe->ras.nl_data;
  	struct xe_drm_ras_counter *info =3D ras->info[severity];
  	struct xe_mmio *mmio =3D &tile->mmio;
  	unsigned long err_stat =3D 0;
@@@ -424,7 -447,7 +447,7 @@@ static void hw_error_source_handler(str
  	const enum drm_xe_ras_error_severity severity =3D hw_err_to_severity(hw_=
err);
  	const char *severity_str =3D error_severity[severity];
  	struct xe_device *xe =3D tile_to_xe(tile);
- 	struct xe_drm_ras *ras =3D &xe->ras;
+ 	struct xe_drm_ras *ras =3D &xe->ras.nl_data;
  	struct xe_drm_ras_counter *info =3D ras->info[severity];
  	unsigned long flags, err_src;
  	u32 err_bit;
@@@ -433,12 -456,12 +456,12 @@@
  		return;
 =20
  	/*
- 	 * Hardware errors are reported through System Controller on the platfor=
ms that
- 	 * support it, and never routed as direct IRQ to SGUnit. So we should ne=
ver be
- 	 * here for those platforms.
+ 	 * Non-fatal errors are routed as a direct IRQ on platforms that support
+ 	 * system controller.
  	 */
  	if (xe->info.has_sysctrl) {
- 		drm_err_ratelimited(&xe->drm, HW_ERR "Invalid error routing\n");
+ 		drm_err_ratelimited(&xe->drm, HW_ERR "Non-fatal %s reported\n", severit=
y_str);
+ 		schedule_work(&tile->hw_error_work);
  		return;
  	}
 =20
@@@ -513,7 -536,7 +536,7 @@@ void xe_hw_error_irq_handler(struct xe_
  	enum hardware_error hw_err;
 =20
  	if (xe_fault_csc_hw_error())
- 		schedule_work(&tile->csc_hw_error_work);
+ 		schedule_work(&tile->hw_error_work);
 =20
  	for (hw_err =3D 0; hw_err < HARDWARE_ERROR_MAX; hw_err++) {
  		if (master_ctl & ERROR_IRQ(hw_err))
@@@ -537,6 -560,25 +560,25 @@@ static void process_hw_errors(struct xe
  	}
  }
 =20
+ /**
+  * xe_hw_error_work_disable - Disable hw error work
+  * @arg: xe device instance
+  *
+  * This function disables work for hardware error handling for all tiles.
+  */
+ void xe_hw_error_work_disable(void *arg)
+ {
+ 	struct xe_device *xe =3D arg;
+ 	struct xe_tile *tile;
+ 	u8 id;
+=20
+ 	if (!IS_DGFX(xe) || IS_SRIOV_VF(xe))
+ 		return;
+=20
+ 	for_each_tile(tile, xe, id)
+ 		disable_work_sync(&tile->hw_error_work);
+ }
+=20
  /**
   * xe_hw_error_init - Initialize hw errors
   * @xe: xe device instance
@@@ -546,12 -588,15 +588,15 @@@
   */
  void xe_hw_error_init(struct xe_device *xe)
  {
- 	struct xe_tile *tile =3D xe_device_get_root_tile(xe);
+ 	struct xe_tile *tile;
+ 	u8 id;
 =20
  	if (!IS_DGFX(xe) || IS_SRIOV_VF(xe))
  		return;
 =20
- 	INIT_WORK(&tile->csc_hw_error_work, csc_hw_error_work);
+ 	for_each_tile(tile, xe, id)
+ 		INIT_WORK(&tile->hw_error_work, hw_error_work);
 =20
  	process_hw_errors(xe);
+ 	devm_add_action_or_reset(xe->drm.dev, xe_hw_error_work_disable, xe);
  }
diff --combined drivers/gpu/drm/xe/xe_pm.c
index d95f0d128ed49,f73f68bd449b8..0000000000000
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@@ -167,59 -167,38 +167,38 @@@ static void xe_rpm_lockmap_release(cons
  }
 =20
  /**
-  * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle
+  * xe_pm_needs_bo_evict() - Check if bo eviction is needed
+  * @xe: The xe device.
+  * @hibernate: Hibernation event
+  *
+  * Return: %true if bo eviction is needed, %false otherwise.
+  */
+ bool xe_pm_needs_bo_evict(struct xe_device *xe, bool hibernate)
+ {
+ 	return IS_DGFX(xe) || hibernate;
+ }
+=20
+ /**
+  * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle / =
S0->S4
   * @xe: xe device instance
+  * @hibernate: true if preparing for S4 hibernation, false for < S4 suspe=
nd
   *
   * Return: 0 on success
   */
- int xe_pm_suspend(struct xe_device *xe)
+ int xe_pm_suspend(struct xe_device *xe, bool hibernate)
  {
- 	struct xe_gt *gt;
- 	u8 id;
  	int err;
 =20
  	drm_dbg(&xe->drm, "Suspending device\n");
  	xe_pm_block_begin_signalling();
  	trace_xe_pm_suspend(xe, __builtin_return_address(0));
 =20
- 	err =3D xe_pxp_pm_suspend(xe->pxp);
+ 	err =3D xe_device_suspend(xe, hibernate, false);
  	if (err)
- 		goto err;
+ 		drm_dbg(&xe->drm, "Device suspend failed %d\n", err);
+ 	else
+ 		drm_dbg(&xe->drm, "Device suspended\n");
 =20
- 	xe_late_bind_wait_for_worker_completion(&xe->late_bind);
-=20
- 	for_each_gt(gt, xe, id)
- 		xe_gt_suspend_prepare(gt);
-=20
- 	xe_display_pm_suspend(xe);
-=20
- 	/* FIXME: Super racey... */
- 	err =3D xe_bo_evict_all(xe);
- 	if (err)
- 		goto err_display;
-=20
- 	for_each_gt(gt, xe, id) {
- 		err =3D xe_gt_suspend(gt);
- 		if (err)
- 			goto err_display;
- 	}
-=20
- 	xe_irq_suspend(xe);
-=20
- 	xe_display_pm_suspend_late(xe);
-=20
- 	xe_i2c_pm_suspend(xe);
-=20
- 	drm_dbg(&xe->drm, "Device suspended\n");
- 	xe_pm_block_end_signalling();
-=20
- 	return 0;
-=20
- err_display:
- 	xe_display_pm_resume(xe);
- 	xe_pxp_pm_resume(xe->pxp);
- err:
- 	drm_dbg(&xe->drm, "Device suspend failed %d\n", err);
  	xe_pm_block_end_signalling();
  	return err;
  }
@@@ -232,71 -211,18 +211,18 @@@
   */
  int xe_pm_resume(struct xe_device *xe)
  {
- 	struct xe_tile *tile;
- 	struct xe_gt *gt;
- 	u8 id;
  	int err;
 =20
  	xe_pm_block_begin_signalling();
  	drm_dbg(&xe->drm, "Resuming device\n");
  	trace_xe_pm_resume(xe, __builtin_return_address(0));
 =20
- 	err =3D xe_pcode_ready(xe, true);
+ 	err =3D xe_device_resume(xe, false);
  	if (err)
- 		return err;
+ 		drm_dbg(&xe->drm, "Device resume failed %d\n", err);
+ 	else
+ 		drm_dbg(&xe->drm, "Device resumed\n");
 =20
- 	for_each_tile(tile, xe, id)
- 		xe_wa_apply_tile_workarounds(tile);
-=20
- 	for_each_gt(gt, xe, id)
- 		xe_gt_idle_disable_c6(gt);
-=20
- 	xe_display_pm_resume_early(xe);
-=20
- 	/*
- 	 * This only restores pinned memory which is the memory required for the
- 	 * GT(s) to resume.
- 	 */
- 	err =3D xe_bo_restore_early(xe);
- 	if (err)
- 		goto err;
-=20
- 	xe_i2c_pm_resume(xe, true);
-=20
- 	xe_sysctrl_pm_resume(xe);
-=20
- 	xe_irq_resume(xe);
-=20
- 	for_each_gt(gt, xe, id) {
- 		err =3D xe_gt_resume(gt);
- 		if (err)
- 			break;
- 	}
-=20
- 	/*
- 	 * Try to bring up display before bailing from GT resume failure,
- 	 * so we don't leave the user clueless with a blank screen.
- 	 */
- 	xe_display_pm_resume(xe);
- 	if (err)
- 		goto err;
-=20
- 	err =3D xe_bo_restore_late(xe);
- 	if (err)
- 		goto err;
-=20
- 	xe_pxp_pm_resume(xe->pxp);
-=20
- 	if (IS_VF_CCS_READY(xe))
- 		xe_sriov_vf_ccs_register_context(xe);
-=20
- 	xe_late_bind_fw_load(&xe->late_bind);
-=20
- 	drm_dbg(&xe->drm, "Device resumed\n");
- 	xe_pm_block_end_signalling();
- 	return 0;
- err:
- 	drm_dbg(&xe->drm, "Device resume failed %d\n", err);
  	xe_pm_block_end_signalling();
  	return err;
  }
@@@ -461,6 -387,9 +387,9 @@@ static int xe_pm_notifier_callback(stru
  		struct xe_validation_ctx ctx;
 =20
  		reinit_completion(&xe->pm_block);
+ 		if (!xe_pm_needs_bo_evict(xe, action =3D=3D PM_HIBERNATION_PREPARE))
+ 			break;
+=20
  		xe_pm_block_begin_signalling();
  		xe_pm_runtime_get(xe);
  		(void)xe_validation_ctx_init(&ctx, &xe->val, NULL,
@@@ -485,6 -414,9 +414,9 @@@
  	case PM_POST_SUSPEND:
  		complete_all(&xe->pm_block);
  		xe_pm_wake_rebind_workers(xe);
+ 		if (!xe_pm_needs_bo_evict(xe, action =3D=3D PM_POST_HIBERNATION))
+ 			break;
+=20
  		xe_bo_notifier_unprepare_all_pinned(xe);
  		xe_pm_runtime_put(xe);
  		break;
@@@ -707,7 -639,7 +639,7 @@@ int xe_pm_runtime_resume(struct xe_devi
  			xe_wa_apply_tile_workarounds(tile);
 =20
  		for_each_gt(gt, xe, id)
- 			xe_gt_idle_disable_c6(gt);
+ 			xe_gt_resume_early(gt);
 =20
  		xe_display_pm_resume_early(xe);
 =20
@@@ -755,7 -687,7 +687,7 @@@
  		xe_sriov_vf_ccs_register_context(xe);
 =20
  	if (xe->d3cold.allowed)
- 		xe_late_bind_fw_load(&xe->late_bind);
+ 		xe_late_bind_pm_resume(&xe->late_bind);
 =20
  out:
  	xe_rpm_lockmap_release(xe);

--LPbiKUmi7y/CYtNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsEXTsACgkQJNaLcl1U
h9CBVgf/fGKEWnH97cLs3Y0l4Say61s/rgzUvyPYulSEv8EbCxA5oRsj/CuDGGm/
78uUzWYhrfYtCuUEoFtjtmFJPJ5SCWJDCW+LwfaH69FUu0wPaA0ZHd9Q1+hCB5Eg
+i8JGhJ6OBVPl9D/t16gB3RtQVKmYetB2kp5meZrpxg3pEHESmb/ty2ykfx4jFj0
b8eFMF5wUeRSf3rD8fg3D/eOpuIPyhpklBSOjvK+BjiBWG1VB+0fYRwip6UK+yQ1
S4W9uQRbWU+Is4kyz3hpRKJyN0ejLL5o5iiLBIy9Bx5m19d26syAveZhrZeY1Ywn
bNlxRS5UeiP/u+NJukYEkkNGt9LKkw==
=s60T
-----END PGP SIGNATURE-----

--LPbiKUmi7y/CYtNZ--
