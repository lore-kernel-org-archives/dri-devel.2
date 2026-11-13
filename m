Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81395606AE3E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ou9UlLra
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B743B112684;
	Fri, 13 Nov 2026 16:16:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D53F210EC47;
 Fri, 13 Nov 2026 16:16:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F22046830;
 Fri, 13 Nov 2026 16:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD991F000C5;
 Fri, 13 Nov 2026 16:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794586612;
 bh=CVtKY2baAFqQRZbKIAhuVTcQeg51Dsb2Tf0U1oZ+Jro=;
 h=Date:From:To:Cc:Subject;
 b=ou9UlLra4LK+xJLE/zAyTNqUJTN29nb19guDGIaorpNjG7Yg41XCOF26QNTvepmcJ
 XzJn03IadGfZcWNl5WsW/z3Nc5+4sHoWXsWendDUDEOHjuPqQIvsgIhyU17Wo5hkCX
 GcMwc1+EBRMv3i/iTMzf+HLSo52CXKhDiCgsNsruntVpiLi+d6WOAxdzcN4lFxg20A
 uIEzdaTDyZ3HLCb9LedBOV6wfJy1N7+Oj0bnUh3XPIoyn2B/LmZcSiEY4kIEuV6L8d
 DcYy7BWVFLzb1rmQbRNRM/Z2tkT26t8vcmyfJBpSRVu5olldaKBLtY2QMAV9m38MGw
 v9tMLMSjpRqFg==
Date: Fri, 13 Nov 2026 16:16:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 DRM XE List <intel-xe@lists.freedesktop.org>
Cc: Daniel Charles <daniel.charles@intel.com>,
 Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>, Raag Jadav <raag.jadav@intel.com>,
 Riana Tauro <riana.tauro@intel.com>,
 Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
 Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Subject: linux-next: manual merge of the drm-xe tree with the drm-fixes tree
Message-ID: <avc376Z6nj4HlOnJ@sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XMSiqA4Qoh9OzPbI"
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--XMSiqA4Qoh9OzPbI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-xe tree got conflicts in:

  drivers/gpu/drm/xe/xe_lmtt.c
  drivers/gpu/drm/xe/xe_pm.c

between commits:

  fc0ba46fd8278 ("drm/xe: Access GT MMIO after pcode init")
  a17c5ed0dc715 ("drm/xe/pm: Apply tile workarounds after PCODE initializat=
ion")
  3654a4d734df9 ("drm/xe/pf: Program LMTT directory pointer from each GT's =
init path")

=66rom the drm-fixes tree and commits:

  641ffb2132839 ("drm/xe/pm: Apply tile workarounds after PCODE initializat=
ion")
  a8653bee6a040 ("drm/xe/pf: Program LMTT directory pointer from each GT's =
init path")
  c9edd9cf7e613 ("drm/xe/pf: Use multicast writes for early-generation LMTT=
 config")
  be082ef8157b7 ("drm/xe/pm: skip BO eviction on iGPU for non-hibernation s=
leep")
  ff03d9510426e ("drm/xe/pm: Introduce xe_device_suspend/resume()")

=66rom the drm-xe tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --git a/drivers/gpu/drm/xe/xe_lmtt.c b/drivers/gpu/drm/xe/xe_lmtt.c
index 8fba3c01fac29..ea2a3eeefccd7 100644
--- a/drivers/gpu/drm/xe/xe_lmtt.c
+++ b/drivers/gpu/drm/xe/xe_lmtt.c
@@ -220,14 +220,8 @@ static void lmtt_setup_dir_ptr_gt(struct xe_gt *gt, u3=
2 config)
 	struct xe_reg reg;
 	u32 val_read;
=20
-	if (GRAPHICS_VER(xe) < 20) {
-		reg =3D LMEM_CFG;
-		xe_mmio_write32(&gt->mmio, reg, config);
-		return;
-	}
-
 	if (xe_gt_is_main_type(gt)) {
-		reg_mcr =3D XE2_LMEM_CFG_MCR;
+		reg_mcr =3D GRAPHICS_VER(xe) < 20 ? LMEM_CFG_MCR : XE2_LMEM_CFG_MCR;
 		xe_gt_mcr_multicast_write(gt, reg_mcr, config);
 		val_read =3D xe_gt_mcr_unicast_read_any(gt, reg_mcr);
 		xe_gt_assert_msg(gt, val_read =3D=3D config, "LMEM_CFG_MCR: %#x !=3D %#x=
\n",
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 61d68c09189f7..f73f68bd449b8 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -167,59 +167,38 @@ static void xe_rpm_lockmap_release(const struct xe_de=
vice *xe)
 }
=20
 /**
- * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle
+ * xe_pm_needs_bo_evict() - Check if bo eviction is needed
+ * @xe: The xe device.
+ * @hibernate: Hibernation event
+ *
+ * Return: %true if bo eviction is needed, %false otherwise.
+ */
+bool xe_pm_needs_bo_evict(struct xe_device *xe, bool hibernate)
+{
+	return IS_DGFX(xe) || hibernate;
+}
+
+/**
+ * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle / S=
0->S4
  * @xe: xe device instance
+ * @hibernate: true if preparing for S4 hibernation, false for < S4 suspend
  *
  * Return: 0 on success
  */
-int xe_pm_suspend(struct xe_device *xe)
+int xe_pm_suspend(struct xe_device *xe, bool hibernate)
 {
-	struct xe_gt *gt;
-	u8 id;
 	int err;
=20
 	drm_dbg(&xe->drm, "Suspending device\n");
 	xe_pm_block_begin_signalling();
 	trace_xe_pm_suspend(xe, __builtin_return_address(0));
=20
-	err =3D xe_pxp_pm_suspend(xe->pxp);
+	err =3D xe_device_suspend(xe, hibernate, false);
 	if (err)
-		goto err;
+		drm_dbg(&xe->drm, "Device suspend failed %d\n", err);
+	else
+		drm_dbg(&xe->drm, "Device suspended\n");
=20
-	xe_late_bind_pm_suspend(&xe->late_bind);
-
-	for_each_gt(gt, xe, id)
-		xe_gt_suspend_prepare(gt);
-
-	xe_display_pm_suspend(xe);
-
-	/* FIXME: Super racey... */
-	err =3D xe_bo_evict_all(xe);
-	if (err)
-		goto err_display;
-
-	for_each_gt(gt, xe, id) {
-		err =3D xe_gt_suspend(gt);
-		if (err)
-			goto err_display;
-	}
-
-	xe_irq_suspend(xe);
-
-	xe_display_pm_suspend_late(xe);
-
-	xe_i2c_pm_suspend(xe);
-
-	drm_dbg(&xe->drm, "Device suspended\n");
-	xe_pm_block_end_signalling();
-
-	return 0;
-
-err_display:
-	xe_display_pm_resume(xe);
-	xe_pxp_pm_resume(xe->pxp);
-err:
-	drm_dbg(&xe->drm, "Device suspend failed %d\n", err);
 	xe_pm_block_end_signalling();
 	return err;
 }
@@ -232,71 +211,18 @@ int xe_pm_suspend(struct xe_device *xe)
  */
 int xe_pm_resume(struct xe_device *xe)
 {
-	struct xe_tile *tile;
-	struct xe_gt *gt;
-	u8 id;
 	int err;
=20
 	xe_pm_block_begin_signalling();
 	drm_dbg(&xe->drm, "Resuming device\n");
 	trace_xe_pm_resume(xe, __builtin_return_address(0));
=20
-	err =3D xe_pcode_ready(xe, true);
+	err =3D xe_device_resume(xe, false);
 	if (err)
-		return err;
+		drm_dbg(&xe->drm, "Device resume failed %d\n", err);
+	else
+		drm_dbg(&xe->drm, "Device resumed\n");
=20
-	for_each_tile(tile, xe, id)
-		xe_wa_apply_tile_workarounds(tile);
-
-	for_each_gt(gt, xe, id)
-		xe_gt_resume_early(gt);
-
-	xe_display_pm_resume_early(xe);
-
-	/*
-	 * This only restores pinned memory which is the memory required for the
-	 * GT(s) to resume.
-	 */
-	err =3D xe_bo_restore_early(xe);
-	if (err)
-		goto err;
-
-	xe_i2c_pm_resume(xe, true);
-
-	xe_sysctrl_pm_resume(xe);
-
-	xe_irq_resume(xe);
-
-	for_each_gt(gt, xe, id) {
-		err =3D xe_gt_resume(gt);
-		if (err)
-			break;
-	}
-
-	/*
-	 * Try to bring up display before bailing from GT resume failure,
-	 * so we don't leave the user clueless with a blank screen.
-	 */
-	xe_display_pm_resume(xe);
-	if (err)
-		goto err;
-
-	err =3D xe_bo_restore_late(xe);
-	if (err)
-		goto err;
-
-	xe_pxp_pm_resume(xe->pxp);
-
-	if (IS_VF_CCS_READY(xe))
-		xe_sriov_vf_ccs_register_context(xe);
-
-	xe_late_bind_pm_resume(&xe->late_bind);
-
-	drm_dbg(&xe->drm, "Device resumed\n");
-	xe_pm_block_end_signalling();
-	return 0;
-err:
-	drm_dbg(&xe->drm, "Device resume failed %d\n", err);
 	xe_pm_block_end_signalling();
 	return err;
 }
@@ -461,6 +387,9 @@ static int xe_pm_notifier_callback(struct notifier_bloc=
k *nb,
 		struct xe_validation_ctx ctx;
=20
 		reinit_completion(&xe->pm_block);
+		if (!xe_pm_needs_bo_evict(xe, action =3D=3D PM_HIBERNATION_PREPARE))
+			break;
+
 		xe_pm_block_begin_signalling();
 		xe_pm_runtime_get(xe);
 		(void)xe_validation_ctx_init(&ctx, &xe->val, NULL,
@@ -485,6 +414,9 @@ static int xe_pm_notifier_callback(struct notifier_bloc=
k *nb,
 	case PM_POST_SUSPEND:
 		complete_all(&xe->pm_block);
 		xe_pm_wake_rebind_workers(xe);
+		if (!xe_pm_needs_bo_evict(xe, action =3D=3D PM_POST_HIBERNATION))
+			break;
+
 		xe_bo_notifier_unprepare_all_pinned(xe);
 		xe_pm_runtime_put(xe);
 		break;

--XMSiqA4Qoh9OzPbI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr3N+4ACgkQJNaLcl1U
h9BLqAf/a3VOhfxKmfNmCvWN2ecgw9zW1XzW85UjqSaB8G+zpEtW4dYS6Z1nfuoi
uKQfq5WhY/uibOk++SEfu7ImvrcesgyeIiyfKyud1NZOU9gHtjqBLY6QNmoEdrbY
QizOViLZzd/2EdDSnSrxvK8CfVvbhBPiQHrm58s1Dh54f3IGCQZZsWL7XU5Kdblv
vjt7r0ukVD0amxvJOqisObSOhRhLFBtfzLbaDLHhiirkB7TdmMwgVjq6yg1YPS1+
Z4Cx4E1FVDPm/NAQamngiBzyosfZGK/M+4RIKkqB41f9uv3QJ3FfYfWmcCe2W2GZ
LNtT6dfWmMA28P9x/UTgh2IwQAwvmg==
=+BY7
-----END PGP SIGNATURE-----

--XMSiqA4Qoh9OzPbI--
