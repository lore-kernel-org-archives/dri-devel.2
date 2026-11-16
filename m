Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E678606B07E
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WuBgkW7H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74EF310E34E;
	Mon, 16 Nov 2026 19:06:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F279910E34E
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 19:06:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ACA0540B2C;
 Mon, 16 Nov 2026 19:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA1A1F000C4;
 Mon, 16 Nov 2026 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794855997;
 bh=Dj+i9Txau6O4tBsHZjW1TYuRB/tYQJZ/8C2VHdsjpYU=;
 h=Date:From:To:Cc:Subject;
 b=WuBgkW7HU5oJsCmVtFOIbUN27M/v9C9i4r7WniXZ0kDV5t3+Wo9ixoULU9K1dtLhb
 AAmeDOlHWuwYg1VDxBr+gl1paOrR667uMZlV6mmoWQzmLz07OyGsagIYK3Rz2ECLh0
 Jd8XdDBoyC7bfTW6iKTI+WVxQaJ2kB5SgE7KTdrgxV6YOBglBK3O4ZsAPbLQ2AaY5R
 EasR92eHRVoadYSJBF+QYYQNAfCtrq9EhJpjcOFO33ZsywHj0Swcu9ugAWPS/p5J8+
 CUzqcCoZmAmKCy8AarqzGhE62/1xXlPv2ekC3qjOVg3DUi88UIa35093VFzPV+tQsk
 XyoFLaM2sIW4Q==
Date: Mon, 16 Nov 2026 19:06:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <avtUOSIWVojTuTvx@sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q0og5S7UwvY1pqPE"
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


--Q0og5S7UwvY1pqPE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got conflicts in:

  drivers/gpu/drm/xe/xe_pci.c
  drivers/gpu/drm/xe/xe_pm.c

between commit:

???

=66rom the drm-fixes tree and commit:

???

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 12ff5c9025478..3bd68ed9daa81 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -417,16 +417,17 @@ static const struct xe_device_desc bmg_desc =3D {
 	.dma_mask_size =3D 46,
 	.has_display =3D true,
 	.has_fan_control =3D true,
+	.has_fixed_vram_channels =3D true,
 	.has_flat_ccs =3D 1,
 	.has_mbx_power_limits =3D true,
 	.has_mbx_thermal_info =3D true,
 	.has_gsc_nvm =3D 1,
 	.has_heci_cscfi =3D 1,
 	.has_i2c =3D true,
-	.has_late_bind =3D true,
 	.has_pre_prod_wa =3D 1,
 	.has_soc_remapper_telem =3D true,
 	.has_sriov =3D true,
+	.late_bind_mask =3D BIT(XE_LB_FW_FAN_CONTROL),
 	.max_gt_per_tile =3D 2,
 	MULTI_LRC_MASK,
 	.needs_scratch =3D true,
@@ -487,6 +488,8 @@ static const struct xe_device_desc cri_desc =3D {
 	.has_sriov =3D true,
 	.has_sysctrl =3D true,
 	.has_temp_sentinel =3D true,
+	.late_bind_mask =3D BIT(XE_LB_FW_FAN_CONTROL) |
+			  BIT(XE_LB_FW_OCODE),
 	.max_gt_per_tile =3D 2,
 	MULTI_LRC_MASK,
 	.require_force_probe =3D true,
@@ -722,8 +725,9 @@ static int handle_gmdid(struct xe_device *xe,
=20
 	*graphics_ip =3D find_graphics_ip(ver);
 	if (!*graphics_ip) {
-		drm_err(&xe->drm, "Hardware reports unknown graphics version %u.%02u\n",
-			ver / 100, ver % 100);
+		xe_log_err(xe, REGS, -EINVAL,
+			   "Hardware reports unknown graphics version %u.%02u\n",
+			   ver / 100, ver % 100);
 	}
=20
 	ret =3D read_gmdid(xe, GMDID_MEDIA, &ver, media_revid);
@@ -736,8 +740,9 @@ static int handle_gmdid(struct xe_device *xe,
=20
 	*media_ip =3D find_media_ip(ver);
 	if (!*media_ip) {
-		drm_err(&xe->drm, "Hardware reports unknown media version %u.%02u\n",
-			ver / 100, ver % 100);
+		xe_log_err(xe, REGS, -EINVAL,
+			   "Hardware reports unknown media version %u.%02u\n",
+			   ver / 100, ver % 100);
 	}
=20
 	return 0;
@@ -798,6 +803,7 @@ static int xe_info_init_early(struct xe_device *xe,
 	xe->info.has_device_uid =3D desc->has_device_uid;
 	xe->info.has_drm_ras =3D desc->has_drm_ras;
 	xe->info.has_fan_control =3D desc->has_fan_control;
+	xe->info.has_fixed_vram_channels =3D desc->has_fixed_vram_channels;
 	/* runtime fusing may force flat_ccs to disabled later */
 	xe->info.has_flat_ccs =3D desc->has_flat_ccs;
 	xe->info.has_mbx_power_limits =3D desc->has_mbx_power_limits;
@@ -806,7 +812,6 @@ static int xe_info_init_early(struct xe_device *xe,
 	xe->info.has_heci_gscfi =3D desc->has_heci_gscfi;
 	xe->info.has_heci_cscfi =3D desc->has_heci_cscfi;
 	xe->info.has_i2c =3D desc->has_i2c;
-	xe->info.has_late_bind =3D desc->has_late_bind;
 	xe->info.has_llc =3D desc->has_llc;
 	xe->info.has_mert =3D desc->has_mert;
 	xe->info.has_page_reclaim_hw_assist =3D desc->has_page_reclaim_hw_assist;
@@ -819,11 +824,13 @@ static int xe_info_init_early(struct xe_device *xe,
 		desc->has_sriov;
 	xe->info.has_sysctrl =3D desc->has_sysctrl;
 	xe->info.has_temp_sentinel =3D desc->has_temp_sentinel;
+	xe->info.require_force_probe =3D desc->require_force_probe;
 	xe->info.skip_guc_pc =3D desc->skip_guc_pc;
 	xe->info.skip_pcode =3D desc->skip_pcode;
 	xe->info.needs_scratch =3D desc->needs_scratch;
 	xe->info.needs_shared_vf_gt_wq =3D desc->needs_shared_vf_gt_wq;
 	xe->info.multi_lrc_mask =3D desc->multi_lrc_mask;
+	xe->info.late_bind_mask =3D desc->late_bind_mask;
=20
 	xe->info.probe_display =3D IS_ENABLED(CONFIG_DRM_XE_DISPLAY) &&
 				 xe_modparam.probe_display &&
@@ -1328,7 +1335,7 @@ static void d3cold_toggle(struct pci_dev *pdev, enum =
toggle_d3cold toggle)
 	}
 }
=20
-static int xe_pci_suspend(struct device *dev)
+static int __xe_pci_suspend(struct device *dev, bool hibernate)
 {
 	struct pci_dev *pdev =3D to_pci_dev(dev);
 	struct xe_device *xe =3D pdev_to_xe_device(pdev);
@@ -1337,7 +1344,7 @@ static int xe_pci_suspend(struct device *dev)
 	if (xe_survivability_mode_is_boot_enabled(xe))
 		return -EBUSY;
=20
-	err =3D xe_pm_suspend(xe);
+	err =3D xe_pm_suspend(xe, hibernate);
 	if (err)
 		return err;
=20
@@ -1355,6 +1362,16 @@ static int xe_pci_suspend(struct device *dev)
 	return 0;
 }
=20
+static int xe_pci_suspend(struct device *dev)
+{
+	return __xe_pci_suspend(dev, false);
+}
+
+static int xe_pci_freeze(struct device *dev)
+{
+	return __xe_pci_suspend(dev, true);
+}
+
 static int xe_pci_resume(struct device *dev)
 {
 	struct pci_dev *pdev =3D to_pci_dev(dev);
@@ -1484,7 +1501,12 @@ static int xe_pci_runtime_idle(struct device *dev)
 }
=20
 static const struct dev_pm_ops xe_pm_ops =3D {
-	SET_SYSTEM_SLEEP_PM_OPS(xe_pci_suspend, xe_pci_resume)
+	.suspend =3D pm_sleep_ptr(xe_pci_suspend),
+	.resume =3D pm_sleep_ptr(xe_pci_resume),
+	.freeze =3D pm_sleep_ptr(xe_pci_freeze),
+	.thaw =3D pm_sleep_ptr(xe_pci_resume),
+	.poweroff =3D pm_sleep_ptr(xe_pci_suspend),
+	.restore =3D pm_sleep_ptr(xe_pci_resume),
 	SET_RUNTIME_PM_OPS(xe_pci_runtime_suspend, xe_pci_runtime_resume, xe_pci_=
runtime_idle)
 };
 #endif
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index d95f0d128ed49..e73192b03074a 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -166,13 +166,19 @@ static void xe_rpm_lockmap_release(const struct xe_de=
vice *xe)
 			 &xe_pm_runtime_d3cold_map);
 }
=20
+static bool xe_pm_needs_bo_evict(struct xe_device *xe, bool hibernate)
+{
+	return IS_DGFX(xe) || hibernate;
+}
+
 /**
- * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle
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
 	struct xe_gt *gt;
 	u8 id;
@@ -186,17 +192,19 @@ int xe_pm_suspend(struct xe_device *xe)
 	if (err)
 		goto err;
=20
-	xe_late_bind_wait_for_worker_completion(&xe->late_bind);
+	xe_late_bind_pm_suspend(&xe->late_bind);
=20
 	for_each_gt(gt, xe, id)
 		xe_gt_suspend_prepare(gt);
=20
 	xe_display_pm_suspend(xe);
=20
-	/* FIXME: Super racey... */
-	err =3D xe_bo_evict_all(xe);
-	if (err)
-		goto err_display;
+	if (xe_pm_needs_bo_evict(xe, hibernate)) {
+		/* FIXME: Super racey... */
+		err =3D xe_bo_evict_all(xe);
+		if (err)
+			goto err_display;
+	}
=20
 	for_each_gt(gt, xe, id) {
 		err =3D xe_gt_suspend(gt);
@@ -249,7 +257,7 @@ int xe_pm_resume(struct xe_device *xe)
 		xe_wa_apply_tile_workarounds(tile);
=20
 	for_each_gt(gt, xe, id)
-		xe_gt_idle_disable_c6(gt);
+		xe_gt_resume_early(gt);
=20
 	xe_display_pm_resume_early(xe);
=20
@@ -290,7 +298,7 @@ int xe_pm_resume(struct xe_device *xe)
 	if (IS_VF_CCS_READY(xe))
 		xe_sriov_vf_ccs_register_context(xe);
=20
-	xe_late_bind_fw_load(&xe->late_bind);
+	xe_late_bind_pm_resume(&xe->late_bind);
=20
 	drm_dbg(&xe->drm, "Device resumed\n");
 	xe_pm_block_end_signalling();
@@ -461,6 +469,9 @@ static int xe_pm_notifier_callback(struct notifier_bloc=
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
@@ -485,6 +496,9 @@ static int xe_pm_notifier_callback(struct notifier_bloc=
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
@@ -707,7 +721,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 			xe_wa_apply_tile_workarounds(tile);
=20
 		for_each_gt(gt, xe, id)
-			xe_gt_idle_disable_c6(gt);
+			xe_gt_resume_early(gt);
=20
 		xe_display_pm_resume_early(xe);
=20
@@ -755,7 +769,7 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 		xe_sriov_vf_ccs_register_context(xe);
=20
 	if (xe->d3cold.allowed)
-		xe_late_bind_fw_load(&xe->late_bind);
+		xe_late_bind_pm_resume(&xe->late_bind);
=20
 out:
 	xe_rpm_lockmap_release(xe);

--Q0og5S7UwvY1pqPE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr7VDkACgkQJNaLcl1U
h9AIgQf/RYlRatVQCIYyNfee0N5sIiyP+grsVMn99s0hFOGp3w/dYiGsNhQGBrVK
2C1gHK04vLb+dB35WiV5SoEMry5fC4q5Fq3MHlGyaLuYGGEoVOIxv6pKfCHsljfp
A/16aMbe9HuXDEHLB3qusdynfuCTL5FMjEEVLg4C3nP4P4u4UEj6R+fXJsn18Se9
Nzg+KJjKV3Mwme89X6psC4W0xWdkjYVH/xHj7ovaOl6GLEiHuzpTYMx6AqIfPV43
r27Ubo4baP/AOQPkt+sAQkKWw7woHf2lKhU1P0u5VI8ztPm/OoG919hQ0aiiw9/x
cZBVzNqJ3Q8Z/GUPQRYmQPcH3WoIoA==
=a5ym
-----END PGP SIGNATURE-----

--Q0og5S7UwvY1pqPE--
